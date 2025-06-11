import Foundation
import Skia

public class SkCanvas {
    public var handle: OpaquePointer?

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_canvas_destroy(handle)
    }

    public func clear(color: SkColor) {
        sk_canvas_clear(handle, color)
    }

    public func clear(color: SkColor4f) {
        var skColor4f = color.skColor4f
        sk_canvas_clear_color4f(handle, skColor4f)
    }

    public func discard() {
        sk_canvas_discard(handle)
    }

    public var saveCount: Int {
        return Int(sk_canvas_get_save_count(handle))
    }

    public func restoreToCount(_ saveCount: Int) {
        sk_canvas_restore_to_count(handle, Int32(saveCount))
    }

    public func drawColor(color: SkColor, blendMode: SkBlendMode) {
        sk_canvas_draw_color(handle, color, blendMode.skBlendMode)
    }

    public func drawColor(color: SkColor4f, blendMode: SkBlendMode) {
        var skColor4f = color.skColor4f
        sk_canvas_draw_color4f(handle, skColor4f, blendMode.skBlendMode)
    }

    public func drawPoints(pointMode: SkPointMode, points: [SkPoint], paint: SkPaint) {
        let skPoints = points.map { $0.skPoint }
        skPoints.withUnsafeBufferPointer { ptr in
            sk_canvas_draw_points(handle, pointMode.skPointMode, ptr.count, ptr.baseAddress, paint.handle)
        }
    }

    public func drawPoint(x: Float, y: Float, paint: SkPaint) {
        sk_canvas_draw_point(handle, x, y, paint.handle)
    }

    public func drawLine(x0: Float, y0: Float, x1: Float, y1: Float, paint: SkPaint) {
        sk_canvas_draw_line(handle, x0, y0, x1, y1, paint.handle)
    }

    public func drawSimpleText(text: String, encoding: SkTextEncoding, x: Float, y: Float, font: SkFont, paint: SkPaint) {
        let utf8 = text.utf8CString
        utf8.withUnsafeBufferPointer { ptr in
            sk_canvas_draw_simple_text(handle, ptr.baseAddress, ptr.count - 1, encoding.skTextEncoding, x, y, font.handle, paint.handle)
        }
    }

    public func drawTextBlob(textBlob: SkTextBlob, x: Float, y: Float, paint: SkPaint) {
        sk_canvas_draw_text_blob(handle, textBlob.handle, x, y, paint.handle)
    }

    public func resetMatrix() {
        sk_canvas_reset_matrix(handle)
    }

    public func setMatrix(_ matrix: SkMatrix44) {
        var skMatrix = matrix.skMatrix44
        sk_canvas_set_matrix(handle, &skMatrix)
    }

    public func getMatrix() -> SkMatrix44 {
        var skMatrix = sk_matrix44_t()
        sk_canvas_get_matrix(handle, &skMatrix)
        return SkMatrix44(skMatrix)
    }

    public func drawRoundRect(rect: SkRect, rx: Float, ry: Float, paint: SkPaint) {
        var skRect = rect.skRect
        sk_canvas_draw_round_rect(handle, &skRect, rx, ry, paint.handle)
    }

    public func clipRect(rect: SkRect, operation: SkClipOp, doAA: Bool) {
        var skRect = rect.skRect
        sk_canvas_clip_rect_with_operation(handle, &skRect, operation.skClipOp, doAA)
    }

    public func clipPath(path: SkPath, operation: SkClipOp, doAA: Bool) {
        sk_canvas_clip_path_with_operation(handle, path.handle, operation.skClipOp, doAA)
    }

    public func clipRRect(rrect: SkRRect, operation: SkClipOp, doAA: Bool) {
        var skRRect = rrect.skRRect
        sk_canvas_clip_rrect_with_operation(handle, &skRRect, operation.skClipOp, doAA)
    }

    public func getLocalClipBounds() -> SkRect? {
        var skRect = sk_rect_t()
        if sk_canvas_get_local_clip_bounds(handle, &skRect) {
            return SkRect(skRect)
        }
        return nil
    }

    public func getDeviceClipBounds() -> SkIRect? {
        var skIRect = sk_irect_t()
        if sk_canvas_get_device_clip_bounds(handle, &skIRect) {
            return SkIRect(skIRect)
        }
        return nil
    }

    public func save() -> Int {
        return Int(sk_canvas_save(handle))
    }

    public func saveLayer(rect: SkRect?, paint: SkPaint?) -> Int {
        var skRect: sk_rect_t? = rect?.skRect
        return Int(sk_canvas_save_layer(handle, &skRect, paint?.handle))
    }

    public func saveLayer(rec: SkCanvasSaveLayerRec) -> Int {
        var skRec = rec.skCanvasSaveLayerRec
        return Int(sk_canvas_save_layer_rec(handle, &skRec))
    }

    public func restore() {
        sk_canvas_restore(handle)
    }

    public func translate(dx: Float, dy: Float) {
        sk_canvas_translate(handle, dx, dy)
    }

    public func scale(sx: Float, sy: Float) {
        sk_canvas_scale(handle, sx, sy)
    }

    public func rotate(degrees: Float) {
        sk_canvas_rotate_degrees(handle, degrees)
    }

    public func rotate(radians: Float) {
        sk_canvas_rotate_radians(handle, radians)
    }

    public func skew(sx: Float, sy: Float) {
        sk_canvas_skew(handle, sx, sy)
    }

    public func concat(_ matrix: SkMatrix44) {
        var skMatrix = matrix.skMatrix44
        sk_canvas_concat(handle, &skMatrix)
    }

    public func quickReject(rect: SkRect) -> Bool {
        var skRect = rect.skRect
        return sk_canvas_quick_reject(handle, &skRect)
    }

    public func clipRegion(region: SkRegion, operation: SkClipOp) {
        sk_canvas_clip_region(handle, region.handle, operation.skClipOp)
    }

    public func drawPaint(paint: SkPaint) {
        sk_canvas_draw_paint(handle, paint.handle)
    }

    public func drawRegion(region: SkRegion, paint: SkPaint) {
        sk_canvas_draw_region(handle, region.handle, paint.handle)
    }

    public func drawRect(rect: SkRect, paint: SkPaint) {
        var skRect = rect.skRect
        sk_canvas_draw_rect(handle, &skRect, paint.handle)
    }

    public func drawRRect(rrect: SkRRect, paint: SkPaint) {
        var skRRect = rrect.skRRect
        sk_canvas_draw_rrect(handle, &skRRect, paint.handle)
    }

    public func drawCircle(cx: Float, cy: Float, radius: Float, paint: SkPaint) {
        sk_canvas_draw_circle(handle, cx, cy, radius, paint.handle)
    }

    public func drawOval(rect: SkRect, paint: SkPaint) {
        var skRect = rect.skRect
        sk_canvas_draw_oval(handle, &skRect, paint.handle)
    }

    public func drawPath(path: SkPath, paint: SkPaint) {
        sk_canvas_draw_path(handle, path.handle, paint.handle)
    }

    public func drawImage(image: SkImage, x: Float, y: Float, sampling: SkSamplingOptions?, paint: SkPaint?) {
        var skSamplingOptions: sk_sampling_options_t? = sampling?.skSamplingOptions
        sk_canvas_draw_image(handle, image.handle, x, y, &skSamplingOptions, paint?.handle)
    }

    public func drawImageRect(image: SkImage, srcRect: SkRect, dstRect: SkRect, sampling: SkSamplingOptions?, paint: SkPaint?) {
        var skSrcRect = srcRect.skRect
        var skDstRect = dstRect.skRect
        var skSamplingOptions: sk_sampling_options_t? = sampling?.skSamplingOptions
        sk_canvas_draw_image_rect(handle, image.handle, &skSrcRect, &skDstRect, &skSamplingOptions, paint?.handle)
    }

    public func drawPicture(picture: SkPicture, matrix: SkMatrix?, paint: SkPaint?) {
        var skMatrix: sk_matrix_t? = matrix?.skMatrix
        sk_canvas_draw_picture(handle, picture.handle, &skMatrix, paint?.handle)
    }

    public func drawDrawable(drawable: SkDrawable, matrix: SkMatrix?) {
        var skMatrix: sk_matrix_t? = matrix?.skMatrix
        sk_canvas_draw_drawable(handle, drawable.handle, &skMatrix)
    }

    public convenience init?(bitmap: SkBitmap) {
        guard let handle = sk_canvas_new_from_bitmap(bitmap.handle) else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(rasterInfo: SkImageInfo, pixels: UnsafeMutableRawPointer, rowBytes: Int, props: SkSurfaceProps?) {
        var skInfo = rasterInfo.skImageInfo
        var skProps: sk_surfaceprops_t? = props?.skSurfaceProps
        guard let handle = sk_canvas_new_from_raster(&skInfo, pixels, rowBytes, &skProps) else { return nil }
        self.init(handle: handle)
    }

    public func drawAnnotation(rect: SkRect, key: String, value: SkData) {
        var skRect = rect.skRect
        let cKey = key.cString(using: .utf8)!
        cKey.withUnsafeBufferPointer { ptr in
            sk_canvas_draw_annotation(handle, &skRect, ptr.baseAddress, value.handle)
        }
    }

    public func drawURLAnnotation(rect: SkRect, value: SkData) {
        var skRect = rect.skRect
        sk_canvas_draw_url_annotation(handle, &skRect, value.handle)
    }

    public func drawNamedDestinationAnnotation(point: SkPoint, value: SkData) {
        var skPoint = point.skPoint
        sk_canvas_draw_named_destination_annotation(handle, &skPoint, value.handle)
    }

    public func drawLinkDestinationAnnotation(rect: SkRect, value: SkData) {
        var skRect = rect.skRect
        sk_canvas_draw_link_destination_annotation(handle, &skRect, value.handle)
    }

    public func drawImageLattice(image: SkImage, lattice: SkLattice, dst: SkRect, filterMode: SkFilterMode, paint: SkPaint?) {
        var skDst = dst.skRect
        var skLattice = lattice.skLattice
        sk_canvas_draw_image_lattice(handle, image.handle, &skLattice, &skDst, filterMode.skFilterMode, paint?.handle)
    }

    public func drawImageNine(image: SkImage, center: SkIRect, dst: SkRect, filterMode: SkFilterMode, paint: SkPaint?) {
        var skCenter = center.skIRect
        var skDst = dst.skRect
        sk_canvas_draw_image_nine(handle, image.handle, &skCenter, &skDst, filterMode.skFilterMode, paint?.handle)
    }

    public func drawVertices(vertices: SkVertices, blendMode: SkBlendMode, paint: SkPaint) {
        sk_canvas_draw_vertices(handle, vertices.handle, blendMode.skBlendMode, paint.handle)
    }

    public func drawArc(oval: SkRect, startAngle: Float, sweepAngle: Float, useCenter: Bool, paint: SkPaint) {
        var skOval = oval.skRect
        sk_canvas_draw_arc(handle, &skOval, startAngle, sweepAngle, useCenter, paint.handle)
    }

    public func drawDRRect(outer: SkRRect, inner: SkRRect, paint: SkPaint) {
        var skOuter = outer.skRRect
        var skInner = inner.skRRect
        sk_canvas_draw_drrect(handle, &skOuter, &skInner, paint.handle)
    }

    public func drawAtlas(atlas: SkImage, xform: [SkRSXform], tex: [SkRect], colors: [SkColor]?, count: Int, blendMode: SkBlendMode, sampling: SkSamplingOptions?, cullRect: SkRect?, paint: SkPaint?) {
        let skXform = xform.map { $0.skRSXform }
        let skTex = tex.map { $0.skRect }
        let skColors = colors?.map { $0 }
        var skSamplingOptions: sk_sampling_options_t? = sampling?.skSamplingOptions
        var skCullRect: sk_rect_t? = cullRect?.skRect

        skXform.withUnsafeBufferPointer { xformPtr in
            skTex.withUnsafeBufferPointer { texPtr in
                skColors?.withUnsafeBufferPointer { colorsPtr in
                    sk_canvas_draw_atlas(handle, atlas.handle, xformPtr.baseAddress, texPtr.baseAddress, colorsPtr.baseAddress, Int32(count), blendMode.skBlendMode, &skSamplingOptions, &skCullRect, paint?.handle)
                } ?? sk_canvas_draw_atlas(handle, atlas.handle, xformPtr.baseAddress, texPtr.baseAddress, nil, Int32(count), blendMode.skBlendMode, &skSamplingOptions, &skCullRect, paint?.handle)
            }
        }
    }

    public func drawPatch(cubics: [SkPoint], colors: [SkColor]?, texCoords: [SkPoint]?, blendMode: SkBlendMode, paint: SkPaint) {
        let skCubics = cubics.map { $0.skPoint }
        let skColors = colors?.map { $0 }
        let skTexCoords = texCoords?.map { $0.skPoint }

        skCubics.withUnsafeBufferPointer { cubicsPtr in
            skColors?.withUnsafeBufferPointer { colorsPtr in
                skTexCoords?.withUnsafeBufferPointer { texCoordsPtr in
                    sk_canvas_draw_patch(handle, cubicsPtr.baseAddress, colorsPtr.baseAddress, texCoordsPtr.baseAddress, blendMode.skBlendMode, paint.handle)
                } ?? sk_canvas_draw_patch(handle, cubicsPtr.baseAddress, colorsPtr.baseAddress, nil, blendMode.skBlendMode, paint.handle)
            } ?? sk_canvas_draw_patch(handle, cubicsPtr.baseAddress, nil, nil, blendMode.skBlendMode, paint.handle)
        }
    }

    public var isClipEmpty: Bool {
        return sk_canvas_is_clip_empty(handle)
    }

    public var isClipRect: Bool {
        return sk_canvas_is_clip_rect(handle)
    }

    public var recordingContext: OpaquePointer? { // gr_recording_context_t*
        return sk_get_recording_context(handle)
    }

    public var surface: OpaquePointer? { // sk_surface_t*
        return sk_get_surface(handle)
    }
}

public enum SkPointMode: UInt32 {
    case points = 0
    case lines = 1
    case polygon = 2

    public init(_ mode: sk_point_mode_t) {
        self = SkPointMode(rawValue: mode.rawValue)!
    }

    public var skPointMode: sk_point_mode_t {
        return sk_point_mode_t(rawValue: self.rawValue)
    }
}

public enum SkClipOp: UInt32 {
    case difference = 0
    case intersect = 1

    public init(_ op: sk_clipop_t) {
        self = SkClipOp(rawValue: op.rawValue)!
    }

    public var skClipOp: sk_clipop_t {
        return sk_clipop_t(rawValue: self.rawValue)
    }
}

public struct SkCanvasSaveLayerRec {
    public var bounds: SkRect?
    public var paint: SkPaint?
    public var backdrop: SkImageFilter?
    public var flags: SkCanvasSaveLayerFlags

    public init(bounds: SkRect? = nil, paint: SkPaint? = nil, backdrop: SkImageFilter? = nil, flags: SkCanvasSaveLayerFlags = []) {
        self.bounds = bounds
        self.paint = paint
        self.backdrop = backdrop
        self.flags = flags
    }

    public var skCanvasSaveLayerRec: sk_canvas_savelayerrec_t {
        var rec = sk_canvas_savelayerrec_t()
        rec.fBounds = bounds?.skRect
        rec.fPaint = paint?.handle
        rec.fBackdrop = backdrop?.handle
        rec.fFlags = flags.rawValue
        return rec
    }
}

public struct SkCanvasSaveLayerFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let initWithPrevious = SkCanvasSaveLayerFlags(rawValue: INIT_WITH_PREVIOUS_SK_CANVAS_SAVE_LAYER_FLAGS.rawValue)
    public static let preserveLCDText = SkCanvasSaveLayerFlags(rawValue: PRESERVE_LCD_TEXT_SK_CANVAS_SAVE_LAYER_FLAGS.rawValue)
    public static let clipToLayerBounds = SkCanvasSaveLayerFlags(rawValue: CLIP_TO_LAYER_BOUNDS_SK_CANVAS_SAVE_LAYER_FLAGS.rawValue)
    public static let dontHwAccelerate = SkCanvasSaveLayerFlags(rawValue: DONT_HW_ACCELERATE_SK_CANVAS_SAVE_LAYER_FLAGS.rawValue)
}

// MARK: - Special Canvas Types

public class SkNoDrawCanvas {
    public var handle: OpaquePointer?

    public init(width: Int, height: Int) {
        self.handle = sk_nodraw_canvas_new(Int32(width), Int32(height))
    }

    deinit {
        sk_nodraw_canvas_destroy(handle)
    }
}

public class SkNWayCanvas {
    public var handle: OpaquePointer?

    public init(width: Int, height: Int) {
        self.handle = sk_nway_canvas_new(Int32(width), Int32(height))
    }

    deinit {
        sk_nway_canvas_destroy(handle)
    }

    public func addCanvas(_ canvas: SkCanvas) {
        sk_nway_canvas_add_canvas(handle, canvas.handle)
    }

    public func removeCanvas(_ canvas: SkCanvas) {
        sk_nway_canvas_remove_canvas(handle, canvas.handle)
    }

    public func removeAll() {
        sk_nway_canvas_remove_all(handle)
    }
}

public class SkOverdrawCanvas {
    public var handle: OpaquePointer?

    public init(canvas: SkCanvas) {
        self.handle = sk_overdraw_canvas_new(canvas.handle)
    }

    deinit {
        sk_overdraw_canvas_destroy(handle)
    }
}