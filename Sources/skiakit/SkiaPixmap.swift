import Foundation
import CSkia

public class SkPixmap {
    public var handle: OpaquePointer?

    public init() {
        self.handle = sk_pixmap_new()
    }

    public init(info: SkImageInfo, addr: UnsafeRawPointer?, rowBytes: Int) {
        var skInfo = info.skImageInfo
        self.handle = sk_pixmap_new_with_params(&skInfo, addr, rowBytes)
    }

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_pixmap_destructor(handle)
    }

    public func reset() {
        sk_pixmap_reset(handle)
    }

    public func reset(info: SkImageInfo, addr: UnsafeRawPointer?, rowBytes: Int) {
        var skInfo = info.skImageInfo
        sk_pixmap_reset_with_params(handle, &skInfo, addr, rowBytes)
    }

    public func setColorSpace(_ colorspace: OpaquePointer?) { // sk_colorspace_t*
        sk_pixmap_set_colorspace(handle, colorspace)
    }

    public func extractSubset(result: SkPixmap, subset: SkIRect) -> Bool {
        var skSubset = subset.skIRect
        return sk_pixmap_extract_subset(handle, result.handle, &skSubset)
    }

    public var info: SkImageInfo {
        var skInfo = sk_imageinfo_t()
        sk_pixmap_get_info(handle, &skInfo)
        return SkImageInfo(skInfo)
    }

    public var rowBytes: Int {
        return Int(sk_pixmap_get_row_bytes(handle))
    }

    public var colorSpace: OpaquePointer? { // sk_colorspace_t*
        return sk_pixmap_get_colorspace(handle)
    }

    public var computeIsOpaque: Bool {
        return sk_pixmap_compute_is_opaque(handle)
    }

    public func getPixelColor(x: Int, y: Int) -> SkColor {
        return sk_pixmap_get_pixel_color(handle, Int32(x), Int32(y))
    }

    public func getPixelColor4f(x: Int, y: Int) -> SkColor4f {
        var color4f = sk_color4f_t()
        sk_pixmap_get_pixel_color4f(handle, Int32(x), Int32(y), &color4f)
        return SkColor4f(color4f)
    }

    public func getPixelAlphaf(x: Int, y: Int) -> Float {
        return sk_pixmap_get_pixel_alphaf(handle, Int32(x), Int32(y))
    }

    public var writableAddr: UnsafeMutableRawPointer? {
        return sk_pixmap_get_writable_addr(handle)
    }

    public func getWriteableAddr(x: Int, y: Int) -> UnsafeMutableRawPointer? {
        return sk_pixmap_get_writeable_addr_with_xy(handle, Int32(x), Int32(y))
    }

    public func readPixels(dstInfo: SkImageInfo, dstPixels: UnsafeMutableRawPointer, dstRowBytes: Int, srcX: Int, srcY: Int) -> Bool {
        var info = dstInfo.skImageInfo
        return sk_pixmap_read_pixels(handle, &info, dstPixels, dstRowBytes, Int32(srcX), Int32(srcY))
    }

    public func scalePixels(dst: SkPixmap, sampling: SkSamplingOptions) -> Bool {
        return sk_pixmap_scale_pixels(handle, dst.handle, sampling.skSamplingOptions)
    }

    public func eraseColor(color: SkColor, subset: SkIRect?) -> Bool {
        var skSubset: sk_irect_t? = subset?.skIRect
        return sk_pixmap_erase_color(handle, color, &skSubset)
    }

    public func eraseColor(color: SkColor4f, subset: SkIRect?) -> Bool {
        var skColor4f = color.skColor4f
        var skSubset: sk_irect_t? = subset?.skIRect
        return sk_pixmap_erase_color4f(handle, &skColor4f, &skSubset)
    }

    // MARK: - Encoders

    public static func webpEncoderEncode(dst: SkWStream, src: SkPixmap, options: SkWebpEncoderOptions) -> Bool {
        var skOptions = options.skWebpEncoderOptions
        return sk_webpencoder_encode(dst.handle, src.handle, &skOptions)
    }

    public static func jpegEncoderEncode(dst: SkWStream, src: SkPixmap, options: SkJPEGEncoderOptions) -> Bool {
        var skOptions = options.skJPEGEncoderOptions
        return sk_jpegencoder_encode(dst.handle, src.handle, &skOptions)
    }

    public static func pngEncoderEncode(dst: SkWStream, src: SkPixmap, options: SkPNGEncoderOptions) -> Bool {
        var skOptions = options.skPNGEncoderOptions
        return sk_pngencoder_encode(dst.handle, src.handle, &skOptions)
    }

    // MARK: - SkSwizzle

    public static func swizzleSwapRB(dest: UnsafeMutablePointer<UInt32>, src: UnsafePointer<UInt32>, count: Int) {
        sk_swizzle_swap_rb(dest, src, Int32(count))
    }

    // MARK: - SkColor

    public static func colorUnpremultiply(pmcolor: SkPMColor) -> SkColor {
        return sk_color_unpremultiply(pmcolor)
    }

    public static func colorPremultiply(color: SkColor) -> SkPMColor {
        return sk_color_premultiply(color)
    }

    public static func colorUnpremultiplyArray(pmcolors: UnsafePointer<SkPMColor>, size: Int, colors: UnsafeMutablePointer<SkColor>) {
        sk_color_unpremultiply_array(pmcolors, Int32(size), colors)
    }

    public static func colorPremultiplyArray(colors: UnsafePointer<SkColor>, size: Int, pmcolors: UnsafeMutablePointer<SkPMColor>) {
        sk_color_premultiply_array(colors, Int32(size), pmcolors)
    }

    public static func colorGetBitShift(a: inout Int, r: inout Int, g: inout Int, b: inout Int) {
        var ca: Int32 = 0, cr: Int32 = 0, cg: Int32 = 0, cb: Int32 = 0
        sk_color_get_bit_shift(&ca, &cr, &cg, &cb)
        a = Int(ca)
        r = Int(cr)
        g = Int(cg)
        b = Int(cb)
    }
}