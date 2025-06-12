import Foundation
import CSkia

public class SkBlender: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public static func makeMode(blendMode: SkBlendMode) -> SkBlender? {
        guard let handle = sk_blender_new_mode(blendMode.skBlendMode) else { return nil }
        return SkBlender(handle: handle)
    }

    public static func makeArithmetic(k1: Float, k2: Float, k3: Float, k4: Float, enforcePMColor: Bool) -> SkBlender? {
        guard let handle = sk_blender_new_arithmetic(k1, k2, k3, k4, enforcePMColor) else { return nil }
        return SkBlender(handle: handle)
    }

    public static func makeCompose(outer: SkBlender, inner: SkBlender) -> SkBlender? {
        guard let handle = sk_blender_new_compose(outer.handle, inner.handle) else { return nil }
        return SkBlender(handle: handle)
    }
}