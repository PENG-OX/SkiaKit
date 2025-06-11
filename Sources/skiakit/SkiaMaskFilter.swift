import Foundation
import Skia

public class SkMaskFilter: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public static func makeBlur(style: SkBlurStyle, sigma: Float) -> SkMaskFilter? {
        guard let handle = sk_maskfilter_new_blur(style.skBlurStyle, sigma) else { return nil }
        return SkMaskFilter(handle: handle)
    }

    public static func makeBlur(style: SkBlurStyle, sigma: Float, respectCTM: Bool) -> SkMaskFilter? {
        guard let handle = sk_maskfilter_new_blur_with_flags(style.skBlurStyle, sigma, respectCTM) else { return nil }
        return SkMaskFilter(handle: handle)
    }

    public static func makeTable(table: [UInt8]) -> SkMaskFilter? {
        guard table.count == 256 else { return nil }
        guard let handle = table.withUnsafeBufferPointer({ ptr in
            sk_maskfilter_new_table(ptr.baseAddress)
        }) else { return nil }
        return SkMaskFilter(handle: handle)
    }

    public static func makeGamma(gamma: Float) -> SkMaskFilter? {
        guard let handle = sk_maskfilter_new_gamma(gamma) else { return nil }
        return SkMaskFilter(handle: handle)
    }

    public static func makeClip(min: UInt8, max: UInt8) -> SkMaskFilter? {
        guard let handle = sk_maskfilter_new_clip(min, max) else { return nil }
        return SkMaskFilter(handle: handle)
    }

    public static func makeShader(shader: SkShader) -> SkMaskFilter? {
        guard let handle = sk_maskfilter_new_shader(shader.handle) else { return nil }
        return SkMaskFilter(handle: handle)
    }
}

public enum SkBlurStyle: UInt32 {
    case normal = 0
    case solid = 1
    case outer = 2
    case inner = 3

    public init(_ style: sk_blurstyle_t) {
        self = SkBlurStyle(rawValue: style.rawValue)!
    }

    public var skBlurStyle: sk_blurstyle_t {
        return sk_blurstyle_t(rawValue: self.rawValue)
    }
}