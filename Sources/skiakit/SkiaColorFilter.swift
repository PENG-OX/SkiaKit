import Foundation
import CSkia

public class SkColorFilter: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public static func makeMode(color: SkColor, blendMode: SkBlendMode) -> SkColorFilter? {
        guard let handle = sk_colorfilter_new_mode(color, blendMode.skBlendMode) else { return nil }
        return SkColorFilter(handle: handle)
    }

    public static func makeLighting(mul: SkColor, add: SkColor) -> SkColorFilter? {
        guard let handle = sk_colorfilter_new_lighting(mul, add) else { return nil }
        return SkColorFilter(handle: handle)
    }

    public static func makeCompose(outer: SkColorFilter, inner: SkColorFilter) -> SkColorFilter? {
        guard let handle = sk_colorfilter_new_compose(outer.handle, inner.handle) else { return nil }
        return SkColorFilter(handle: handle)
    }

    public static func makeColorMatrix(array: [Float]) -> SkColorFilter? {
        guard array.count == 20 else { return nil }
        guard let handle = array.withUnsafeBufferPointer({ ptr in
            sk_colorfilter_new_color_matrix(ptr.baseAddress)
        }) else { return nil }
        return SkColorFilter(handle: handle)
    }

    public static func makeHSLAMatrix(array: [Float]) -> SkColorFilter? {
        guard array.count == 20 else { return nil }
        guard let handle = array.withUnsafeBufferPointer({ ptr in
            sk_colorfilter_new_hsla_matrix(ptr.baseAddress)
        }) else { return nil }
        return SkColorFilter(handle: handle)
    }

    public static func makeLinearToSRGBGamma() -> SkColorFilter? {
        guard let handle = sk_colorfilter_new_linear_to_srgb_gamma() else { return nil }
        return SkColorFilter(handle: handle)
    }

    public static func makeSRGBToLinearGamma() -> SkColorFilter? {
        guard let handle = sk_colorfilter_new_srgb_to_linear_gamma() else { return nil }
        return SkColorFilter(handle: handle)
    }

    public static func makeLerp(weight: Float, filter0: SkColorFilter, filter1: SkColorFilter) -> SkColorFilter? {
        guard let handle = sk_colorfilter_new_lerp(weight, filter0.handle, filter1.handle) else { return nil }
        return SkColorFilter(handle: handle)
    }

    public static func makeLumaColor() -> SkColorFilter? {
        guard let handle = sk_colorfilter_new_luma_color() else { return nil }
        return SkColorFilter(handle: handle)
    }

    public static func makeHighContrast(config: SkHighContrastConfig) -> SkColorFilter? {
        var skConfig = config.skHighContrastConfig
        guard let handle = sk_colorfilter_new_high_contrast(&skConfig) else { return nil }
        return SkColorFilter(handle: handle)
    }

    public static func makeTable(table: [UInt8]) -> SkColorFilter? {
        guard table.count == 256 else { return nil }
        guard let handle = table.withUnsafeBufferPointer({ ptr in
            sk_colorfilter_new_table(ptr.baseAddress)
        }) else { return nil }
        return SkColorFilter(handle: handle)
    }

    public static func makeTableARGB(tableA: [UInt8]?, tableR: [UInt8]?, tableG: [UInt8]?, tableB: [UInt8]?) -> SkColorFilter? {
        guard let handle = tableA?.withUnsafeBufferPointer({ ptrA in
            tableR?.withUnsafeBufferPointer({ ptrR in
                tableG?.withUnsafeBufferPointer({ ptrG in
                    tableB?.withUnsafeBufferPointer({ ptrB in
                        sk_colorfilter_new_table_argb(ptrA.baseAddress, ptrR.baseAddress, ptrG.baseAddress, ptrB.baseAddress)
                    }) ?? sk_colorfilter_new_table_argb(ptrA.baseAddress, ptrR.baseAddress, ptrG.baseAddress, nil)
                }) ?? sk_colorfilter_new_table_argb(ptrA.baseAddress, ptrR.baseAddress, nil, nil)
            }) ?? sk_colorfilter_new_table_argb(ptrA.baseAddress, nil, nil, nil)
        }) ?? sk_colorfilter_new_table_argb(nil, nil, nil, nil) else { return nil }
        return SkColorFilter(handle: handle)
    }
}

public struct SkHighContrastConfig {
    public var enabled: Bool
    public var inverted: Bool
    public var grayscale: Bool
    public var highContrast: Bool

    public init(enabled: Bool, inverted: Bool, grayscale: Bool, highContrast: Bool) {
        self.enabled = enabled
        self.inverted = inverted
        self.grayscale = grayscale
        self.highContrast = highContrast
    }

    public init(_ config: sk_highcontrastconfig_t) {
        self.enabled = config.fEnabled
        self.inverted = config.fInverted
        self.grayscale = config.fGrayscale
        self.highContrast = config.fHighContrast
    }

    public var skHighContrastConfig: sk_highcontrastconfig_t {
        return sk_highcontrastconfig_t(
            fEnabled: enabled,
            fInverted: inverted,
            fGrayscale: grayscale,
            fHighContrast: highContrast
        )
    }
}