import Foundation
import Skia

public class SkBitmap {
    public var handle: OpaquePointer?

    public convenience init() {
        self.init(handle: sk_bitmap_new())
    }

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_bitmap_destructor(handle)
    }

    public var info: SkImageInfo {
        var skInfo = sk_imageinfo_t()
        sk_bitmap_get_info(handle, &skInfo)
        return SkImageInfo(skInfo)
    }

    public var pixels: Data? {
        var length: size_t = 0
        guard let ptr = sk_bitmap_get_pixels(handle, &length) else { return nil }
        return Data(bytes: ptr, count: length)
    }

    public var rowBytes: Int {
        return Int(sk_bitmap_get_row_bytes(handle))
    }

    public var byteCount: Int {
        return Int(sk_bitmap_get_byte_count(handle))
    }

    public func reset() {
        sk_bitmap_reset(handle)
    }

    public var isNull: Bool {
        return sk_bitmap_is_null(handle)
    }

    public var isImmutable: Bool {
        return sk_bitmap_is_immutable(handle)
    }

    public func setImmutable() {
        sk_bitmap_set_immutable(handle)
    }

    public func erase(color: SkColor) {
        sk_bitmap_erase(handle, color)
    }

    public func erase(color: SkColor, rect: SkIRect) {
        var skRect = rect.skIRect
        sk_bitmap_erase_rect(handle, color, &skRect)
    }

    public func getAddr8(x: Int, y: Int) -> UnsafeMutablePointer<UInt8>? {
        return sk_bitmap_get_addr_8(handle, Int32(x), Int32(y))
    }

    public func getAddr16(x: Int, y: Int) -> UnsafeMutablePointer<UInt16>? {
        return sk_bitmap_get_addr_16(handle, Int32(x), Int32(y))
    }

    public func getAddr32(x: Int, y: Int) -> UnsafeMutablePointer<UInt32>? {
        return sk_bitmap_get_addr_32(handle, Int32(x), Int32(y))
    }

    public func getAddr(x: Int, y: Int) -> UnsafeMutableRawPointer? {
        return sk_bitmap_get_addr(handle, Int32(x), Int32(y))
    }

    public func getPixelColor(x: Int, y: Int) -> SkColor {
        return sk_bitmap_get_pixel_color(handle, Int32(x), Int32(y))
    }

    public var readyToDraw: Bool {
        return sk_bitmap_ready_to_draw(handle)
    }

    public func getPixelColors(colors: inout [SkColor]) {
        colors.withUnsafeMutableBufferPointer { ptr in
            sk_bitmap_get_pixel_colors(handle, ptr.baseAddress)
        }
    }

    public func installPixels(info: SkImageInfo, pixels: UnsafeMutableRawPointer, rowBytes: Int, releaseProc: sk_bitmap_release_proc?, context: UnsafeMutableRawPointer?) -> Bool {
        var skInfo = info.skImageInfo
        return sk_bitmap_install_pixels(handle, &skInfo, pixels, rowBytes, releaseProc, context)
    }

    public func installPixels(pixmap: SkPixmap) -> Bool {
        return sk_bitmap_install_pixels_with_pixmap(handle, pixmap.handle)
    }

    public func tryAllocPixels(requestedInfo: SkImageInfo, rowBytes: Int) -> Bool {
        var skRequestedInfo = requestedInfo.skImageInfo
        return sk_bitmap_try_alloc_pixels(handle, &skRequestedInfo, rowBytes)
    }

    public func tryAllocPixels(requestedInfo: SkImageInfo, flags: SkBitmapAllocFlags) -> Bool {
        var skRequestedInfo = requestedInfo.skImageInfo
        return sk_bitmap_try_alloc_pixels_with_flags(handle, &skRequestedInfo, flags.rawValue)
    }

    public func setPixels(pixels: UnsafeMutableRawPointer) {
        sk_bitmap_set_pixels(handle, pixels)
    }

    public func peekPixels(pixmap: SkPixmap) -> Bool {
        return sk_bitmap_peek_pixels(handle, pixmap.handle)
    }

    public func extractSubset(dst: SkBitmap, subset: SkIRect) -> Bool {
        var skSubset = subset.skIRect
        return sk_bitmap_extract_subset(handle, dst.handle, &skSubset)
    }

    public func extractAlpha(dst: SkBitmap, paint: SkPaint?, offset: inout SkIPoint) -> Bool {
        var skOffset = offset.skIPoint
        let result = sk_bitmap_extract_alpha(handle, dst.handle, paint?.handle, &skOffset)
        offset = SkIPoint(skOffset)
        return result
    }

    public func notifyPixelsChanged() {
        sk_bitmap_notify_pixels_changed(handle)
    }

    public func swap(other: SkBitmap) {
        sk_bitmap_swap(handle, other.handle)
    }

    public func makeShader(tileModeX: SkShaderTileMode, tileModeY: SkShaderTileMode, sampling: SkSamplingOptions?, matrix: SkMatrix?) -> SkShader? {
        var skSamplingOptions: sk_sampling_options_t? = sampling?.skSamplingOptions
        var skMatrix: sk_matrix_t? = matrix?.skMatrix
        guard let shaderHandle = sk_bitmap_make_shader(handle, tileModeX.skShaderTileMode, tileModeY.skShaderTileMode, &skSamplingOptions, &skMatrix) else { return nil }
        return SkShader(handle: shaderHandle)
    }
}

public struct SkBitmapAllocFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let zeroPixels = SkBitmapAllocFlags(rawValue: ZERO_PIXELS_SK_BITMAP_ALLOC_FLAGS.rawValue)
}