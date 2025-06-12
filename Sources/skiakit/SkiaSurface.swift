import Foundation
import CSkia

public class SkSurface: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public convenience init?(width: Int, height: Int) {
        guard let handle = sk_surface_new_null(Int32(width), Int32(height)) else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(rasterInfo: SkImageInfo, rowBytes: Int, props: SkSurfaceProps?) {
        var skInfo = rasterInfo.skImageInfo
        var skProps: sk_surfaceprops_t? = props?.skSurfaceProps
        guard let handle = sk_surface_new_raster(&skInfo, rowBytes, &skProps) else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(rasterDirectInfo: SkImageInfo, pixels: UnsafeMutableRawPointer, rowBytes: Int, releaseProc: sk_surface_raster_release_proc?, context: UnsafeMutableRawPointer?, props: SkSurfaceProps?) {
        var skInfo = rasterDirectInfo.skImageInfo
        var skProps: sk_surfaceprops_t? = props?.skSurfaceProps
        guard let handle = sk_surface_new_raster_direct(&skInfo, pixels, rowBytes, releaseProc, context, &skProps) else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(backendTextureContext: OpaquePointer?, texture: SkBackendTexture, origin: SkSurfaceOrigin, samples: Int, colorType: SkColorType, colorspace: SkColorSpace?, props: SkSurfaceProps?) {
        var skTexture = texture.skBackendTexture
        var skColorspace: OpaquePointer? = colorspace?.handle
        var skProps: sk_surfaceprops_t? = props?.skSurfaceProps
        guard let handle = sk_surface_new_backend_texture(backendTextureContext, &skTexture, origin.skSurfaceOrigin, Int32(samples), colorType.skColorType, skColorspace, &skProps) else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(backendRenderTargetContext: OpaquePointer?, target: SkBackendRenderTarget, origin: SkSurfaceOrigin, colorType: SkColorType, colorspace: SkColorSpace?, props: SkSurfaceProps?) {
        var skTarget = target.skBackendRenderTarget
        var skColorspace: OpaquePointer? = colorspace?.handle
        var skProps: sk_surfaceprops_t? = props?.skSurfaceProps
        guard let handle = sk_surface_new_backend_render_target(backendRenderTargetContext, &skTarget, origin.skSurfaceOrigin, colorType.skColorType, skColorspace, &skProps) else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(renderTargetContext: OpaquePointer?, budgeted: Bool, info: SkImageInfo, sampleCount: Int, origin: SkSurfaceOrigin, props: SkSurfaceProps?, shouldCreateWithMips: Bool) {
        var skInfo = info.skImageInfo
        var skProps: sk_surfaceprops_t? = props?.skSurfaceProps
        guard let handle = sk_surface_new_render_target(renderTargetContext, budgeted, &skInfo, Int32(sampleCount), origin.skSurfaceOrigin, &skProps, shouldCreateWithMips) else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(metalLayerContext: SkGrRecordingContext?, layer: OpaquePointer?, origin: GrSurfaceOrigin, sampleCount: Int, colorType: SkColorType, colorspace: SkColorSpace?, props: SkSurfaceProps?, drawable: inout OpaquePointer?) {
        var skColorspace: OpaquePointer? = colorspace?.handle
        var skProps: sk_surfaceprops_t? = props?.skSurfaceProps
        guard let handle = sk_surface_new_metal_layer(metalLayerContext?.handle, layer, origin.grSurfaceOrigin, Int32(sampleCount), colorType.skColorType, skColorspace, &skProps, &drawable) else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(metalViewContext: SkGrRecordingContext?, mtkView: OpaquePointer?, origin: GrSurfaceOrigin, sampleCount: Int, colorType: SkColorType, colorspace: SkColorSpace?, props: SkSurfaceProps?) {
        var skColorspace: OpaquePointer? = colorspace?.handle
        var skProps: sk_surfaceprops_t? = props?.skSurfaceProps
        guard let handle = sk_surface_new_metal_view(metalViewContext?.handle, mtkView, origin.grSurfaceOrigin, Int32(sampleCount), colorType.skColorType, skColorspace, &skProps) else { return nil }
        self.init(handle: handle)
    }

    public var canvas: SkCanvas? {
        guard let canvasHandle = sk_surface_get_canvas(handle) else { return nil }
        return SkCanvas(handle: canvasHandle)
    }

    public func newImageSnapshot() -> SkImage? {
        guard let imageHandle = sk_surface_new_image_snapshot(handle) else { return nil }
        return SkImage(handle: imageHandle)
    }

    public func newImageSnapshot(bounds: SkIRect) -> SkImage? {
        var skBounds = bounds.skIRect
        guard let imageHandle = sk_surface_new_image_snapshot_with_crop(handle, &skBounds) else { return nil }
        return SkImage(handle: imageHandle)
    }

    public func draw(canvas: SkCanvas, x: Float, y: Float, paint: SkPaint?) {
        sk_surface_draw(handle, canvas.handle, x, y, paint?.handle)
    }

    public func peekPixels(pixmap: SkPixmap) -> Bool {
        return sk_surface_peek_pixels(handle, pixmap.handle)
    }

    public func readPixels(dstInfo: SkImageInfo, dstPixels: UnsafeMutableRawPointer, dstRowBytes: Int, srcX: Int, srcY: Int) -> Bool {
        var skDstInfo = dstInfo.skImageInfo
        return sk_surface_read_pixels(handle, &skDstInfo, dstPixels, dstRowBytes, Int32(srcX), Int32(srcY))
    }

    public var props: SkSurfaceProps? {
        guard let propsHandle = sk_surface_get_props(handle) else { return nil }
        return SkSurfaceProps(handle: propsHandle)
    }

    public var recordingContext: OpaquePointer? { // gr_recording_context_t*
        return sk_surface_get_recording_context(handle)
    }
}

public class SkSurfaceProps {
    public var handle: OpaquePointer?

    public init(flags: SkSurfacePropsFlags, geometry: SkPixelGeometry) {
        self.handle = sk_surfaceprops_new(flags.rawValue, geometry.skPixelGeometry)
    }

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_surfaceprops_delete(handle)
    }

    public var flags: SkSurfacePropsFlags {
        return SkSurfacePropsFlags(rawValue: sk_surfaceprops_get_flags(handle))
    }

    public var pixelGeometry: SkPixelGeometry {
        return SkPixelGeometry(sk_surfaceprops_get_pixel_geometry(handle))
    }
}

public enum SkPixelGeometry: UInt32 {
    case unknown = 0
    case rgbH = 1
    case bgrH = 2
    case rgbV = 3
    case bgrV = 4

    public init(_ geometry: sk_pixelgeometry_t) {
        self = SkPixelGeometry(rawValue: geometry.rawValue)!
    }

    public var skPixelGeometry: sk_pixelgeometry_t {
        return sk_pixelgeometry_t(rawValue: self.rawValue)
    }
}

public struct SkSurfacePropsFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let none = SkSurfacePropsFlags(rawValue: 0)
    public static let useDeviceIndependentFonts = SkSurfacePropsFlags(rawValue: USE_DEVICE_INDEPENDENT_FONTS_SK_SURFACE_PROPS_FLAGS.rawValue)
}

// TODO: Define SkBackendTexture and SkBackendRenderTarget when their headers are processed.
// For now, use OpaquePointer for their handles.
public class SkBackendTexture {
    public var handle: OpaquePointer?
    // Placeholder for actual implementation
    public init(handle: OpaquePointer?) { self.handle = handle }
}

public class SkBackendRenderTarget {
    public var handle: OpaquePointer?
    // Placeholder for actual implementation
    public init(handle: OpaquePointer?) { self.handle = handle }
}

public enum SkSurfaceOrigin: UInt32 {
    case topLeft = 0
    case bottomLeft = 1

    public init(_ origin: gr_surfaceorigin_t) {
        self = SkSurfaceOrigin(rawValue: origin.rawValue)!
    }

    public var skSurfaceOrigin: gr_surfaceorigin_t {
        return gr_surfaceorigin_t(rawValue: self.rawValue)
    }
}