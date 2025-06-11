import Foundation
import Skia

public class SkFont: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public convenience init(typeface: SkTypeface?, size: Float, scaleX: Float, skewX: Float) {
        self.init(handle: sk_font_new(typeface?.handle, size, scaleX, skewX))
    }

    public convenience init(typeface: SkTypeface?, size: Float) {
        self.init(handle: sk_font_new(typeface?.handle, size, 1.0, 0.0))
    }

    public convenience init() {
        self.init(handle: sk_font_new(nil, 0, 1.0, 0.0))
    }

    public func setTypeface(_ typeface: SkTypeface?) {
        sk_font_set_typeface(handle, typeface?.handle)
    }

    public var typeface: SkTypeface? {
        guard let typefaceHandle = sk_font_get_typeface(handle) else { return nil }
        return SkTypeface(handle: typefaceHandle)
    }

    public var size: Float {
        get { return sk_font_get_size(handle) }
        set { sk_font_set_size(handle, newValue) }
    }

    public var scaleX: Float {
        get { return sk_font_get_scale_x(handle) }
        set { sk_font_set_scale_x(handle, newValue) }
    }

    public var skewX: Float {
        get { return sk_font_get_skew_x(handle) }
        set { sk_font_set_skew_x(handle, newValue) }
    }

    public var isEmbolden: Bool {
        get { return sk_font_is_embolden(handle) }
        set { sk_font_set_embolden(handle, newValue) }
    }

    public var isSubpixel: Bool {
        get { return sk_font_is_subpixel(handle) }
        set { sk_font_set_subpixel(handle, newValue) }
    }

    public var isLinearMetrics: Bool {
        get { return sk_font_is_linear_metrics(handle) }
        set { sk_font_set_linear_metrics(handle, newValue) }
    }

    public var isEmbeddedBitmaps: Bool {
        get { return sk_font_is_embedded_bitmaps(handle) }
        set { sk_font_set_embedded_bitmaps(handle, newValue) }
    }

    public var isForceAutoHinting: Bool {
        get { return sk_font_is_force_auto_hinting(handle) }
        set { sk_font_set_force_auto_hinting(handle, newValue) }
    }

    public var isAntialias: Bool {
        get { return sk_font_is_antialias(handle) }
        set { sk_font_set_antialias(handle, newValue) }
    }

    public var isVerticalText: Bool {
        get { return sk_font_is_verticaltext(handle) }
        set { sk_font_set_verticaltext(handle, newValue) }
    }

    public var isBaselineSnap: Bool {
        get { return sk_font_is_baseline_snap(handle) }
        set { sk_font_set_baseline_snap(handle, newValue) }
    }

    public var hinting: SkFontHinting {
        get { return SkFontHinting(sk_font_get_hinting(handle)) }
        set { sk_font_set_hinting(handle, newValue.skFontHinting) }
    }

    public func measureText(text: String, bounds: inout SkRect, paint: SkPaint?) -> Float {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            var skRect = bounds.skRect
            let result = sk_font_measure_text(handle, ptr.baseAddress, ptr.count - 1, &skRect, paint?.handle)
            bounds = SkRect(skRect)
            return result
        }
    }

    public func measureText(text: String, paint: SkPaint?) -> Float {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            sk_font_measure_text(handle, ptr.baseAddress, ptr.count - 1, nil, paint?.handle)
        }
    }

    public func getWidths(text: String, widths: inout [Float], paint: SkPaint?) -> Int {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            let count = Int(sk_font_get_widths(handle, ptr.baseAddress, ptr.count - 1, &widths, paint?.handle))
            widths = Array(widths.prefix(count))
            return count
        }
    }

    public func getPos(text: String, positions: inout [SkPoint], paint: SkPaint?) -> Int {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            var skPositions = positions.map { $0.skPoint }
            let count = Int(sk_font_get_pos(handle, ptr.baseAddress, ptr.count - 1, &skPositions, paint?.handle))
            positions = skPositions.prefix(count).map { SkPoint($0) }
            return count
        }
    }

    public func getXPos(text: String, xpos: inout [Float], paint: SkPaint?) -> Int {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            let count = Int(sk_font_get_xpos(handle, ptr.baseAddress, ptr.count - 1, &xpos, paint?.handle))
            xpos = Array(xpos.prefix(count))
            return count
        }
    }

    public func getPath(glyphID: UInt16, path: SkPath) -> Bool {
        return sk_font_get_path(handle, glyphID, path.handle)
    }

    public func getPaths(glyphIDs: [UInt16], paths: inout [SkPath]) {
        let cPaths = paths.map { $0.handle }
        glyphIDs.withUnsafeBufferPointer { glyphPtr in
            cPaths.withUnsafeBufferPointer { pathPtr in
                sk_font_get_paths(handle, glyphPtr.baseAddress, Int32(glyphIDs.count), pathPtr.baseAddress)
            }
        }
    }

    public func getMetrics(metrics: inout SkFontMetrics) -> Float {
        var skMetrics = metrics.skFontMetrics
        let result = sk_font_get_metrics(handle, &skMetrics)
        metrics = SkFontMetrics(skMetrics)
        return result
    }

    public func getMetrics() -> Float {
        return sk_font_get_metrics(handle, nil)
    }

    public var spacing: Float {
        return sk_font_get_spacing(handle)
    }

    public func textToGlyphs(text: String, glyphs: inout [UInt16]) -> Int {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            let count = Int(sk_font_text_to_glyphs(handle, ptr.baseAddress, ptr.count - 1, &glyphs))
            glyphs = Array(glyphs.prefix(count))
            return count
        }
    }

    public func countTextGlyphs(text: String) -> Int {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            Int(sk_font_count_text_glyphs(handle, ptr.baseAddress, ptr.count - 1))
        }
    }

    public func containsText(text: String) -> Bool {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            sk_font_contains_text(handle, ptr.baseAddress, ptr.count - 1)
        }
    }
}

public enum SkFontHinting: UInt32 {
    case none = 0
    case slight = 1
    case normal = 2
    case full = 3

    public init(_ hinting: sk_font_hinting_t) {
        self = SkFontHinting(rawValue: hinting.rawValue)!
    }

    public var skFontHinting: sk_font_hinting_t {
        return sk_font_hinting_t(rawValue: self.rawValue)
    }
}