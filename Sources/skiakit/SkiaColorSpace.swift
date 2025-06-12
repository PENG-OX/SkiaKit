import Foundation
import CSkia

public class SkColorSpace: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public static func makeSrgb() -> SkColorSpace? {
        return SkColorSpace(handle: sk_colorspace_new_srgb())
    }

    public static func makeSrgbLinear() -> SkColorSpace? {
        return SkColorSpace(handle: sk_colorspace_new_srgb_linear())
    }

    public static func makeRgb(transferFn: SkColorSpaceTransferFn, toXYZD50: SkColorSpaceXYZ) -> SkColorSpace? {
        var skTransferFn = transferFn.skColorSpaceTransferFn
        var skToXYZD50 = toXYZD50.skColorSpaceXYZ
        return SkColorSpace(handle: sk_colorspace_new_rgb(&skTransferFn, &skToXYZD50))
    }

    public static func makeIcc(profile: SkColorSpaceIccProfile) -> SkColorSpace? {
        return SkColorSpace(handle: sk_colorspace_new_icc(profile.handle))
    }

    public func toProfile() -> SkColorSpaceIccProfile {
        let profile = SkColorSpaceIccProfile()
        sk_colorspace_to_profile(handle, profile.handle)
        return profile
    }

    public var gammaCloseToSrgb: Bool {
        return sk_colorspace_gamma_close_to_srgb(handle)
    }

    public var gammaIsLinear: Bool {
        return sk_colorspace_gamma_is_linear(handle)
    }

    public func isNumericalTransferFn() -> SkColorSpaceTransferFn? {
        var transferFn = SkColorSpaceTransferFn()
        if sk_colorspace_is_numerical_transfer_fn(handle, &transferFn.skColorSpaceTransferFn) {
            return transferFn
        }
        return nil
    }

    public func toXYZD50() -> SkColorSpaceXYZ? {
        var toXYZD50 = SkColorSpaceXYZ()
        if sk_colorspace_to_xyzd50(handle, &toXYZD50.skColorSpaceXYZ) {
            return toXYZD50
        }
        return nil
    }

    public func makeLinearGamma() -> SkColorSpace? {
        return SkColorSpace(handle: sk_colorspace_make_linear_gamma(handle))
    }

    public func makeSrgbGamma() -> SkColorSpace? {
        return SkColorSpace(handle: sk_colorspace_make_srgb_gamma(handle))
    }

    public var isSrgb: Bool {
        return sk_colorspace_is_srgb(handle)
    }

    public func equals(other: SkColorSpace) -> Bool {
        return sk_colorspace_equals(handle, other.handle)
    }
}

public struct SkColorSpaceTransferFn {
    public var skColorSpaceTransferFn: sk_colorspace_transfer_fn_t

    public init() {
        skColorSpaceTransferFn = sk_colorspace_transfer_fn_t()
    }

    public static func namedSrgb() -> SkColorSpaceTransferFn {
        var transferFn = SkColorSpaceTransferFn()
        sk_colorspace_transfer_fn_named_srgb(&transferFn.skColorSpaceTransferFn)
        return transferFn
    }

    public static func named2Dot2() -> SkColorSpaceTransferFn {
        var transferFn = SkColorSpaceTransferFn()
        sk_colorspace_transfer_fn_named_2dot2(&transferFn.skColorSpaceTransferFn)
        return transferFn
    }

    public static func namedLinear() -> SkColorSpaceTransferFn {
        var transferFn = SkColorSpaceTransferFn()
        sk_colorspace_transfer_fn_named_linear(&transferFn.skColorSpaceTransferFn)
        return transferFn
    }

    public static func namedRec2020() -> SkColorSpaceTransferFn {
        var transferFn = SkColorSpaceTransferFn()
        sk_colorspace_transfer_fn_named_rec2020(&transferFn.skColorSpaceTransferFn)
        return transferFn
    }

    public static func namedPq() -> SkColorSpaceTransferFn {
        var transferFn = SkColorSpaceTransferFn()
        sk_colorspace_transfer_fn_named_pq(&transferFn.skColorSpaceTransferFn)
        return transferFn
    }

    public static func namedHlg() -> SkColorSpaceTransferFn {
        var transferFn = SkColorSpaceTransferFn()
        sk_colorspace_transfer_fn_named_hlg(&transferFn.skColorSpaceTransferFn)
        return transferFn
    }

    public func eval(x: Float) -> Float {
        return sk_colorspace_transfer_fn_eval(&skColorSpaceTransferFn, x)
    }

    public func invert() -> SkColorSpaceTransferFn? {
        var dst = SkColorSpaceTransferFn()
        if sk_colorspace_transfer_fn_invert(&skColorSpaceTransferFn, &dst.skColorSpaceTransferFn) {
            return dst
        }
        return nil
    }
}

public struct SkColorSpacePrimaries {
    public var skColorSpacePrimaries: sk_colorspace_primaries_t

    public init() {
        skColorSpacePrimaries = sk_colorspace_primaries_t()
    }

    public func toXYZD50() -> SkColorSpaceXYZ? {
        var toXYZD50 = SkColorSpaceXYZ()
        if sk_colorspace_primaries_to_xyzd50(&skColorSpacePrimaries, &toXYZD50.skColorSpaceXYZ) {
            return toXYZD50
        }
        return nil
    }
}

public struct SkColorSpaceXYZ {
    public var skColorSpaceXYZ: sk_colorspace_xyz_t

    public init() {
        skColorSpaceXYZ = sk_colorspace_xyz_t()
    }

    public static func namedSrgb() -> SkColorSpaceXYZ {
        var xyz = SkColorSpaceXYZ()
        sk_colorspace_xyz_named_srgb(&xyz.skColorSpaceXYZ)
        return xyz
    }

    public static func namedAdobeRgb() -> SkColorSpaceXYZ {
        var xyz = SkColorSpaceXYZ()
        sk_colorspace_xyz_named_adobe_rgb(&xyz.skColorSpaceXYZ)
        return xyz
    }

    public static func namedDisplayP3() -> SkColorSpaceXYZ {
        var xyz = SkColorSpaceXYZ()
        sk_colorspace_xyz_named_display_p3(&xyz.skColorSpaceXYZ)
        return xyz
    }

    public static func namedRec2020() -> SkColorSpaceXYZ {
        var xyz = SkColorSpaceXYZ()
        sk_colorspace_xyz_named_rec2020(&xyz.skColorSpaceXYZ)
        return xyz
    }

    public static func namedXyz() -> SkColorSpaceXYZ {
        var xyz = SkColorSpaceXYZ()
        sk_colorspace_xyz_named_xyz(&xyz.skColorSpaceXYZ)
        return xyz
    }

    public func invert() -> SkColorSpaceXYZ? {
        var dst = SkColorSpaceXYZ()
        if sk_colorspace_xyz_invert(&skColorSpaceXYZ, &dst.skColorSpaceXYZ) {
            return dst
        }
        return nil
    }

    public func concat(other: SkColorSpaceXYZ) -> SkColorSpaceXYZ {
        var result = SkColorSpaceXYZ()
        var skOther = other.skColorSpaceXYZ
        sk_colorspace_xyz_concat(&skColorSpaceXYZ, &skOther, &result.skColorSpaceXYZ)
        return result
    }
}

public class SkColorSpaceIccProfile {
    public var handle: OpaquePointer?

    public init() {
        self.handle = sk_colorspace_icc_profile_new()
    }

    deinit {
        sk_colorspace_icc_profile_delete(handle)
    }

    public func parse(buffer: UnsafeRawPointer, length: Int) -> Bool {
        return sk_colorspace_icc_profile_parse(buffer, length, handle)
    }

    public func getBuffer() -> (buffer: UnsafePointer<UInt8>?, size: UInt32) {
        var size: UInt32 = 0
        let buffer = sk_colorspace_icc_profile_get_buffer(handle, &size)
        return (buffer, size)
    }

    public func getToXYZD50() -> SkColorSpaceXYZ? {
        var toXYZD50 = SkColorSpaceXYZ()
        if sk_colorspace_icc_profile_get_to_xyzd50(handle, &toXYZD50.skColorSpaceXYZ) {
            return toXYZD50
        }
        return nil
    }
}

public extension SkColor4f {
    init(_ color: SkColor) {
        self.init()
        var skColor4f = sk_color4f_t()
        sk_color4f_from_color(color, &skColor4f)
        self.r = skColor4f.fR
        self.g = skColor4f.fG
        self.b = skColor4f.fB
        self.a = skColor4f.fA
    }

    var skColor: SkColor {
        var skColor4f = sk_color4f_t(fR: r, fG: g, fB: b, fA: a)
        return sk_color4f_to_color(&skColor4f)
    }
}