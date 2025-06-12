import Foundation
import CSkia

public class SkImage: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public convenience init?(rasterCopy info: SkImageInfo, pixels: UnsafeRawPointer, rowBytes: Int) {
        let handle = sk_image_new_raster_copy(info.skImageInfo, pixels, rowBytes)
        guard let handle = handle else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(rasterCopy pixmap: SkPixmap) {
        let handle = sk_image_new_raster_copy_with_pixmap(pixmap.handle)
        guard let handle = handle else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(rasterData info: SkImageInfo, pixels: SkData, rowBytes: Int) {
        let handle = sk_image_new_raster_data(info.skImageInfo, pixels.handle, rowBytes)
        guard let handle = handle else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(bitmap: SkBitmap) {
        let handle = sk_image_new_from_bitmap(bitmap.handle)
        guard let handle = handle else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(encodedData: SkData) {
        let handle = sk_image_new_from_encoded(encodedData.handle)
        guard let handle = handle else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(textureContext context: SkGrRecordingContext, texture: SkGrBackendTexture, origin: GrSurfaceOrigin, colorType: SkColorType, alpha: SkAlphaType, colorSpace: SkColorSpace?, releaseProc: sk_image_texture_release_proc?, releaseContext: UnsafeMutableRawPointer?) {
        let handle = sk_image_new_from_texture(context.handle, texture.handle, origin.grSurfaceOrigin, colorType.skColorType, alpha.skAlphaType, colorSpace?.handle, releaseProc, releaseContext)
        guard let handle = handle else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(adoptedTextureContext context: SkGrRecordingContext, texture: SkGrBackendTexture, origin: GrSurfaceOrigin, colorType: SkColorType, alpha: SkAlphaType, colorSpace: SkColorSpace?) {
        let handle = sk_image_new_from_adopted_texture(context.handle, texture.handle, origin.grSurfaceOrigin, colorType.skColorType, alpha.skAlphaType, colorSpace?.handle)
        guard let handle = handle else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(picture: SkPicture, dimensions: SkISize, matrix: SkMatrix?, paint: SkPaint?, useFloatingPointBitDepth: Bool, colorSpace: SkColorSpace?, props: SkSurfaceProps?) {
        var skDimensions = dimensions.skISize
        var skMatrix: sk_matrix_t? = matrix?.skMatrix
        let handle = sk_image_new_from_picture(picture.handle, &skDimensions, &skMatrix, paint?.handle, useFloatingPointBitDepth, colorSpace?.handle, props?.handle)
        guard let handle = handle else { return nil }
        self.init(handle: handle)
    }

    public var width: Int {
        return Int(sk_image_get_width(handle))
    }

    public var height: Int {
        return Int(sk_image_get_height(handle))
    }

    public var uniqueID: UInt32 {
        return sk_image_get_unique_id(handle)
    }

    public var alphaType: SkAlphaType {
        return SkAlphaType(sk_image_get_alpha_type(handle))
    }

    public var colorType: SkColorType {
        return SkColorType(sk_image_get_color_type(handle))
    }

    public var colorSpace: OpaquePointer? { // sk_colorspace_t*
        return sk_image_get_colorspace(handle)
    }

    public var isAlphaOnly: Bool {
        return sk_image_is_alpha_only(handle)
    }

    public func makeShader(tileX: SkShaderTileMode, tileY: SkShaderTileMode, sampling: SkSamplingOptions, matrix: SkMatrix?) -> SkShader? {
        var skMatrix: sk_matrix_t? = matrix?.skMatrix
        let handle = sk_image_make_shader(handle, tileX.skShaderTileMode, tileY.skShaderTileMode, sampling.skSamplingOptions, &skMatrix)
        guard let handle = handle else { return nil }
        return SkShader(handle: handle)
    }

    public func makeRawShader(tileX: SkShaderTileMode, tileY: SkShaderTileMode, sampling: SkSamplingOptions, matrix: SkMatrix?) -> SkShader? {
        var skMatrix: sk_matrix_t? = matrix?.skMatrix
        let handle = sk_image_make_raw_shader(handle, tileX.skShaderTileMode, tileY.skShaderTileMode, sampling.skSamplingOptions, &skMatrix)
        guard let handle = handle else { return nil }
        return SkShader(handle: handle)
    }

    public func peekPixels(pixmap: SkPixmap) -> Bool {
        return sk_image_peek_pixels(handle, pixmap.handle)
    }

    public var isTextureBacked: Bool {
        return sk_image_is_texture_backed(handle)
    }

    public var isLazyGenerated: Bool {
        return sk_image_is_lazy_generated(handle)
    }

    public func isValid(context: OpaquePointer?) -> Bool { // gr_recording_context_t*
        return sk_image_is_valid(handle, context)
    }

    public func readPixels(dstInfo: SkImageInfo, dstPixels: UnsafeMutableRawPointer, dstRowBytes: Int, srcX: Int, srcY: Int, cachingHint: SkImageCachingHint) -> Bool {
        var info = dstInfo.skImageInfo
        return sk_image_read_pixels(handle, &info, dstPixels, dstRowBytes, Int32(srcX), Int32(srcY), cachingHint.skImageCachingHint)
    }

    public func readPixels(into pixmap: SkPixmap, srcX: Int, srcY: Int, cachingHint: SkImageCachingHint) -> Bool {
        return sk_image_read_pixels_into_pixmap(handle, pixmap.handle, Int32(srcX), Int32(srcY), cachingHint.skImageCachingHint)
    }

    public func scalePixels(dst: SkPixmap, sampling: SkSamplingOptions, cachingHint: SkImageCachingHint) -> Bool {
        return sk_image_scale_pixels(handle, dst.handle, sampling.skSamplingOptions, cachingHint.skImageCachingHint)
    }

    public func refEncoded() -> SkData? {
        guard let dataHandle = sk_image_ref_encoded(handle) else { return nil }
        return SkData(handle: dataHandle)
    }

    public func makeSubsetRaster(subset: SkIRect) -> SkImage? {
        var rect = subset.skIRect
        guard let newHandle = sk_image_make_subset_raster(handle, &rect) else { return nil }
        return SkImage(handle: newHandle)
    }

    public func makeSubset(context: OpaquePointer?, subset: SkIRect) -> SkImage? { // gr_direct_context_t*
        var rect = subset.skIRect
        guard let newHandle = sk_image_make_subset(handle, context, &rect) else { return nil }
        return SkImage(handle: newHandle)
    }

    public func makeTextureImage(context: OpaquePointer?, mipmapped: Bool, budgeted: Bool) -> SkImage? { // gr_direct_context_t*
        guard let newHandle = sk_image_make_texture_image(handle, context, mipmapped, budgeted) else { return nil }
        return SkImage(handle: newHandle)
    }

    public func makeNonTextureImage() -> SkImage? {
        guard let newHandle = sk_image_make_non_texture_image(handle) else { return nil }
        return SkImage(handle: newHandle)
    }

    public func makeRasterImage() -> SkImage? {
        guard let newHandle = sk_image_make_raster_image(handle) else { return nil }
        return SkImage(handle: newHandle)
    }

    public func makeWithFilterRaster(filter: SkImageFilter, subset: SkIRect, clipBounds: SkIRect) -> (image: SkImage?, outSubset: SkIRect, outOffset: SkIPoint) {
        var skSubset = subset.skIRect
        var skClipBounds = clipBounds.skIRect
        var outSubset = sk_irect_t()
        var outOffset = sk_ipoint_t()
        let handle = sk_image_make_with_filter_raster(handle, filter.handle, &skSubset, &skClipBounds, &outSubset, &outOffset)
        return (SkImage(handle: handle), SkIRect(outSubset), SkIPoint(outOffset))
    }

    public func makeWithFilter(context: SkGrRecordingContext?, filter: SkImageFilter, subset: SkIRect, clipBounds: SkIRect) -> (image: SkImage?, outSubset: SkIRect, outOffset: SkIPoint) {
        var skSubset = subset.skIRect
        var skClipBounds = clipBounds.skIRect
        var outSubset = sk_irect_t()
        var outOffset = sk_ipoint_t()
        let handle = sk_image_make_with_filter(handle, context?.handle, filter.handle, &skSubset, &skClipBounds, &outSubset, &outOffset)
        return (SkImage(handle: handle), SkIRect(outSubset), SkIPoint(outOffset))
    }
}