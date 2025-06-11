import Foundation
import Skia

public class SkPaint: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public convenience init() {
        self.init(handle: sk_paint_new())
    }

    deinit {
        // SkRefCnt already handles unref, but sk_paint_new returns a new ref, so we need to delete it.
        // This is a special case where the new() function doesn't return a ref-counted object.
        // The SkRefCnt base class handles unref for objects that are already ref-counted.
        // For SkPaint, we explicitly call sk_paint_delete.
        sk_paint_delete(handle)
    }

    public func reset() {
        sk_paint_reset(handle)
    }

    public var isAntiAlias: Bool {
        get { return sk_paint_is_antialias(handle) }
        set { sk_paint_set_antialias(handle, newValue) }
    }

    public var isDither: Bool {
        get { return sk_paint_is_dither(handle) }
        set { sk_paint_set_dither(handle, newValue) }
    }

    public var isVerticalText: Bool {
        get { return sk_paint_is_verticaltext(handle) }
        set { sk_paint_set_verticaltext(handle, newValue) }
    }

    public var color: SkColor {
        get { return sk_paint_get_color(handle) }
        set { sk_paint_set_color(handle, newValue) }
    }

    public var color4f: SkColor4f {
        get {
            var color = sk_color4f_t()
            sk_paint_get_color4f(handle, &color)
            return SkColor4f(color)
        }
        set {
            var color = newValue.skColor4f
            sk_paint_set_color4f(handle, &color)
        }
    }

    public var strokeWidth: Float {
        get { return sk_paint_get_stroke_width(handle) }
        set { sk_paint_set_stroke_width(handle, newValue) }
    }

    public var strokeMiter: Float {
        get { return sk_paint_get_stroke_miter(handle) }
        set { sk_paint_set_stroke_miter(handle, newValue) }
    }

    public var style: SkPaintStyle {
        get { return SkPaintStyle(sk_paint_get_style(handle)) }
        set { sk_paint_set_style(handle, newValue.skPaintStyle) }
    }

    public var strokeCap: SkPaintCap {
        get { return SkPaintCap(sk_paint_get_stroke_cap(handle)) }
        set { sk_paint_set_stroke_cap(handle, newValue.skPaintCap) }
    }

    public var strokeJoin: SkPaintJoin {
        get { return SkPaintJoin(sk_paint_get_stroke_join(handle)) }
        set { sk_paint_set_stroke_join(handle, newValue.skPaintJoin) }
    }

    public var blendMode: SkBlendMode {
        get { return SkBlendMode(sk_paint_get_blendmode(handle)) }
        set { sk_paint_set_blendmode(handle, newValue.skBlendMode) }
    }

    public var filterQuality: SkFilterQuality {
        get { return SkFilterQuality(sk_paint_get_filter_quality(handle)) }
        set { sk_paint_set_filter_quality(handle, newValue.skFilterQuality) }
    }

    public func setShader(_ shader: SkShader?) {
        sk_paint_set_shader(handle, shader?.handle)
    }

    public func setMaskFilter(_ maskFilter: SkMaskFilter?) {
        sk_paint_set_maskfilter(handle, maskFilter?.handle)
    }

    public func setColorFilter(_ colorFilter: SkColorFilter?) {
        sk_paint_set_colorfilter(handle, colorFilter?.handle)
    }

    public func setImageFilter(_ imageFilter: SkImageFilter?) {
        sk_paint_set_imagefilter(handle, imageFilter?.handle)
    }

    public func setPathEffect(_ pathEffect: SkPathEffect?) {
        sk_paint_set_patheffect(handle, pathEffect?.handle)
    }

    public func setTypeface(_ typeface: SkTypeface?) {
        sk_paint_set_typeface(handle, typeface?.handle)
    }

    public var textEncoding: SkTextEncoding {
        get { return SkTextEncoding(sk_paint_get_text_encoding(handle)) }
        set { sk_paint_set_text_encoding(handle, newValue.skTextEncoding) }
    }

    public var textSize: Float {
        get { return sk_paint_get_text_size(handle) }
        set { sk_paint_set_text_size(handle, newValue) }
    }

    public var textScaleX: Float {
        get { return sk_paint_get_text_scale_x(handle) }
        set { sk_paint_set_text_scale_x(handle, newValue) }
    }

    public var textSkewX: Float {
        get { return sk_paint_get_text_skew_x(handle) }
        set { sk_paint_set_text_skew_x(handle, newValue) }
    }

    public var hinting: SkPaintHinting {
        get { return SkPaintHinting(sk_paint_get_hinting(handle)) }
        set { sk_paint_set_hinting(handle, newValue.skPaintHinting) }
    }

    public func measureText(text: String, bounds: inout SkRect) -> Float {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            var skRect = bounds.skRect
            let result = sk_paint_measure_text(handle, ptr.baseAddress, ptr.count - 1, &skRect)
            bounds = SkRect(skRect)
            return result
        }
    }

    public func measureText(text: String) -> Float {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            sk_paint_measure_text(handle, ptr.baseAddress, ptr.count - 1, nil)
        }
    }

    public func getFontMetrics(metrics: inout SkFontMetrics, scale: Float) -> Float {
        var skMetrics = metrics.skFontMetrics
        let result = sk_paint_get_fontmetrics(handle, &skMetrics, scale)
        metrics = SkFontMetrics(skMetrics)
        return result
    }

    public func getFontMetrics(scale: Float) -> Float {
        return sk_paint_get_fontmetrics(handle, nil, scale)
    }

    public func getPosTextPath(text: String, pos: UnsafePointer<SkPoint>, path: SkPath) -> Int {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            let skPoints = pos.withMemoryRebound(to: sk_point_t.self, capacity: ptr.count) { $0 }
            return Int(sk_paint_get_pos_text_path(handle, ptr.baseAddress, ptr.count - 1, skPoints, path.handle))
        }
    }

    public func getPath(text: String, path: SkPath) -> Int {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            return Int(sk_paint_get_text_path(handle, ptr.baseAddress, ptr.count - 1, path.handle))
        }
    }

    public func getFillPath(src: SkPath, dst: SkPath, cullRect: SkRect?) -> Bool {
        var skCullRect: sk_rect_t? = cullRect?.skRect
        return sk_paint_get_fill_path(handle, src.handle, dst.handle, &skCullRect)
    }

    public func getFillPath(src: SkPath, dst: SkPath) -> Bool {
        return sk_paint_get_fill_path(handle, src.handle, dst.handle, nil)
    }

    public func canComputeFastBounds() -> Bool {
        return sk_paint_can_compute_fast_bounds(handle)
    }

    public func computeFastBounds(rect: SkRect, dst: inout SkRect) {
        var skRect = rect.skRect
        var skDst = dst.skRect
        sk_paint_compute_fast_bounds(handle, &skRect, &skDst)
        dst = SkRect(skDst)
    }

    public func nothingToDraw() -> Bool {
        return sk_paint_nothing_to_draw(handle)
    }
}

public enum SkPaintStyle: UInt32 {
    case fill = 0
    case stroke = 1
    case strokeAndFill = 2

    public init(_ style: sk_paint_style_t) {
        self = SkPaintStyle(rawValue: style.rawValue)!
    }

    public var skPaintStyle: sk_paint_style_t {
        return sk_paint_style_t(rawValue: self.rawValue)
    }
}

public enum SkPaintCap: UInt32 {
    case butt = 0
    case round = 1
    case square = 2

    public init(_ cap: sk_paint_cap_t) {
        self = SkPaintCap(rawValue: cap.rawValue)!
    }

    public var skPaintCap: sk_paint_cap_t {
        return sk_paint_cap_t(rawValue: self.rawValue)
    }
}

public enum SkPaintJoin: UInt32 {
    case miter = 0
    case round = 1
    case bevel = 2

    public init(_ join: sk_paint_join_t) {
        self = SkPaintJoin(rawValue: join.rawValue)!
    }

    public var skPaintJoin: sk_paint_join_t {
        return sk_paint_join_t(rawValue: self.rawValue)
    }
}

public enum SkPaintHinting: UInt32 {
    case none = 0
    case slight = 1
    case normal = 2
    case full = 3

    public init(_ hinting: sk_paint_hinting_t) {
        self = SkPaintHinting(rawValue: hinting.rawValue)!
    }

    public var skPaintHinting: sk_paint_hinting_t {
        return sk_paint_hinting_t(rawValue: self.rawValue)
    }
}

public enum SkTextEncoding: UInt32 {
    case utf8 = 0
    case utf16 = 1
    case utf32 = 2
    case glyphId = 3

    public init(_ encoding: sk_text_encoding_t) {
        self = SkTextEncoding(rawValue: encoding.rawValue)!
    }

    public var skTextEncoding: sk_text_encoding_t {
        return sk_text_encoding_t(rawValue: self.rawValue)
    }
}

public struct SkFontMetrics {
    public var flags: UInt32
    public var top: Float
    public var ascent: Float
    public var descent: Float
    public var bottom: Float
    public var leading: Float
    public var avgCharWidth: Float
    public var xMin: Float
    public var xMax: Float
    public var xHeight: Float
    public var capHeight: Float
    public var underlineThickness: Float
    public var underlinePosition: Float
    public var strikeoutThickness: Float
    public var strikeoutPosition: Float

    public init(_ metrics: sk_fontmetrics_t) {
        self.flags = metrics.fFlags
        self.top = metrics.fTop
        self.ascent = metrics.fAscent
        self.descent = metrics.fDescent
        self.bottom = metrics.fBottom
        self.leading = metrics.fLeading
        self.avgCharWidth = metrics.fAvgCharWidth
        self.xMin = metrics.fXMin
        self.xMax = metrics.fXMax
        self.xHeight = metrics.fXHeight
        self.capHeight = metrics.fCapHeight
        self.underlineThickness = metrics.fUnderlineThickness
        self.underlinePosition = metrics.fUnderlinePosition
        self.strikeoutThickness = metrics.fStrikeoutThickness
        self.strikeoutPosition = metrics.fStrikeoutPosition
    }

    public var skFontMetrics: sk_fontmetrics_t {
        return sk_fontmetrics_t(
            fFlags: flags,
            fTop: top,
            fAscent: ascent,
            fDescent: descent,
            fBottom: bottom,
            fLeading: leading,
            fAvgCharWidth: avgCharWidth,
            fXMin: xMin,
            fXMax: xMax,
            fXHeight: xHeight,
            fCapHeight: capHeight,
            fUnderlineThickness: underlineThickness,
            fUnderlinePosition: underlinePosition,
            fStrikeoutThickness: strikeoutThickness,
            fStrikeoutPosition: strikeoutPosition
        )
    }
}