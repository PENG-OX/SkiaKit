import Foundation
import CSkia

public class SkImageFilter: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public static func makeArithmetic(k1: Float, k2: Float, k3: Float, k4: Float, enforcePMColor: Bool, background: SkImageFilter?, foreground: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_arithmetic(k1, k2, k3, k4, enforcePMColor, background?.handle, foreground?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeBlend(mode: SkBlendMode, background: SkImageFilter?, foreground: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_blend(mode.skBlendMode, background?.handle, foreground?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeBlender(blender: SkBlender, background: SkImageFilter?, foreground: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_blender(blender.handle, background?.handle, foreground?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeBlur(sigmaX: Float, sigmaY: Float, tileMode: SkShaderTileMode, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_blur(sigmaX, sigmaY, tileMode.skShaderTileMode, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeColorFilter(colorFilter: SkColorFilter, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_color_filter(colorFilter.handle, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeCompose(outer: SkImageFilter?, inner: SkImageFilter?) -> SkImageFilter? {
        guard let handle = sk_imagefilter_new_compose(outer?.handle, inner?.handle) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeDisplacementMapEffect(xChannelSelector: SkColorChannel, yChannelSelector: SkColorChannel, scale: Float, displacement: SkImageFilter, color: SkImageFilter, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_displacement_map_effect(xChannelSelector.skColorChannel, yChannelSelector.skColorChannel, scale, displacement.handle, color.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeDropShadow(dx: Float, dy: Float, sigmaX: Float, sigmaY: Float, color: SkColor, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_drop_shadow(dx, dy, sigmaX, sigmaY, color, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeDropShadowOnly(dx: Float, dy: Float, sigmaX: Float, sigmaY: Float, color: SkColor, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_drop_shadow_only(dx, dy, sigmaX, sigmaY, color, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeImage(image: SkImage, srcRect: SkRect, dstRect: SkRect, sampling: SkSamplingOptions) -> SkImageFilter? {
        var skSrcRect = srcRect.skRect
        var skDstRect = dstRect.skRect
        var skSampling = sampling.skSamplingOptions
        guard let handle = sk_imagefilter_new_image(image.handle, &skSrcRect, &skDstRect, &skSampling) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeImageSimple(image: SkImage, sampling: SkSamplingOptions) -> SkImageFilter? {
        var skSampling = sampling.skSamplingOptions
        guard let handle = sk_imagefilter_new_image_simple(image.handle, &skSampling) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeMagnifier(lensBounds: SkRect, zoomAmount: Float, inset: Float, sampling: SkSamplingOptions, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skLensBounds = lensBounds.skRect
        var skSampling = sampling.skSamplingOptions
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_magnifier(&skLensBounds, zoomAmount, inset, &skSampling, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeMatrixConvolution(kernelSize: SkISize, kernel: [Float], gain: Float, bias: Float, kernelOffset: SkIPoint, tileMode: SkShaderTileMode, convolveAlpha: Bool, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skKernelSize = kernelSize.skISize
        var skKernelOffset = kernelOffset.skIPoint
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = kernel.withUnsafeBufferPointer({ kernelPtr in
            sk_imagefilter_new_matrix_convolution(&skKernelSize, kernelPtr.baseAddress, gain, bias, &skKernelOffset, tileMode.skShaderTileMode, convolveAlpha, input?.handle, &skCropRect)
        }) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeMatrixTransform(matrix: SkMatrix, sampling: SkSamplingOptions, input: SkImageFilter?) -> SkImageFilter? {
        var skMatrix = matrix.skMatrix
        var skSampling = sampling.skSamplingOptions
        guard let handle = sk_imagefilter_new_matrix_transform(&skMatrix, &skSampling, input?.handle) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeMerge(filters: [SkImageFilter], cropRect: SkRect?) -> SkImageFilter? {
        let cFilters = filters.map { $0.handle }
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = cFilters.withUnsafeBufferPointer({ ptr in
            sk_imagefilter_new_merge(ptr.baseAddress, Int32(ptr.count), &skCropRect)
        }) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeMergeSimple(first: SkImageFilter, second: SkImageFilter, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_merge_simple(first.handle, second.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeOffset(dx: Float, dy: Float, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_offset(dx, dy, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makePicture(picture: SkPicture) -> SkImageFilter? {
        guard let handle = sk_imagefilter_new_picture(picture.handle) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makePicture(picture: SkPicture, targetRect: SkRect) -> SkImageFilter? {
        var skTargetRect = targetRect.skRect
        guard let handle = sk_imagefilter_new_picture_with_rect(picture.handle, &skTargetRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeShader(shader: SkShader, dither: Bool, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_shader(shader.handle, dither, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeTile(src: SkRect, dst: SkRect, input: SkImageFilter) -> SkImageFilter? {
        var skSrc = src.skRect
        var skDst = dst.skRect
        guard let handle = sk_imagefilter_new_tile(&skSrc, &skDst, input.handle) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeDilate(radiusX: Float, radiusY: Float, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_dilate(radiusX, radiusY, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeErode(radiusX: Float, radiusY: Float, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_erode(radiusX, radiusY, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeDistantLitDiffuse(direction: SkPoint3, lightColor: SkColor, surfaceScale: Float, kd: Float, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skDirection = direction.skPoint3
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_distant_lit_diffuse(&skDirection, lightColor, surfaceScale, kd, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makePointLitDiffuse(location: SkPoint3, lightColor: SkColor, surfaceScale: Float, kd: Float, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skLocation = location.skPoint3
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_point_lit_diffuse(&skLocation, lightColor, surfaceScale, kd, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeSpotLitDiffuse(location: SkPoint3, target: SkPoint3, specularExponent: Float, cutoffAngle: Float, lightColor: SkColor, surfaceScale: Float, kd: Float, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skLocation = location.skPoint3
        var skTarget = target.skPoint3
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_spot_lit_diffuse(&skLocation, &skTarget, specularExponent, cutoffAngle, lightColor, surfaceScale, kd, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeDistantLitSpecular(direction: SkPoint3, lightColor: SkColor, surfaceScale: Float, ks: Float, shininess: Float, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skDirection = direction.skPoint3
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_distant_lit_specular(&skDirection, lightColor, surfaceScale, ks, shininess, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makePointLitSpecular(location: SkPoint3, lightColor: SkColor, surfaceScale: Float, ks: Float, shininess: Float, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skLocation = location.skPoint3
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_point_lit_specular(&skLocation, lightColor, surfaceScale, ks, shininess, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }

    public static func makeSpotLitSpecular(location: SkPoint3, target: SkPoint3, specularExponent: Float, cutoffAngle: Float, lightColor: SkColor, surfaceScale: Float, ks: Float, shininess: Float, input: SkImageFilter?, cropRect: SkRect?) -> SkImageFilter? {
        var skLocation = location.skPoint3
        var skTarget = target.skPoint3
        var skCropRect: sk_rect_t? = cropRect?.skRect
        guard let handle = sk_imagefilter_new_spot_lit_specular(&skLocation, &skTarget, specularExponent, cutoffAngle, lightColor, surfaceScale, ks, shininess, input?.handle, &skCropRect) else { return nil }
        return SkImageFilter(handle: handle)
    }
}