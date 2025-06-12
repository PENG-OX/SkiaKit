import Foundation
import CSkia

public class SkottieAnimation: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public static func make(from string: String) -> SkottieAnimation? {
        let cString = string.cString(using: .utf8)!
        guard let handle = cString.withUnsafeBufferPointer({ ptr in
            skottie_animation_make_from_string(ptr.baseAddress, ptr.count - 1)
        }) else { return nil }
        return SkottieAnimation(handle: handle)
    }

    public static func make(from data: Data) -> SkottieAnimation? {
        guard let handle = data.withUnsafeBytes({ buffer in
            skottie_animation_make_from_data(buffer.baseAddress?.assumingMemoryBound(to: Int8.self), buffer.count)
        }) else { return nil }
        return SkottieAnimation(handle: handle)
    }

    public static func make(from stream: SkStream) -> SkottieAnimation? {
        guard let handle = skottie_animation_make_from_stream(stream.handle) else { return nil }
        return SkottieAnimation(handle: handle)
    }

    public static func make(fromFile path: String) -> SkottieAnimation? {
        let cPath = path.cString(using: .utf8)!
        guard let handle = cPath.withUnsafeBufferPointer({ ptr in
            skottie_animation_make_from_file(ptr.baseAddress)
        }) else { return nil }
        return SkottieAnimation(handle: handle)
    }

    public func render(canvas: SkCanvas, dst: SkRect) {
        var skDst = dst.skRect
        skottie_animation_render(handle, canvas.handle, &skDst)
    }

    public func render(canvas: SkCanvas, dst: SkRect, flags: SkottieAnimationRenderFlags) {
        var skDst = dst.skRect
        skottie_animation_render_with_flags(handle, canvas.handle, &skDst, flags.rawValue)
    }

    public func seek(t: Float, invalidationController: SKSGInvalidationController?) {
        skottie_animation_seek(handle, t, invalidationController?.handle)
    }

    public func seekFrame(t: Float, invalidationController: SKSGInvalidationController?) {
        skottie_animation_seek_frame(handle, t, invalidationController?.handle)
    }

    public func seekFrameTime(t: Float, invalidationController: SKSGInvalidationController?) {
        skottie_animation_seek_frame_time(handle, t, invalidationController?.handle)
    }

    public var duration: Double {
        return skottie_animation_get_duration(handle)
    }

    public var fps: Double {
        return skottie_animation_get_fps(handle)
    }

    public var inPoint: Double {
        return skottie_animation_get_in_point(handle)
    }

    public var outPoint: Double {
        return skottie_animation_get_out_point(handle)
    }

    public var version: SkString {
        let skString = SkString()
        skottie_animation_get_version(handle, skString.handle)
        return skString
    }

    public var size: SkSize {
        var skSize = sk_size_t()
        skottie_animation_get_size(handle, &skSize)
        return SkSize(skSize)
    }
}

public struct SkottieAnimationRenderFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    // No specific flags defined in skottie_animation.h, assuming 0 for now.
    // If flags are added in the future, they would be defined here.
    public static let none = SkottieAnimationRenderFlags(rawValue: 0)
}

public class SkottieAnimationBuilder {
    public var handle: OpaquePointer?

    public convenience init(flags: SkottieAnimationBuilderFlags) {
        self.init(handle: skottie_animation_builder_new(flags.rawValue))
    }

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        skottie_animation_builder_delete(handle)
    }

    public func getStats(stats: inout SkottieAnimationBuilderStats) {
        var skStats = stats.skottieAnimationBuilderStats
        skottie_animation_builder_get_stats(handle, &skStats)
        stats = SkottieAnimationBuilderStats(skStats)
    }

    public func setResourceProvider(resourceProvider: SkottieResourceProvider) {
        skottie_animation_builder_set_resource_provider(handle, resourceProvider.handle)
    }

    // TODO: sk_fontmgr_t is not yet wrapped.
    // public func setFontManager(fontManager: SkFontMgr) {
    //     skottie_animation_builder_set_font_manager(handle, fontManager.handle)
    // }

    public func make(from stream: SkStream) -> SkottieAnimation? {
        guard let animationHandle = skottie_animation_builder_make_from_stream(handle, stream.handle) else { return nil }
        return SkottieAnimation(handle: animationHandle)
    }

    public func make(fromFile path: String) -> SkottieAnimation? {
        let cPath = path.cString(using: .utf8)!
        guard let animationHandle = cPath.withUnsafeBufferPointer({ ptr in
            skottie_animation_builder_make_from_file(handle, ptr.baseAddress)
        }) else { return nil }
        return SkottieAnimation(handle: animationHandle)
    }

    public static func make(from string: String, builder: SkottieAnimationBuilder) -> SkottieAnimation? {
        let cString = string.cString(using: .utf8)!
        guard let animationHandle = cString.withUnsafeBufferPointer({ ptr in
            skottie_animation_builder_make_from_string(builder.handle, ptr.baseAddress, ptr.count - 1)
        }) else { return nil }
        return SkottieAnimation(handle: animationHandle)
    }

    public static func make(from data: Data, builder: SkottieAnimationBuilder) -> SkottieAnimation? {
        guard let animationHandle = data.withUnsafeBytes({ buffer in
            skottie_animation_builder_make_from_data(builder.handle, buffer.baseAddress?.assumingMemoryBound(to: Int8.self), buffer.count)
        }) else { return nil }
        return SkottieAnimation(handle: animationHandle)
    }
}

public struct SkottieAnimationBuilderFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    // No specific flags defined in skottie_animation.h, assuming 0 for now.
    // If flags are added in the future, they would be defined here.
    public static let none = SkottieAnimationBuilderFlags(rawValue: 0)
}

public struct SkottieAnimationBuilderStats {
    public var totalProperties: Int
    public var totalLayers: Int
    public var totalAnimations: Int
    public var totalKeyframes: Int
    public var totalAssets: Int

    public init(_ stats: skottie_animation_builder_stats_t) {
        self.totalProperties = Int(stats.fTotalProperties)
        self.totalLayers = Int(stats.fTotalLayers)
        self.totalAnimations = Int(stats.fTotalAnimations)
        self.totalKeyframes = Int(stats.fTotalKeyframes)
        self.totalAssets = Int(stats.fTotalAssets)
    }

    public var skottieAnimationBuilderStats: skottie_animation_builder_stats_t {
        return skottie_animation_builder_stats_t(
            fTotalProperties: Int32(totalProperties),
            fTotalLayers: Int32(totalLayers),
            fTotalAnimations: Int32(totalAnimations),
            fTotalKeyframes: Int32(totalKeyframes),
            fTotalAssets: Int32(totalAssets)
        )
    }
}

public class SkottieResourceProvider {
    public var handle: OpaquePointer?
    // Placeholder for actual implementation
    public init(handle: OpaquePointer?) { self.handle = handle }
}

public class SKSGInvalidationController {
    public var handle: OpaquePointer?
    // Placeholder for actual implementation
    public init(handle: OpaquePointer?) { self.handle = handle }
}