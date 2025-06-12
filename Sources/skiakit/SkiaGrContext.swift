import Foundation
import CSkia

public enum SkGrBackend: UInt32 {
    case direct3D = 0
    case gl = 1
    case metal = 2
    case vulkan = 3
    case mock = 4

    init(_ backend: gr_backend_t) {
        self = SkGrBackend(rawValue: backend.rawValue)!
    }

    var grBackend: gr_backend_t {
        return gr_backend_t(rawValue: self.rawValue)
    }
}

public class SkGrRecordingContext: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public func getMaxSurfaceSampleCount(for colorType: SkColorType) -> Int {
        return Int(gr_recording_context_get_max_surface_sample_count_for_color_type(handle, colorType.skColorType))
    }

    public var backend: SkGrBackend {
        return SkGrBackend(gr_recording_context_get_backend(handle))
    }

    public var isAbandoned: Bool {
        return gr_recording_context_is_abandoned(handle)
    }

    public var maxTextureSize: Int {
        return Int(gr_recording_context_max_texture_size(handle))
    }

    public var maxRenderTargetSize: Int {
        return Int(gr_recording_context_max_render_target_size(handle))
    }

    public var directContext: SkGrDirectContext? {
        return SkGrDirectContext(handle: gr_recording_context_get_direct_context(handle))
    }
}

public class SkGrDirectContext: SkGrRecordingContext {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    // TODO: gr_direct_context_make_gl
    // TODO: gr_direct_context_make_gl_with_options
    // TODO: gr_direct_context_make_vulkan
    // TODO: gr_direct_context_make_vulkan_with_options
    // TODO: gr_direct_context_make_metal
    // TODO: gr_direct_context_make_metal_with_options
    // TODO: gr_direct_context_make_direct3d
    // TODO: gr_direct_context_make_direct3d_with_options

    public func abandonContext() {
        gr_direct_context_abandon_context(handle)
    }

    public func releaseResourcesAndAbandonContext() {
        gr_direct_context_release_resources_and_abandon_context(handle)
    }

    public var resourceCacheLimit: Int {
        get { return Int(gr_direct_context_get_resource_cache_limit(handle)) }
        set { gr_direct_context_set_resource_cache_limit(handle, newValue) }
    }

    public func getResourceCacheUsage(maxResources: inout Int, maxResourceBytes: inout Int) {
        var cMaxResources: Int32 = 0
        var cMaxResourceBytes: Int = 0
        gr_direct_context_get_resource_cache_usage(handle, &cMaxResources, &cMaxResourceBytes)
        maxResources = Int(cMaxResources)
        maxResourceBytes = cMaxResourceBytes
    }

    public func flush() {
        gr_direct_context_flush(handle)
    }

    public func submit(syncCpu: Bool) -> Bool {
        return gr_direct_context_submit(handle, syncCpu)
    }

    public func flushAndSubmit(syncCpu: Bool) {
        gr_direct_context_flush_and_submit(handle, syncCpu)
    }

    public func flush(image: SkImage) {
        gr_direct_context_flush_image(handle, image.handle)
    }

    public func flush(surface: SkSurface) {
        gr_direct_context_flush_surface(handle, surface.handle)
    }

    public func resetContext(state: UInt32) {
        gr_direct_context_reset_context(handle, state)
    }

    public func dumpMemoryStatistics(dump: SkTraceMemoryDump) {
        gr_direct_context_dump_memory_statistics(handle, dump.handle)
    }

    public func freeGpuResources() {
        gr_direct_context_free_gpu_resources(handle)
    }

    public func performDeferredCleanup(ms: Int64) {
        gr_direct_context_perform_deferred_cleanup(handle, ms)
    }

    public func purgeUnlockedResources(bytesToPurge: Int, preferScratchResources: Bool) {
        gr_direct_context_purge_unlocked_resources_bytes(handle, bytesToPurge, preferScratchResources)
    }

    public func purgeUnlockedResources(scratchResourcesOnly: Bool) {
        gr_direct_context_purge_unlocked_resources(handle, scratchResourcesOnly)
    }
}