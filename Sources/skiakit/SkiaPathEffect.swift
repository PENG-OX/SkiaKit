import Foundation
import Skia

public class SkPathEffect: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public static func makeCompose(outer: SkPathEffect, inner: SkPathEffect) -> SkPathEffect? {
        guard let handle = sk_path_effect_new_compose(outer.handle, inner.handle) else { return nil }
        return SkPathEffect(handle: handle)
    }

    public static func makeSum(first: SkPathEffect, second: SkPathEffect) -> SkPathEffect? {
        guard let handle = sk_path_effect_new_sum(first.handle, second.handle) else { return nil }
        return SkPathEffect(handle: handle)
    }

    public static func makeCorner(radius: Float) -> SkPathEffect? {
        guard let handle = sk_path_effect_new_corner(radius) else { return nil }
        return SkPathEffect(handle: handle)
    }

    public static func makeDash(intervals: [Float], phase: Float) -> SkPathEffect? {
        guard intervals.count % 2 == 0 else { return nil } // intervals must be an even count
        guard let handle = intervals.withUnsafeBufferPointer({ ptr in
            sk_path_effect_new_dash(ptr.baseAddress, Int32(ptr.count), phase)
        }) else { return nil }
        return SkPathEffect(handle: handle)
    }

    public static func makePath(path: SkPath, advance: Float, deviate: Float, style: SkPathEffectStyle, transform: SkPathEffectTransform) -> SkPathEffect? {
        guard let handle = sk_path_effect_new_path(path.handle, advance, deviate, style.skPathEffectStyle, transform.skPathEffectTransform) else { return nil }
        return SkPathEffect(handle: handle)
    }

    public static func makeLine2D(width: Float, matrix: SkMatrix) -> SkPathEffect? {
        var skMatrix = matrix.skMatrix
        guard let handle = sk_path_effect_new_line2d(width, &skMatrix) else { return nil }
        return SkPathEffect(handle: handle)
    }

    public static func makeDiscrete(segLength: Float, deviate: Float, seed: UInt32) -> SkPathEffect? {
        guard let handle = sk_path_effect_new_discrete(segLength, deviate, seed) else { return nil }
        return SkPathEffect(handle: handle)
    }

    public static func makeTrim(start: Float, stop: Float, mode: SkTrimPathEffectMode) -> SkPathEffect? {
        guard let handle = sk_path_effect_new_trim(start, stop, mode.skTrimPathEffectMode) else { return nil }
        return SkPathEffect(handle: handle)
    }
}

public enum SkPathEffectStyle: UInt32 {
    case translate = 0
    case rotate = 1

    public init(_ style: sk_path_effect_style_t) {
        self = SkPathEffectStyle(rawValue: style.rawValue)!
    }

    public var skPathEffectStyle: sk_path_effect_style_t {
        return sk_path_effect_style_t(rawValue: self.rawValue)
    }
}

public enum SkPathEffectTransform: UInt32 {
    case none = 0
    case rotate = 1

    public init(_ transform: sk_path_effect_transform_t) {
        self = SkPathEffectTransform(rawValue: transform.rawValue)!
    }

    public var skPathEffectTransform: sk_path_effect_transform_t {
        return sk_path_effect_transform_t(rawValue: self.rawValue)
    }
}

public enum SkTrimPathEffectMode: UInt32 {
    case normal = 0
    case inverted = 1

    public init(_ mode: sk_trimpath_effect_mode_t) {
        self = SkTrimPathEffectMode(rawValue: mode.rawValue)!
    }

    public var skTrimPathEffectMode: sk_trimpath_effect_mode_t {
        return sk_trimpath_effect_mode_t(rawValue: self.rawValue)
    }
}