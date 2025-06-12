import Foundation
import CSkia

public class SkGraphics {
    public static func initGraphics() {
        sk_graphics_init()
    }

    public static func purgeFontCache() {
        sk_graphics_purge_font_cache()
    }

    public static func purgeResourceCache() {
        sk_graphics_purge_resource_cache()
    }

    public static func purgeAllCaches() {
        sk_graphics_purge_all_caches()
    }

    public static var fontCacheUsed: Int {
        return Int(sk_graphics_get_font_cache_used())
    }

    public static var fontCacheLimit: Int {
        get { return Int(sk_graphics_get_font_cache_limit()) }
        set { sk_graphics_set_font_cache_limit(newValue) }
    }

    public static var fontCacheCountUsed: Int {
        return Int(sk_graphics_get_font_cache_count_used())
    }

    public static var fontCacheCountLimit: Int {
        get { return Int(sk_graphics_get_font_cache_count_limit()) }
        set { sk_graphics_set_font_cache_count_limit(Int32(newValue)) }
    }

    public static var resourceCacheTotalBytesUsed: Int {
        return Int(sk_graphics_get_resource_cache_total_bytes_used())
    }

    public static var resourceCacheTotalByteLimit: Int {
        get { return Int(sk_graphics_get_resource_cache_total_byte_limit()) }
        set { sk_graphics_set_resource_cache_total_byte_limit(newValue) }
    }

    public static var resourceCacheSingleAllocationByteLimit: Int {
        get { return Int(sk_graphics_get_resource_cache_single_allocation_byte_limit()) }
        set { sk_graphics_set_resource_cache_single_allocation_byte_limit(newValue) }
    }

    public static func dumpMemoryStatistics(dump: SkTraceMemoryDump) {
        sk_graphics_dump_memory_statistics(dump.handle)
    }
}

public class SkTraceMemoryDump {
    public var handle: OpaquePointer?
    // Placeholder for actual implementation
    public init(handle: OpaquePointer?) { self.handle = handle }
}