import Foundation
import CSkia

// MARK: - Basic Types

public typealias SkColor = UInt32
public typealias SkPMColor = UInt32

public extension SkColor {
    static func fromARGB(a: UInt8, r: UInt8, g: UInt8, b: UInt8) -> SkColor {
        return sk_color_set_argb(a, r, g, b)
    }

    var alpha: UInt8 {
        return sk_color_get_a(self)
    }

    var red: UInt8 {
        return sk_color_get_r(self)
    }

    var green: UInt8 {
        return sk_color_get_g(self)
    }

    var blue: UInt8 {
        return sk_color_get_b(self)
    }
}

public struct SkColor4f {
    public var r: Float
    public var g: Float
    public var b: Float
    public var a: Float

    public init(r: Float, g: Float, b: Float, a: Float) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }

    public init(_ color4f: sk_color4f_t) {
        self.r = color4f.fR
        self.g = color4f.fG
        self.b = color4f.fB
        self.a = color4f.fA
    }

    public var skColor4f: sk_color4f_t {
        return sk_color4f_t(fR: r, fG: g, fB: b, fA: a)
    }

    public var toSkColor: SkColor {
        var c4f = self.skColor4f
        return sk_color4f_to_color(&c4f)
    }

    public static func fromSkColor(_ color: SkColor) -> SkColor4f {
        var c4f = sk_color4f_t()
        sk_color4f_from_color(color, &c4f)
        return SkColor4f(c4f)
    }
}

public struct SkPoint {
    public var x: Float
    public var y: Float

    public init(x: Float, y: Float) {
        self.x = x
        self.y = y
    }

    public init(_ point: sk_point_t) {
        self.x = point.x
        self.y = point.y
    }

    public var skPoint: sk_point_t {
        return sk_point_t(x: x, y: y)
    }
}

public typealias SkVector = SkPoint

public struct SkIPoint {
    public var x: Int32
    public var y: Int32

    public init(x: Int32, y: Int32) {
        self.x = x
        self.y = y
    }

    public init(_ ipoint: sk_ipoint_t) {
        self.x = ipoint.x
        self.y = ipoint.y
    }

    public var skIPoint: sk_ipoint_t {
        return sk_ipoint_t(x: x, y: y)
    }
}

public struct SkSize {
    public var width: Float
    public var height: Float

    public init(width: Float, height: Float) {
        self.width = width
        self.height = height
    }

    public init(_ size: sk_size_t) {
        self.width = size.w
        self.height = size.h
    }

    public var skSize: sk_size_t {
        return sk_size_t(w: width, h: height)
    }
}

public struct SkISize {
    public var width: Int32
    public var height: Int32

    public init(width: Int32, height: Int32) {
        self.width = width
        self.height = height
    }

    public init(_ isize: sk_isize_t) {
        self.width = isize.w
        self.height = isize.h
    }

    public var skISize: sk_isize_t {
        return sk_isize_t(w: width, h: height)
    }
}

public struct SkRect {
    public var left: Float
    public var top: Float
    public var right: Float
    public var bottom: Float

    public init(left: Float, top: Float, right: Float, bottom: Float) {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
    }

    public init(_ rect: sk_rect_t) {
        self.left = rect.left
        self.top = rect.top
        self.right = rect.right
        self.bottom = rect.bottom
    }

    public var skRect: sk_rect_t {
        return sk_rect_t(left: left, top: top, right: right, bottom: bottom)
    }
}

public struct SkIRect {
    public var left: Int32
    public var top: Int32
    public var right: Int32
    public var bottom: Int32

    public init(left: Int32, top: Int32, right: Int32, bottom: Int32) {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
    }

    public init(_ irect: sk_irect_t) {
        self.left = irect.left
        self.top = irect.top
        self.right = irect.right
        self.bottom = irect.bottom
    }

    public var skIRect: sk_irect_t {
        return sk_irect_t(left: left, top: top, right: right, bottom: bottom)
    }
}

public struct SkMatrix {
    public var scaleX: Float
    public var skewX: Float
    public var transX: Float
    public var skewY: Float
    public var scaleY: Float
    public var transY: Float
    public var persp0: Float
    public var persp1: Float
    public var persp2: Float

    public init(scaleX: Float, skewX: Float, transX: Float,
                skewY: Float, scaleY: Float, transY: Float,
                persp0: Float, persp1: Float, persp2: Float) {
        self.scaleX = scaleX
        self.skewX = skewX
        self.transX = transX
        self.skewY = skewY
        self.scaleY = scaleY
        self.transY = transY
        self.persp0 = persp0
        self.persp1 = persp1
        self.persp2 = persp2
    }

    public init(_ matrix: sk_matrix_t) {
        self.scaleX = matrix.scaleX
        self.skewX = matrix.skewX
        self.transX = matrix.transX
        self.skewY = matrix.skewY
        self.scaleY = matrix.scaleY
        self.transY = matrix.transY
        self.persp0 = matrix.persp0
        self.persp1 = matrix.persp1
        self.persp2 = matrix.persp2
    }

    public var skMatrix: sk_matrix_t {
        return sk_matrix_t(scaleX: scaleX, skewX: skewX, transX: transX,
                           skewY: skewY, scaleY: scaleY, transY: transY,
                           persp0: persp0, persp1: persp1, persp2: persp2)
    }
}

public struct SkMatrix44 {
    public var m00, m01, m02, m03: Float
    public var m10, m11, m12, m13: Float
    public var m20, m21, m22, m23: Float
    public var m30, m31, m32, m33: Float

    public init(m00: Float, m01: Float, m02: Float, m03: Float,
                m10: Float, m11: Float, m12: Float, m13: Float,
                m20: Float, m21: Float, m22: Float, m23: Float,
                m30: Float, m31: Float, m32: Float, m33: Float) {
        self.m00 = m00; self.m01 = m01; self.m02 = m02; self.m03 = m03
        self.m10 = m10; self.m11 = m11; self.m12 = m12; self.m13 = m13
        self.m20 = m20; self.m21 = m21; self.m22 = m22; self.m23 = m23
        self.m30 = m30; self.m31 = m31; self.m32 = m32; self.m33 = m33
    }

    public init(_ matrix: sk_matrix44_t) {
        self.m00 = matrix.m00; self.m01 = matrix.m01; self.m02 = matrix.m02; self.m03 = matrix.m03
        self.m10 = matrix.m10; self.m11 = matrix.m11; self.m12 = matrix.m12; self.m13 = matrix.m13
        self.m20 = matrix.m20; self.m21 = matrix.m21; self.m22 = matrix.m22; self.m23 = matrix.m23
        self.m30 = matrix.m30; self.m31 = matrix.m31; self.m32 = matrix.m32; self.m33 = matrix.m33
    }

    public var skMatrix44: sk_matrix44_t {
        return sk_matrix44_t(m00: m00, m01: m01, m02: m02, m03: m03,
                             m10: m10, m11: m11, m12: m12, m13: m13,
                             m20: m20, m21: m21, m22: m22, m23: m23,
                             m30: m30, m31: m31, m32: m32, m33: m33)
    }
}

public struct SkPoint3 {
    public var x: Float
    public var y: Float
    public var z: Float

    public init(x: Float, y: Float, z: Float) {
        self.x = x
        self.y = y
        self.z = z
    }

    public init(_ point3: sk_point3_t) {
        self.x = point3.x
        self.y = point3.y
        self.z = point3.z
    }

    public var skPoint3: sk_point3_t {
        return sk_point3_t(x: x, y: y, z: z)
    }
}

public struct SkRSXform {
    public var fSCos: Float
    public var fSSin: Float
    public var fTX: Float
    public var fTY: Float

    public init(fSCos: Float, fSSin: Float, fTX: Float, fTY: Float) {
        self.fSCos = fSCos
        self.fSSin = fSSin
        self.fTX = fTX
        self.fTY = fTY
    }

    public init(_ rsxform: sk_rsxform_t) {
        self.fSCos = rsxform.fSCos
        self.fSSin = rsxform.fSSin
        self.fTX = rsxform.fTX
        self.fTY = rsxform.fTY
    }

    public var skRSXform: sk_rsxform_t {
        return sk_rsxform_t(fSCos: fSCos, fSSin: fSSin, fTX: fTX, fTY: fTY)
    }
}

// MARK: - Enums

public enum SkColorType: UInt32 {
    case unknown = 0
    case alpha8
    case rgb565
    case argb4444
    case rgba8888
    case rgb888x
    case bgra8888
    case rgba1010102
    case bgra1010102
    case rgb101010x
    case bgr101010x
    case bgr101010xXr
    case rgba10x6
    case gray8
    case rgbaF16Norm
    case rgbaF16
    case rgbaF32

    // READONLY
    case r8g8Unorm
    case a16Float
    case r16g16Float
    case a16Unorm
    case r16g16Unorm
    case r16g16b16a16Unorm
    case srgbA8888
    case r8Unorm

    public init(_ type: sk_colortype_t) {
        self = SkColorType(rawValue: type.rawValue) ?? .unknown
    }

    public var skColorType: sk_colortype_t {
        return sk_colortype_t(rawValue: rawValue)
    }
}

public enum SkAlphaType: UInt32 {
    case unknown = 0
    case opaque
    case premul
    case unpremul

    public init(_ type: sk_alphatype_t) {
        self = SkAlphaType(rawValue: type.rawValue) ?? .unknown
    }

    public var skAlphaType: sk_alphatype_t {
        return sk_alphatype_t(rawValue: rawValue)
    }
}

public enum SkPixelGeometry: UInt32 {
    case unknown = 0
    case rgbH
    case bgrH
    case rgbV
    case bgrV

    public init(_ geometry: sk_pixelgeometry_t) {
        self = SkPixelGeometry(rawValue: geometry.rawValue) ?? .unknown
    }

    public var skPixelGeometry: sk_pixelgeometry_t {
        return sk_pixelgeometry_t(rawValue: rawValue)
    }
}

public struct SkSurfacePropsFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let none = SkSurfacePropsFlags(rawValue: NONE_SK_SURFACE_PROPS_FLAGS.rawValue)
    public static let useDeviceIndependentFonts = SkSurfacePropsFlags(rawValue: USE_DEVICE_INDEPENDENT_FONTS_SK_SURFACE_PROPS_FLAGS.rawValue)

    public init(_ flags: sk_surfaceprops_flags_t) {
        self.rawValue = flags.rawValue
    }

    public var skSurfacePropsFlags: sk_surfaceprops_flags_t {
        return sk_surfaceprops_flags_t(rawValue: rawValue)
    }
}

public enum SkBlendMode: UInt32 {
    case clear = 0
    case src
    case dst
    case srcOver
    case dstOver
    case srcIn
    case dstIn
    case srcOut
    case dstOut
    case srcATop
    case dstATop
    case xor
    case plus
    case modulate
    case screen
    case overlay
    case darken
    case lighten
    case colorDodge
    case colorBurn
    case hardLight
    case softLight
    case difference
    case exclusion
    case multiply
    case hue
    case saturation
    case color
    case luminosity

    public init(_ mode: sk_blendmode_t) {
        self = SkBlendMode(rawValue: mode.rawValue) ?? .clear
    }

    public var skBlendMode: sk_blendmode_t {
        return sk_blendmode_t(rawValue: rawValue)
    }
}

public enum SkPointMode: UInt32 {
    case points = 0
    case lines
    case polygon

    public init(_ mode: sk_point_mode_t) {
        self = SkPointMode(rawValue: mode.rawValue) ?? .points
    }

    public var skPointMode: sk_point_mode_t {
        return sk_point_mode_t(rawValue: rawValue)
    }
}

public enum SkTextAlign: UInt32 {
    case left = 0
    case center
    case right

    public init(_ align: sk_text_align_t) {
        self = SkTextAlign(rawValue: align.rawValue) ?? .left
    }

    public var skTextAlign: sk_text_align_t {
        return sk_text_align_t(rawValue: rawValue)
    }
}

public enum SkTextEncoding: UInt32 {
    case utf8 = 0
    case utf16
    case utf32
    case glyphId

    public init(_ encoding: sk_text_encoding_t) {
        self = SkTextEncoding(rawValue: encoding.rawValue) ?? .utf8
    }

    public var skTextEncoding: sk_text_encoding_t {
        return sk_text_encoding_t(rawValue: rawValue)
    }
}

public enum SkPathFillType: UInt32 {
    case winding = 0
    case evenOdd
    case inverseWinding
    case inverseEvenOdd

    public init(_ type: sk_path_filltype_t) {
        self = SkPathFillType(rawValue: type.rawValue) ?? .winding
    }

    public var skPathFillType: sk_path_filltype_t {
        return sk_path_filltype_t(rawValue: rawValue)
    }
}

public enum SkFontStyleSlant: UInt32 {
    case upright = 0
    case italic
    case oblique

    public init(_ slant: sk_font_style_slant_t) {
        self = SkFontStyleSlant(rawValue: slant.rawValue) ?? .upright
    }

    public var skFontStyleSlant: sk_font_style_slant_t {
        return sk_font_style_slant_t(rawValue: rawValue)
    }
}

public enum SkColorChannel: UInt32 {
    case r = 0
    case g
    case b
    case a

    public init(_ channel: sk_color_channel_t) {
        self = SkColorChannel(rawValue: channel.rawValue) ?? .r
    }

    public var skColorChannel: sk_color_channel_t {
        return sk_color_channel_t(rawValue: rawValue)
    }
}

public enum SkRegionOp: UInt32 {
    case difference = 0
    case intersect
    case unionOp
    case xorOp
    case reverseDifference
    case replace

    public init(_ op: sk_region_op_t) {
        self = SkRegionOp(rawValue: op.rawValue) ?? .difference
    }

    public var skRegionOp: sk_region_op_t {
        return sk_region_op_t(rawValue: rawValue)
    }
}

public enum SkClipOp: UInt32 {
    case difference = 0
    case intersect

    public init(_ op: sk_clipop_t) {
        self = SkClipOp(rawValue: op.rawValue) ?? .difference
    }

    public var skClipOp: sk_clipop_t {
        return sk_clipop_t(rawValue: rawValue)
    }
}

public enum SkEncodedImageFormat: UInt32 {
    case bmp = 0
    case gif
    case ico
    case jpeg
    case png
    case wbmp
    case webp
    case pkm
    case ktx
    case astc
    case dng
    case heif
    case avif
    case jpegxl

    public init(_ format: sk_encoded_image_format_t) {
        self = SkEncodedImageFormat(rawValue: format.rawValue) ?? .bmp
    }

    public var skEncodedImageFormat: sk_encoded_image_format_t {
        return sk_encoded_image_format_t(rawValue: rawValue)
    }
}

public enum SkEncodedOrigin: UInt32 {
    case topLeft = 1
    case topRight = 2
    case bottomRight = 3
    case bottomLeft = 4
    case leftTop = 5
    case rightTop = 6
    case rightBottom = 7
    case leftBottom = 8
    case `default` = 1

    public init(_ origin: sk_encodedorigin_t) {
        self = SkEncodedOrigin(rawValue: origin.rawValue) ?? .topLeft
    }

    public var skEncodedOrigin: sk_encodedorigin_t {
        return sk_encodedorigin_t(rawValue: rawValue)
    }
}

public enum SkCodecResult: UInt32 {
    case success = 0
    case incompleteInput
    case errorInInput
    case invalidConversion
    case invalidScale
    case invalidParameters
    case invalidInput
    case couldNotRewind
    case internalError
    case unimplemented

    public init(_ result: sk_codec_result_t) {
        self = SkCodecResult(rawValue: result.rawValue) ?? .success
    }

    public var skCodecResult: sk_codec_result_t {
        return sk_codec_result_t(rawValue: rawValue)
    }
}

public enum SkCodecZeroInitialized: UInt32 {
    case yes = 0
    case no

    public init(_ initialized: sk_codec_zero_initialized_t) {
        self = SkCodecZeroInitialized(rawValue: initialized.rawValue) ?? .yes
    }

    public var skCodecZeroInitialized: sk_codec_zero_initialized_t {
        return sk_codec_zero_initialized_t(rawValue: rawValue)
    }
}

public struct SkCodecOptions {
    public var zeroInitialized: SkCodecZeroInitialized
    public var subset: SkIRect?
    public var frameIndex: Int32
    public var priorFrame: Int32

    public init(zeroInitialized: SkCodecZeroInitialized, subset: SkIRect?, frameIndex: Int32, priorFrame: Int32) {
        self.zeroInitialized = zeroInitialized
        self.subset = subset
        self.frameIndex = frameIndex
        self.priorFrame = priorFrame
    }

    public init(_ options: sk_codec_options_t) {
        self.zeroInitialized = SkCodecZeroInitialized(options.fZeroInitialized)
        self.subset = options.fSubset.map { SkIRect($0.pointee) }
        self.frameIndex = options.fFrameIndex
        self.priorFrame = options.fPriorFrame
    }

    public var skCodecOptions: sk_codec_options_t {
        var subsetPtr: UnsafeMutablePointer<sk_irect_t>? = nil
        if var s = subset?.skIRect {
            subsetPtr = UnsafeMutablePointer<sk_irect_t>.allocate(capacity: 1)
            subsetPtr?.initialize(to: s)
        }
        return sk_codec_options_t(fZeroInitialized: zeroInitialized.skCodecZeroInitialized,
                                  fSubset: subsetPtr,
                                  fFrameIndex: frameIndex,
                                  fPriorFrame: priorFrame)
    }
}

public enum SkCodecScanlineOrder: UInt32 {
    case topDown = 0
    case bottomUp

    public init(_ order: sk_codec_scanline_order_t) {
        self = SkCodecScanlineOrder(rawValue: order.rawValue) ?? .topDown
    }

    public var skCodecScanlineOrder: sk_codec_scanline_order_t {
        return sk_codec_scanline_order_t(rawValue: rawValue)
    }
}

public enum SkPathVerb: UInt32 {
    case move = 0
    case line
    case quad
    case conic
    case cubic
    case close
    case done

    public init(_ verb: sk_path_verb_t) {
        self = SkPathVerb(rawValue: verb.rawValue) ?? .move
    }

    public var skPathVerb: sk_path_verb_t {
        return sk_path_verb_t(rawValue: rawValue)
    }
}

public enum SkPathAddMode: UInt32 {
    case append = 0
    case extend

    public init(_ mode: sk_path_add_mode_t) {
        self = SkPathAddMode(rawValue: mode.rawValue) ?? .append
    }

    public var skPathAddMode: sk_path_add_mode_t {
        return sk_path_add_mode_t(rawValue: rawValue)
    }
}

public struct SkPathSegmentMask: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let line = SkPathSegmentMask(rawValue: LINE_SK_PATH_SEGMENT_MASK.rawValue)
    public static let quad = SkPathSegmentMask(rawValue: QUAD_SK_PATH_SEGMENT_MASK.rawValue)
    public static let conic = SkPathSegmentMask(rawValue: CONIC_SK_PATH_SEGMENT_MASK.rawValue)
    public static let cubic = SkPathSegmentMask(rawValue: CUBIC_SK_PATH_SEGMENT_MASK.rawValue)

    public init(_ mask: sk_path_segment_mask_t) {
        self.rawValue = mask.rawValue
    }

    public var skPathSegmentMask: sk_path_segment_mask_t {
        return sk_path_segment_mask_t(rawValue: rawValue)
    }
}

public enum SkPathEffect1DStyle: UInt32 {
    case translate = 0
    case rotate
    case morph

    public init(_ style: sk_path_effect_1d_style_t) {
        self = SkPathEffect1DStyle(rawValue: style.rawValue) ?? .translate
    }

    public var skPathEffect1DStyle: sk_path_effect_1d_style_t {
        return sk_path_effect_1d_style_t(rawValue: rawValue)
    }
}

public enum SkPathEffectTrimMode: UInt32 {
    case normal = 0
    case inverted

    public init(_ mode: sk_path_effect_trim_mode_t) {
        self = SkPathEffectTrimMode(rawValue: mode.rawValue) ?? .normal
    }

    public var skPathEffectTrimMode: sk_path_effect_trim_mode_t {
        return sk_path_effect_trim_mode_t(rawValue: rawValue)
    }
}

public enum SkStrokeCap: UInt32 {
    case butt = 0
    case round
    case square

    public init(_ cap: sk_stroke_cap_t) {
        self = SkStrokeCap(rawValue: cap.rawValue) ?? .butt
    }

    public var skStrokeCap: sk_stroke_cap_t {
        return sk_stroke_cap_t(rawValue: rawValue)
    }
}

public enum SkStrokeJoin: UInt32 {
    case miter = 0
    case round
    case bevel

    public init(_ join: sk_stroke_join_t) {
        self = SkStrokeJoin(rawValue: join.rawValue) ?? .miter
    }

    public var skStrokeJoin: sk_stroke_join_t {
        return sk_stroke_join_t(rawValue: rawValue)
    }
}

public enum SkShaderTileMode: UInt32 {
    case clamp = 0
    case repeat
    case mirror
    case decal

    public init(_ mode: sk_shader_tilemode_t) {
        self = SkShaderTileMode(rawValue: mode.rawValue) ?? .clamp
    }

    public var skShaderTileMode: sk_shader_tilemode_t {
        return sk_shader_tilemode_t(rawValue: rawValue)
    }
}

public enum SkBlurStyle: UInt32 {
    case normal = 0
    case solid
    case outer
    case inner

    public init(_ style: sk_blurstyle_t) {
        self = SkBlurStyle(rawValue: style.rawValue) ?? .normal
    }

    public var skBlurStyle: sk_blurstyle_t {
        return sk_blurstyle_t(rawValue: rawValue)
    }
}

public enum SkPathDirection: UInt32 {
    case cw = 0
    case ccw

    public init(_ direction: sk_path_direction_t) {
        self = SkPathDirection(rawValue: direction.rawValue) ?? .cw
    }

    public var skPathDirection: sk_path_direction_t {
        return sk_path_direction_t(rawValue: rawValue)
    }
}

public enum SkPathArcSize: UInt32 {
    case small = 0
    case large

    public init(_ size: sk_path_arc_size_t) {
        self = SkPathArcSize(rawValue: size.rawValue) ?? .small
    }

    public var skPathArcSize: sk_path_arc_size_t {
        return sk_path_arc_size_t(rawValue: rawValue)
    }
}

public enum SkPaintStyle: UInt32 {
    case fill = 0
    case stroke
    case strokeAndFill

    public init(_ style: sk_paint_style_t) {
        self = SkPaintStyle(rawValue: style.rawValue) ?? .fill
    }

    public var skPaintStyle: sk_paint_style_t {
        return sk_paint_style_t(rawValue: rawValue)
    }
}

public enum SkFontHinting: UInt32 {
    case none = 0
    case slight
    case normal
    case full

    public init(_ hinting: sk_font_hinting_t) {
        self = SkFontHinting(rawValue: hinting.rawValue) ?? .none
    }

    public var skFontHinting: sk_font_hinting_t {
        return sk_font_hinting_t(rawValue: rawValue)
    }
}

public enum SkFontEdging: UInt32 {
    case alias = 0
    case antialias
    case subpixelAntialias

    public init(_ edging: sk_font_edging_t) {
        self = SkFontEdging(rawValue: edging.rawValue) ?? .alias
    }

    public var skFontEdging: sk_font_edging_t {
        return sk_font_edging_t(rawValue: rawValue)
    }
}

public enum GrSurfaceOrigin: UInt32 {
    case topLeft = 0
    case bottomLeft

    public init(_ origin: gr_surfaceorigin_t) {
        self = GrSurfaceOrigin(rawValue: origin.rawValue) ?? .topLeft
    }

    public var grSurfaceOrigin: gr_surfaceorigin_t {
        return gr_surfaceorigin_t(rawValue: rawValue)
    }
}

public struct GrContextOptions {
    public var avoidStencilBuffers: Bool
    public var runtimeProgramCacheSize: Int32
    public var glyphCacheTextureMaximumBytes: Int
    public var allowPathMaskCaching: Bool
    public var doManualMipmapping: Bool
    public var bufferMapThreshold: Int32

    public init(avoidStencilBuffers: Bool, runtimeProgramCacheSize: Int32, glyphCacheTextureMaximumBytes: Int,
                allowPathMaskCaching: Bool, doManualMipmapping: Bool, bufferMapThreshold: Int32) {
        self.avoidStencilBuffers = avoidStencilBuffers
        self.runtimeProgramCacheSize = runtimeProgramCacheSize
        self.glyphCacheTextureMaximumBytes = glyphCacheTextureMaximumBytes
        self.allowPathMaskCaching = allowPathMaskCaching
        self.doManualMipmapping = doManualMipmapping
        self.bufferMapThreshold = bufferMapThreshold
    }

    public init(_ options: gr_context_options_t) {
        self.avoidStencilBuffers = options.fAvoidStencilBuffers
        self.runtimeProgramCacheSize = options.fRuntimeProgramCacheSize
        self.glyphCacheTextureMaximumBytes = options.fGlyphCacheTextureMaximumBytes
        self.allowPathMaskCaching = options.fAllowPathMaskCaching
        self.doManualMipmapping = options.fDoManualMipmapping
        self.bufferMapThreshold = options.fBufferMapThreshold
    }

    public var grContextOptions: gr_context_options_t {
        return gr_context_options_t(fAvoidStencilBuffers: avoidStencilBuffers,
                                    fRuntimeProgramCacheSize: runtimeProgramCacheSize,
                                    fGlyphCacheTextureMaximumBytes: glyphCacheTextureMaximumBytes,
                                    fAllowPathMaskCaching: allowPathMaskCaching,
                                    fDoManualMipmapping: doManualMipmapping,
                                    fBufferMapThreshold: bufferMapThreshold)
    }
}

public enum GrBackend: UInt32 {
    case openGL = 0
    case vulkan
    case metal
    case direct3d
    case unsupported = 5

    public init(_ backend: gr_backend_t) {
        self = GrBackend(rawValue: backend.rawValue) ?? .unsupported
    }

    public var grBackend: gr_backend_t {
        return gr_backend_t(rawValue: rawValue)
    }
}

public struct GrGLTextureInfo {
    public var target: UInt32
    public var id: UInt32
    public var format: UInt32
    public var `protected`: Bool

    public init(target: UInt32, id: UInt32, format: UInt32, `protected`: Bool) {
        self.target = target
        self.id = id
        self.format = format
        self.`protected` = `protected`
    }

    public init(_ info: gr_gl_textureinfo_t) {
        self.target = info.fTarget
        self.id = info.fID
        self.format = info.fFormat
        self.`protected` = info.fProtected
    }

    public var grGLTextureInfo: gr_gl_textureinfo_t {
        return gr_gl_textureinfo_t(fTarget: target, fID: id, fFormat: format, fProtected: `protected`)
    }
}

public struct GrGLFramebufferInfo {
    public var fboId: UInt32
    public var format: UInt32
    public var `protected`: Bool

    public init(fboId: UInt32, format: UInt32, `protected`: Bool) {
        self.fboId = fboId
        self.format = format
        self.`protected` = `protected`
    }

    public init(_ info: gr_gl_framebufferinfo_t) {
        self.fboId = info.fFBOID
        self.format = info.fFormat
        self.`protected` = info.fProtected
    }

    public var grGLFramebufferInfo: gr_gl_framebufferinfo_t {
        return gr_gl_framebufferinfo_t(fFBOID: fboId, fFormat: format, fProtected: `protected`)
    }
}

public struct GrVkBackendContext {
    public var instance: OpaquePointer?
    public var physicalDevice: OpaquePointer?
    public var device: OpaquePointer?
    public var queue: OpaquePointer?
    public var graphicsQueueIndex: UInt32
    public var minAPIVersion: UInt32
    public var instanceVersion: UInt32
    public var maxAPIVersion: UInt32
    public var extensions: UInt32
    public var vkExtensions: UnsafePointer<gr_vk_extensions_t>?
    public var features: UInt32
    public var deviceFeatures: UnsafePointer<vk_physical_device_features_t>?
    public var deviceFeatures2: UnsafePointer<vk_physical_device_features_2_t>?
    public var memoryAllocator: OpaquePointer?
    public var getProc: gr_vk_get_proc?
    public var getProcUserData: UnsafeMutableRawPointer?
    public var ownsInstanceAndDevice: Bool
    public var protectedContext: Bool

    public init(instance: OpaquePointer?, physicalDevice: OpaquePointer?, device: OpaquePointer?, queue: OpaquePointer?,
                graphicsQueueIndex: UInt32, minAPIVersion: UInt32, instanceVersion: UInt32, maxAPIVersion: UInt32,
                extensions: UInt32, vkExtensions: UnsafePointer<gr_vk_extensions_t>?, features: UInt32,
                deviceFeatures: UnsafePointer<vk_physical_device_features_t>?, deviceFeatures2: UnsafePointer<vk_physical_device_features_2_t>?,
                memoryAllocator: OpaquePointer?, getProc: gr_vk_get_proc?, getProcUserData: UnsafeMutableRawPointer?,
                ownsInstanceAndDevice: Bool, protectedContext: Bool) {
        self.instance = instance
        self.physicalDevice = physicalDevice
        self.device = device
        self.queue = queue
        self.graphicsQueueIndex = graphicsQueueIndex
        self.minAPIVersion = minAPIVersion
        self.instanceVersion = instanceVersion
        self.maxAPIVersion = maxAPIVersion
        self.extensions = extensions
        self.vkExtensions = vkExtensions
        self.features = features
        self.deviceFeatures = deviceFeatures
        self.deviceFeatures2 = deviceFeatures2
        self.memoryAllocator = memoryAllocator
        self.getProc = getProc
        self.getProcUserData = getProcUserData
        self.ownsInstanceAndDevice = ownsInstanceAndDevice
        self.protectedContext = protectedContext
    }

    public init(_ context: gr_vk_backendcontext_t) {
        self.instance = context.fInstance
        self.physicalDevice = context.fPhysicalDevice
        self.device = context.fDevice
        self.queue = context.fQueue
        self.graphicsQueueIndex = context.fGraphicsQueueIndex
        self.minAPIVersion = context.fMinAPIVersion
        self.instanceVersion = context.fInstanceVersion
        self.maxAPIVersion = context.fMaxAPIVersion
        self.extensions = context.fExtensions
        self.vkExtensions = context.fVkExtensions
        self.features = context.fFeatures
        self.deviceFeatures = context.fDeviceFeatures
        self.deviceFeatures2 = context.fDeviceFeatures2
        self.memoryAllocator = context.fMemoryAllocator
        self.getProc = context.fGetProc
        self.getProcUserData = context.fGetProcUserData
        self.ownsInstanceAndDevice = context.fOwnsInstanceAndDevice
        self.protectedContext = context.fProtectedContext
    }

    public var grVkBackendContext: gr_vk_backendcontext_t {
        return gr_vk_backendcontext_t(fInstance: instance, fPhysicalDevice: physicalDevice, fDevice: device, fQueue: queue,
                                      fGraphicsQueueIndex: graphicsQueueIndex, fMinAPIVersion: minAPIVersion, fInstanceVersion: instanceVersion,
                                      fMaxAPIVersion: maxAPIVersion, fExtensions: extensions, fVkExtensions: vkExtensions,
                                      fFeatures: features, fDeviceFeatures: deviceFeatures, fDeviceFeatures2: deviceFeatures2,
                                      fMemoryAllocator: memoryAllocator, fGetProc: getProc, fGetProcUserData: getProcUserData,
                                      fOwnsInstanceAndDevice: ownsInstanceAndDevice, fProtectedContext: protectedContext)
    }
}

public struct GrVkAlloc {
    public var memory: UInt64
    public var offset: UInt64
    public var size: UInt64
    public var flags: UInt32
    public var backendMemory: Int
    public var usesSystemHeap: Bool

    public init(memory: UInt64, offset: UInt64, size: UInt64, flags: UInt32, backendMemory: Int, usesSystemHeap: Bool) {
        self.memory = memory
        self.offset = offset
        self.size = size
        self.flags = flags
        self.backendMemory = backendMemory
        self.usesSystemHeap = usesSystemHeap
    }

    public init(_ alloc: gr_vk_alloc_t) {
        self.memory = alloc.fMemory
        self.offset = alloc.fOffset
        self.size = alloc.fSize
        self.flags = alloc.fFlags
        self.backendMemory = alloc.fBackendMemory
        self.usesSystemHeap = alloc._private_fUsesSystemHeap
    }

    public var grVkAlloc: gr_vk_alloc_t {
        return gr_vk_alloc_t(fMemory: memory, fOffset: offset, fSize: size, fFlags: flags,
                             fBackendMemory: gr_vk_backendmemory_t(backendMemory), _private_fUsesSystemHeap: usesSystemHeap)
    }
}

public struct GrVkYcbcrConversionInfo {
    public var format: UInt32
    public var externalFormat: UInt64
    public var ycbcrModel: UInt32
    public var ycbcrRange: UInt32
    public var xChromaOffset: UInt32
    public var yChromaOffset: UInt32
    public var chromaFilter: UInt32
    public var forceExplicitReconstruction: UInt32
    public var formatFeatures: UInt32

    public init(format: UInt32, externalFormat: UInt64, ycbcrModel: UInt32, ycbcrRange: UInt32,
                xChromaOffset: UInt32, yChromaOffset: UInt32, chromaFilter: UInt32,
                forceExplicitReconstruction: UInt32, formatFeatures: UInt32) {
        self.format = format
        self.externalFormat = externalFormat
        self.ycbcrModel = ycbcrModel
        self.ycbcrRange = ycbcrRange
        self.xChromaOffset = xChromaOffset
        self.yChromaOffset = yChromaOffset
        self.chromaFilter = chromaFilter
        self.forceExplicitReconstruction = forceExplicitReconstruction
        self.formatFeatures = formatFeatures
    }

    public init(_ info: gr_vk_ycbcrconversioninfo_t) {
        self.format = info.fFormat
        self.externalFormat = info.fExternalFormat
        self.ycbcrModel = info.fYcbcrModel
        self.ycbcrRange = info.fYcbcrRange
        self.xChromaOffset = info.fXChromaOffset
        self.yChromaOffset = info.fYChromaOffset
        self.chromaFilter = info.fChromaFilter
        self.forceExplicitReconstruction = info.fForceExplicitReconstruction
        self.formatFeatures = info.fFormatFeatures
    }

    public var grVkYcbcrConversionInfo: gr_vk_ycbcrconversioninfo_t {
        return gr_vk_ycbcrconversioninfo_t(fFormat: format, fExternalFormat: externalFormat, fYcbcrModel: ycbcrModel,
                                           fYcbcrRange: ycbcrRange, fXChromaOffset: xChromaOffset, fYChromaOffset: yChromaOffset,
                                           fChromaFilter: chromaFilter, fForceExplicitReconstruction: forceExplicitReconstruction,
                                           fFormatFeatures: formatFeatures)
    }
}

public struct GrVkImageInfo {
    public var image: UInt64
    public var alloc: GrVkAlloc
    public var imageTiling: UInt32
    public var imageLayout: UInt32
    public var format: UInt32
    public var imageUsageFlags: UInt32
    public var sampleCount: UInt32
    public var levelCount: UInt32
    public var currentQueueFamily: UInt32
    public var `protected`: Bool
    public var ycbcrConversionInfo: GrVkYcbcrConversionInfo
    public var sharingMode: UInt32

    public init(image: UInt64, alloc: GrVkAlloc, imageTiling: UInt32, imageLayout: UInt32, format: UInt32,
                imageUsageFlags: UInt32, sampleCount: UInt32, levelCount: UInt32, currentQueueFamily: UInt32,
                `protected`: Bool, ycbcrConversionInfo: GrVkYcbcrConversionInfo, sharingMode: UInt32) {
        self.image = image
        self.alloc = alloc
        self.imageTiling = imageTiling
        self.imageLayout = imageLayout
        self.format = format
        self.imageUsageFlags = imageUsageFlags
        self.sampleCount = sampleCount
        self.levelCount = levelCount
        self.currentQueueFamily = currentQueueFamily
        self.`protected` = `protected`
        self.ycbcrConversionInfo = ycbcrConversionInfo
        self.sharingMode = sharingMode
    }

    public init(_ info: gr_vk_imageinfo_t) {
        self.image = info.fImage
        self.alloc = GrVkAlloc(info.fAlloc)
        self.imageTiling = info.fImageTiling
        self.imageLayout = info.fImageLayout
        self.format = info.fFormat
        self.imageUsageFlags = info.fImageUsageFlags
        self.sampleCount = info.fSampleCount
        self.levelCount = info.fLevelCount
        self.currentQueueFamily = info.fCurrentQueueFamily
        self.`protected` = info.fProtected
        self.ycbcrConversionInfo = GrVkYcbcrConversionInfo(info.fYcbcrConversionInfo)
        self.sharingMode = info.fSharingMode
    }

    public var grVkImageInfo: gr_vk_imageinfo_t {
        return gr_vk_imageinfo_t(fImage: image, fAlloc: alloc.grVkAlloc, fImageTiling: imageTiling,
                                 fImageLayout: imageLayout, fFormat: format, fImageUsageFlags: imageUsageFlags,
                                 fSampleCount: sampleCount, fLevelCount: levelCount, fCurrentQueueFamily: currentQueueFamily,
                                 fProtected: `protected`, fYcbcrConversionInfo: ycbcrConversionInfo.grVkYcbcrConversionInfo,
                                 fSharingMode: sharingMode)
    }
}

public struct GrMtlTextureInfo {
    public var texture: OpaquePointer?

    public init(texture: OpaquePointer?) {
        self.texture = texture
    }

    public init(_ info: gr_mtl_textureinfo_t) {
        self.texture = UnsafeMutableRawPointer(mutating: info.fTexture)
    }

    public var grMtlTextureInfo: gr_mtl_textureinfo_t {
        return gr_mtl_textureinfo_t(fTexture: texture)
    }
}

public enum SkPathOp: UInt32 {
    case difference = 0
    case intersect
    case unionOp
    case xorOp
    case reverseDifference

    public init(_ op: sk_pathop_t) {
        self = SkPathOp(rawValue: op.rawValue) ?? .difference
    }

    public var skPathOp: sk_pathop_t {
        return sk_pathop_t(rawValue: rawValue)
    }
}

public enum SkLatticeRectType: UInt32 {
    case `default` = 0
    case transparent
    case fixedColor

    public init(_ type: sk_lattice_recttype_t) {
        self = SkLatticeRectType(rawValue: type.rawValue) ?? .default
    }

    public var skLatticeRectType: sk_lattice_recttype_t {
        return sk_lattice_recttype_t(rawValue: rawValue)
    }
}

public struct SkLattice {
    public var xDivs: UnsafePointer<Int32>?
    public var yDivs: UnsafePointer<Int32>?
    public var rectTypes: UnsafePointer<SkLatticeRectType>?
    public var xCount: Int32
    public var yCount: Int32
    public var bounds: UnsafePointer<SkRect>?
    public var colors: UnsafePointer<SkColor>?

    public init(xDivs: UnsafePointer<Int32>?, yDivs: UnsafePointer<Int32>?, rectTypes: UnsafePointer<SkLatticeRectType>?,
                xCount: Int32, yCount: Int32, bounds: UnsafePointer<SkRect>?, colors: UnsafePointer<SkColor>?) {
        self.xDivs = xDivs
        self.yDivs = yDivs
        self.rectTypes = rectTypes
        self.xCount = xCount
        self.yCount = yCount
        self.bounds = bounds
        self.colors = colors
    }

    public init(_ lattice: sk_lattice_t) {
        self.xDivs = lattice.fXDivs
        self.yDivs = lattice.fYDivs
        self.rectTypes = UnsafePointer(OpaquePointer(lattice.fRectTypes))
        self.xCount = lattice.fXCount
        self.yCount = lattice.fYCount
        self.bounds = UnsafePointer(OpaquePointer(lattice.fBounds))
        self.colors = UnsafePointer(OpaquePointer(lattice.fColors))
    }

    public var skLattice: sk_lattice_t {
        return sk_lattice_t(fXDivs: xDivs, fYDivs: yDivs,
                            fRectTypes: UnsafePointer(OpaquePointer(rectTypes)),
                            fXCount: xCount, fYCount: yCount,
                            fBounds: UnsafePointer(OpaquePointer(bounds)),
                            fColors: UnsafePointer(OpaquePointer(colors)))
    }
}

public struct SkPathMeasureMatrixFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let getPosition = SkPathMeasureMatrixFlags(rawValue: GET_POSITION_SK_PATHMEASURE_MATRIXFLAGS.rawValue)
    public static let getTangent = SkPathMeasureMatrixFlags(rawValue: GET_TANGENT_SK_PATHMEASURE_MATRIXFLAGS.rawValue)
    public static let getPosAndTan = SkPathMeasureMatrixFlags(rawValue: GET_POS_AND_TAN_SK_PATHMEASURE_MATRIXFLAGS.rawValue)

    public init(_ flags: sk_pathmeasure_matrixflags_t) {
        self.rawValue = flags.rawValue
    }

    public var skPathMeasureMatrixFlags: sk_pathmeasure_matrixflags_t {
        return sk_pathmeasure_matrixflags_t(rawValue: rawValue)
    }
}

public enum SkImageCachingHint: UInt32 {
    case allow = 0
    case disallow

    public init(_ hint: sk_image_caching_hint_t) {
        self = SkImageCachingHint(rawValue: hint.rawValue) ?? .allow
    }

    public var skImageCachingHint: sk_image_caching_hint_t {
        return sk_image_caching_hint_t(rawValue: rawValue)
    }
}

public struct SkBitmapAllocFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let none = SkBitmapAllocFlags(rawValue: NONE_SK_BITMAP_ALLOC_FLAGS.rawValue)
    public static let zeroPixels = SkBitmapAllocFlags(rawValue: ZERO_PIXELS_SK_BITMAP_ALLOC_FLAGS.rawValue)

    public init(_ flags: sk_bitmap_allocflags_t) {
        self.rawValue = flags.rawValue
    }

    public var skBitmapAllocFlags: sk_bitmap_allocflags_t {
        return sk_bitmap_allocflags_t(rawValue: rawValue)
    }
}

public struct SkDocumentPDFDateTime {
    public var timeZoneMinutes: Int16
    public var year: UInt16
    public var month: UInt8
    public var dayOfWeek: UInt8
    public var day: UInt8
    public var hour: UInt8
    public var minute: UInt8
    public var second: UInt8

    public init(timeZoneMinutes: Int16, year: UInt16, month: UInt8, dayOfWeek: UInt8, day: UInt8, hour: UInt8, minute: UInt8, second: UInt8) {
        self.timeZoneMinutes = timeZoneMinutes
        self.year = year
        self.month = month
        self.dayOfWeek = dayOfWeek
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
    }

    public init(_ datetime: sk_document_pdf_datetime_t) {
        self.timeZoneMinutes = datetime.fTimeZoneMinutes
        self.year = datetime.fYear
        self.month = datetime.fMonth
        self.dayOfWeek = datetime.fDayOfWeek
        self.day = datetime.fDay
        self.hour = datetime.fHour
        self.minute = datetime.fMinute
        self.second = datetime.fSecond
    }

    public var skDocumentPDFDateTime: sk_document_pdf_datetime_t {
        return sk_document_pdf_datetime_t(fTimeZoneMinutes: timeZoneMinutes, fYear: year, fMonth: month,
                                          fDayOfWeek: dayOfWeek, fDay: day, fHour: hour, fMinute: minute, fSecond: second)
    }
}

public struct SkDocumentPDFMetadata {
    public var title: SkString?
    public var author: SkString?
    public var subject: SkString?
    public var keywords: SkString?
    public var creator: SkString?
    public var producer: SkString?
    public var creation: SkDocumentPDFDateTime?
    public var modified: SkDocumentPDFDateTime?
    public var rasterDPI: Float
    public var pdfA: Bool
    public var encodingQuality: Int32

    public init(title: SkString?, author: SkString?, subject: SkString?, keywords: SkString?,
                creator: SkString?, producer: SkString?, creation: SkDocumentPDFDateTime?,
                modified: SkDocumentPDFDateTime?, rasterDPI: Float, pdfA: Bool, encodingQuality: Int32) {
        self.title = title
        self.author = author
        self.subject = subject
        self.keywords = keywords
        self.creator = creator
        self.producer = producer
        self.creation = creation
        self.modified = modified
        self.rasterDPI = rasterDPI
        self.pdfA = pdfA
        self.encodingQuality = encodingQuality
    }

    public init(_ metadata: sk_document_pdf_metadata_t) {
        self.title = metadata.fTitle.map { SkString(copy: $0) }
        self.author = metadata.fAuthor.map { SkString(copy: $0) }
        self.subject = metadata.fSubject.map { SkString(copy: $0) }
        self.keywords = metadata.fKeywords.map { SkString(copy: $0) }
        self.creator = metadata.fCreator.map { SkString(copy: $0) }
        self.producer = metadata.fProducer.map { SkString(copy: $0) }
        self.creation = metadata.fCreation.map { SkDocumentPDFDateTime($0.pointee) }
        self.modified = metadata.fModified.map { SkDocumentPDFDateTime($0.pointee) }
        self.rasterDPI = metadata.fRasterDPI
        self.pdfA = metadata.fPDFA
        self.encodingQuality = metadata.fEncodingQuality
    }

    public var skDocumentPDFMetadata: sk_document_pdf_metadata_t {
        var titlePtr: UnsafeMutablePointer<sk_string_t>? = nil
        if let t = title {
            titlePtr = UnsafeMutablePointer(mutating: t.skString)
        }
        var authorPtr: UnsafeMutablePointer<sk_string_t>? = nil
        if let a = author {
            authorPtr = UnsafeMutablePointer(mutating: a.skString)
        }
        var subjectPtr: UnsafeMutablePointer<sk_string_t>? = nil
        if let s = subject {
            subjectPtr = UnsafeMutablePointer(mutating: s.skString)
        }
        var keywordsPtr: UnsafeMutablePointer<sk_string_t>? = nil
        if let k = keywords {
            keywordsPtr = UnsafeMutablePointer(mutating: k.skString)
        }
        var creatorPtr: UnsafeMutablePointer<sk_string_t>? = nil
        if let c = creator {
            creatorPtr = UnsafeMutablePointer(mutating: c.skString)
        }
        var producerPtr: UnsafeMutablePointer<sk_string_t>? = nil
        if let p = producer {
            producerPtr = UnsafeMutablePointer(mutating: p.skString)
        }
        var creationPtr: UnsafeMutablePointer<sk_document_pdf_datetime_t>? = nil
        if var c = creation?.skDocumentPDFDateTime {
            creationPtr = UnsafeMutablePointer<sk_document_pdf_datetime_t>.allocate(capacity: 1)
            creationPtr?.initialize(to: c)
        }
        var modifiedPtr: UnsafeMutablePointer<sk_document_pdf_datetime_t>? = nil
        if var m = modified?.skDocumentPDFDateTime {
            modifiedPtr = UnsafeMutablePointer<sk_document_pdf_datetime_t>.allocate(capacity: 1)
            modifiedPtr?.initialize(to: m)
        }

        return sk_document_pdf_metadata_t(fTitle: titlePtr, fAuthor: authorPtr, fSubject: subjectPtr,
                                          fKeywords: keywordsPtr, fCreator: creatorPtr, fProducer: producerPtr,
                                          fCreation: creationPtr, fModified: modifiedPtr, fRasterDPI: rasterDPI,
                                          fPDFA: pdfA, fEncodingQuality: encodingQuality)
    }
}

public struct SkImageInfo {
    public var colorspace: OpaquePointer? // sk_colorspace_t*
    public var width: Int32
    public var height: Int32
    public var colorType: SkColorType
    public var alphaType: SkAlphaType

    public init(colorspace: OpaquePointer?, width: Int32, height: Int32, colorType: SkColorType, alphaType: SkAlphaType) {
        self.colorspace = colorspace
        self.width = width
        self.height = height
        self.colorType = colorType
        self.alphaType = alphaType
    }

    public init(_ info: sk_imageinfo_t) {
        self.colorspace = info.colorspace
        self.width = info.width
        self.height = info.height
        self.colorType = SkColorType(info.colorType)
        self.alphaType = SkAlphaType(info.alphaType)
    }

    public var skImageInfo: sk_imageinfo_t {
        return sk_imageinfo_t(colorspace: colorspace, width: width, height: height,
                              colorType: colorType.skColorType, alphaType: alphaType.skAlphaType)
    }
}

public enum SkCodecAnimationDisposalMethod: UInt32 {
    case keep = 1
    case restoreBgColor = 2
    case restorePrevious = 3

    public init(_ method: sk_codecanimation_disposalmethod_t) {
        self = SkCodecAnimationDisposalMethod(rawValue: method.rawValue) ?? .keep
    }

    public var skCodecAnimationDisposalMethod: sk_codecanimation_disposalmethod_t {
        return sk_codecanimation_disposalmethod_t(rawValue: rawValue)
    }
}

public enum SkCodecAnimationBlend: UInt32 {
    case srcOver = 0
    case src = 1

    public init(_ blend: sk_codecanimation_blend_t) {
        self = SkCodecAnimationBlend(rawValue: blend.rawValue) ?? .srcOver
    }

    public var skCodecAnimationBlend: sk_codecanimation_blend_t {
        return sk_codecanimation_blend_t(rawValue: rawValue)
    }
}

public struct SkCodecFrameInfo {
    public var requiredFrame: Int32
    public var duration: Int32
    public var fullyReceived: Bool
    public var alphaType: SkAlphaType
    public var hasAlphaWithinBounds: Bool
    public var disposalMethod: SkCodecAnimationDisposalMethod
    public var blend: SkCodecAnimationBlend
    public var frameRect: SkIRect

    public init(requiredFrame: Int32, duration: Int32, fullyReceived: Bool, alphaType: SkAlphaType,
                hasAlphaWithinBounds: Bool, disposalMethod: SkCodecAnimationDisposalMethod,
                blend: SkCodecAnimationBlend, frameRect: SkIRect) {
        self.requiredFrame = requiredFrame
        self.duration = duration
        self.fullyReceived = fullyReceived
        self.alphaType = alphaType
        self.hasAlphaWithinBounds = hasAlphaWithinBounds
        self.disposalMethod = disposalMethod
        self.blend = blend
        self.frameRect = frameRect
    }

    public init(_ info: sk_codec_frameinfo_t) {
        self.requiredFrame = info.fRequiredFrame
        self.duration = info.fDuration
        self.fullyReceived = info.fFullyReceived
        self.alphaType = SkAlphaType(info.fAlphaType)
        self.hasAlphaWithinBounds = info.fHasAlphaWithinBounds
        self.disposalMethod = SkCodecAnimationDisposalMethod(info.fDisposalMethod)
        self.blend = SkCodecAnimationBlend(info.fBlend)
        self.frameRect = SkIRect(info.fFrameRect)
    }

    public var skCodecFrameInfo: sk_codec_frameinfo_t {
        return sk_codec_frameinfo_t(fRequiredFrame: requiredFrame, fDuration: duration, fFullyReceived: fullyReceived,
                                    fAlphaType: alphaType.skAlphaType, fHasAlphaWithinBounds: hasAlphaWithinBounds,
                                    fDisposalMethod: disposalMethod.skCodecAnimationDisposalMethod,
                                    fBlend: blend.skCodecAnimationBlend, fFrameRect: frameRect.skIRect)
    }
}

public enum SkVerticesVertexMode: UInt32 {
    case triangles = 0
    case triangleStrip
    case triangleFan

    public init(_ mode: sk_vertices_vertex_mode_t) {
        self = SkVerticesVertexMode(rawValue: mode.rawValue) ?? .triangles
    }

    public var skVerticesVertexMode: sk_vertices_vertex_mode_t {
        return sk_vertices_vertex_mode_t(rawValue: rawValue)
    }
}

public struct SkColorSpaceTransferFn {
    public var g: Float
    public var a: Float
    public var b: Float
    public var c: Float
    public var d: Float
    public var e: Float
    public var f: Float

    public init(g: Float, a: Float, b: Float, c: Float, d: Float, e: Float, f: Float) {
        self.g = g
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.e = e
        self.f = f
    }

    public init(_ fn: sk_colorspace_transfer_fn_t) {
        self.g = fn.fG
        self.a = fn.fA
        self.b = fn.fB
        self.c = fn.fC
        self.d = fn.fD
        self.e = fn.fE
        self.f = fn.fF
    }

    public var skColorSpaceTransferFn: sk_colorspace_transfer_fn_t {
        return sk_colorspace_transfer_fn_t(fG: g, fA: a, fB: b, fC: c, fD: d, fE: e, fF: f)
    }
}

public struct SkColorSpacePrimaries {
    public var rX: Float
    public var rY: Float
    public var gX: Float
    public var gY: Float
    public var bX: Float
    public var bY: Float
    public var wX: Float
    public var wY: Float

    public init(rX: Float, rY: Float, gX: Float, gY: Float, bX: Float, bY: Float, wX: Float, wY: Float) {
        self.rX = rX
        self.rY = rY
        self.gX = gX
        self.gY = gY
        self.bX = bX
        self.bY = bY
        self.wX = wX
        self.wY = wY
    }

    public init(_ primaries: sk_colorspace_primaries_t) {
        self.rX = primaries.fRX
        self.rY = primaries.fRY
        self.gX = primaries.fGX
        self.gY = primaries.fGY
        self.bX = primaries.fBX
        self.bY = primaries.fBY
        self.wX = primaries.fWX
        self.wY = primaries.fWY
    }

    public var skColorSpacePrimaries: sk_colorspace_primaries_t {
        return sk_colorspace_primaries_t(fRX: rX, fRY: rY, fGX: gX, fGY: gY, fBX: bX, fBY: bY, fWX: wX, fWY: wY)
    }
}

public struct SkColorSpaceXYZ {
    public var m00, m01, m02: Float
    public var m10, m11, m12: Float
    public var m20, m21, m22: Float

    public init(m00: Float, m01: Float, m02: Float,
                m10: Float, m11: Float, m12: Float,
                m20: Float, m21: Float, m22: Float) {
        self.m00 = m00; self.m01 = m01; self.m02 = m02
        self.m10 = m10; self.m11 = m11; self.m12 = m12
        self.m20 = m20; self.m21 = m21; self.m22 = m22
    }

    public init(_ xyz: sk_colorspace_xyz_t) {
        self.m00 = xyz.fM00; self.m01 = xyz.fM01; self.m02 = xyz.fM02
        self.m10 = xyz.fM10; self.m11 = xyz.fM11; self.m12 = xyz.fM12
        self.m20 = xyz.fM20; self.m21 = xyz.fM21; self.m22 = xyz.fM22
    }

    public var skColorSpaceXYZ: sk_colorspace_xyz_t {
        return sk_colorspace_xyz_t(fM00: m00, fM01: m01, fM02: m02,
                                   fM10: m10, fM11: m11, fM12: m12,
                                   fM20: m20, fM21: m21, fM22: m22)
    }
}

public enum SkHighContrastConfigInvertStyle: UInt32 {
    case noInvert = 0
    case invertBrightness
    case invertLightness

    public init(_ style: sk_highcontrastconfig_invertstyle_t) {
        self = SkHighContrastConfigInvertStyle(rawValue: style.rawValue) ?? .noInvert
    }

    public var skHighContrastConfigInvertStyle: sk_highcontrastconfig_invertstyle_t {
        return sk_highcontrastconfig_invertstyle_t(rawValue: rawValue)
    }
}

public struct SkHighContrastConfig {
    public var grayscale: Bool
    public var invertStyle: SkHighContrastConfigInvertStyle
    public var contrast: Float

    public init(grayscale: Bool, invertStyle: SkHighContrastConfigInvertStyle, contrast: Float) {
        self.grayscale = grayscale
        self.invertStyle = invertStyle
        self.contrast = contrast
    }

    public init(_ config: sk_highcontrastconfig_t) {
        self.grayscale = config.fGrayscale
        self.invertStyle = SkHighContrastConfigInvertStyle(config.fInvertStyle)
        self.contrast = config.fContrast
    }

    public var skHighContrastConfig: sk_highcontrastconfig_t {
        return sk_highcontrastconfig_t(fGrayscale: grayscale, fInvertStyle: invertStyle.skHighContrastConfigInvertStyle, fContrast: contrast)
    }
}

public struct SkPNGEncoderFilterFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let zero = SkPNGEncoderFilterFlags(rawValue: ZERO_SK_PNGENCODER_FILTER_FLAGS.rawValue)
    public static let none = SkPNGEncoderFilterFlags(rawValue: NONE_SK_PNGENCODER_FILTER_FLAGS.rawValue)
    public static let sub = SkPNGEncoderFilterFlags(rawValue: SUB_SK_PNGENCODER_FILTER_FLAGS.rawValue)
    public static let up = SkPNGEncoderFilterFlags(rawValue: UP_SK_PNGENCODER_FILTER_FLAGS.rawValue)
    public static let avg = SkPNGEncoderFilterFlags(rawValue: AVG_SK_PNGENCODER_FILTER_FLAGS.rawValue)
    public static let paeth = SkPNGEncoderFilterFlags(rawValue: PAETH_SK_PNGENCODER_FILTER_FLAGS.rawValue)
    public static let all = SkPNGEncoderFilterFlags(rawValue: ALL_SK_PNGENCODER_FILTER_FLAGS.rawValue)

    public init(_ flags: sk_pngencoder_filterflags_t) {
        self.rawValue = flags.rawValue
    }

    public var skPNGEncoderFilterFlags: sk_pngencoder_filterflags_t {
        return sk_pngencoder_filterflags_t(rawValue: rawValue)
    }
}

public struct SkPNGEncoderOptions {
    public var filterFlags: SkPNGEncoderFilterFlags
    public var zLibLevel: Int32
    public var comments: UnsafeMutableRawPointer?
    public var iccProfile: OpaquePointer? // const sk_colorspace_icc_profile_t*
    public var iccProfileDescription: String?

    public init(filterFlags: SkPNGEncoderFilterFlags, zLibLevel: Int32, comments: UnsafeMutableRawPointer?,
                iccProfile: OpaquePointer?, iccProfileDescription: String?) {
        self.filterFlags = filterFlags
        self.zLibLevel = zLibLevel
        self.comments = comments
        self.iccProfile = iccProfile
        self.iccProfileDescription = iccProfileDescription
    }

    public init(_ options: sk_pngencoder_options_t) {
        self.filterFlags = SkPNGEncoderFilterFlags(options.fFilterFlags)
        self.zLibLevel = options.fZLibLevel
        self.comments = options.fComments
        self.iccProfile = options.fICCProfile
        self.iccProfileDescription = options.fICCProfileDescription.map { String(cString: $0) }
    }

    public var skPNGEncoderOptions: sk_pngencoder_options_t {
        return sk_pngencoder_options_t(fFilterFlags: filterFlags.skPNGEncoderFilterFlags, fZLibLevel: zLibLevel,
                                       fComments: comments, fICCProfile: iccProfile,
                                       fICCProfileDescription: iccProfileDescription?.cString(using: .utf8))
    }
}

public enum SkJPEGEncoderDownsample: UInt32 {
    case downsample420 = 0
    case downsample422
    case downsample444

    public init(_ downsample: sk_jpegencoder_downsample_t) {
        self = SkJPEGEncoderDownsample(rawValue: downsample.rawValue) ?? .downsample420
    }

    public var skJPEGEncoderDownsample: sk_jpegencoder_downsample_t {
        return sk_jpegencoder_downsample_t(rawValue: rawValue)
    }
}

public enum SkJPEGEncoderAlphaOption: UInt32 {
    case ignore = 0
    case blendOnBlack

    public init(_ option: sk_jpegencoder_alphaoption_t) {
        self = SkJPEGEncoderAlphaOption(rawValue: option.rawValue) ?? .ignore
    }

    public var skJPEGEncoderAlphaOption: sk_jpegencoder_alphaoption_t {
        return sk_jpegencoder_alphaoption_t(rawValue: rawValue)
    }
}

public struct SkJPEGEncoderOptions {
    public var quality: Int32
    public var downsample: SkJPEGEncoderDownsample
    public var alphaOption: SkJPEGEncoderAlphaOption
    public var xmpMetadata: OpaquePointer? // const sk_data_t*
    public var iccProfile: OpaquePointer? // const sk_colorspace_icc_profile_t*
    public var iccProfileDescription: String?

    public init(quality: Int32, downsample: SkJPEGEncoderDownsample, alphaOption: SkJPEGEncoderAlphaOption,
                xmpMetadata: OpaquePointer?, iccProfile: OpaquePointer?, iccProfileDescription: String?) {
        self.quality = quality
        self.downsample = downsample
        self.alphaOption = alphaOption
        self.xmpMetadata = xmpMetadata
        self.iccProfile = iccProfile
        self.iccProfileDescription = iccProfileDescription
    }

    public init(_ options: sk_jpegencoder_options_t) {
        self.quality = options.fQuality
        self.downsample = SkJPEGEncoderDownsample(options.fDownsample)
        self.alphaOption = SkJPEGEncoderAlphaOption(options.fAlphaOption)
        self.xmpMetadata = options.xmpMetadata
        self.iccProfile = options.fICCProfile
        self.iccProfileDescription = options.fICCProfileDescription.map { String(cString: $0) }
    }

    public var skJPEGEncoderOptions: sk_jpegencoder_options_t {
        return sk_jpegencoder_options_t(fQuality: quality, fDownsample: downsample.skJPEGEncoderDownsample,
                                        fAlphaOption: alphaOption.skJPEGEncoderAlphaOption, xmpMetadata: xmpMetadata,
                                        fICCProfile: iccProfile, fICCProfileDescription: iccProfileDescription?.cString(using: .utf8))
    }
}

public enum SkWebpEncoderCompression: UInt32 {
    case lossy = 0
    case lossless

    public init(_ compression: sk_webpencoder_compression_t) {
        self = SkWebpEncoderCompression(rawValue: compression.rawValue) ?? .lossy
    }

    public var skWebpEncoderCompression: sk_webpencoder_compression_t {
        return sk_webpencoder_compression_t(rawValue: rawValue)
    }
}

public struct SkWebpEncoderOptions {
    public var compression: SkWebpEncoderCompression
    public var quality: Float
    public var iccProfile: OpaquePointer? // const sk_colorspace_icc_profile_t*
    public var iccProfileDescription: String?

    public init(compression: SkWebpEncoderCompression, quality: Float, iccProfile: OpaquePointer?, iccProfileDescription: String?) {
        self.compression = compression
        self.quality = quality
        self.iccProfile = iccProfile
        self.iccProfileDescription = iccProfileDescription
    }

    public init(_ options: sk_webpencoder_options_t) {
        self.compression = SkWebpEncoderCompression(options.fCompression)
        self.quality = options.fQuality
        self.iccProfile = options.fICCProfile
        self.iccProfileDescription = options.fICCProfileDescription.map { String(cString: $0) }
    }

    public var skWebpEncoderOptions: sk_webpencoder_options_t {
        return sk_webpencoder_options_t(fCompression: compression.skWebpEncoderCompression, fQuality: quality,
                                        fICCProfile: iccProfile, fICCProfileDescription: iccProfileDescription?.cString(using: .utf8))
    }
}

public enum SkRRectType: UInt32 {
    case empty = 0
    case rect
    case oval
    case simple
    case ninePatch
    case complex

    public init(_ type: sk_rrect_type_t) {
        self = SkRRectType(rawValue: type.rawValue) ?? .empty
    }

    public var skRRectType: sk_rrect_type_t {
        return sk_rrect_type_t(rawValue: rawValue)
    }
}

public enum SkRRectCorner: UInt32 {
    case upperLeft = 0
    case upperRight
    case lowerRight
    case lowerLeft

    public init(_ corner: sk_rrect_corner_t) {
        self = SkRRectCorner(rawValue: corner.rawValue) ?? .upperLeft
    }

    public var skRRectCorner: sk_rrect_corner_t {
        return sk_rrect_corner_t(rawValue: rawValue)
    }
}

public enum SkRuntimeEffectUniformType: UInt32 {
    case float = 0
    case float2
    case float3
    case float4
    case float2x2
    case float3x3
    case float4x4
    case int
    case int2
    case int3
    case int4

    public init(_ type: sk_runtimeeffect_uniform_type_t) {
        self = SkRuntimeEffectUniformType(rawValue: type.rawValue) ?? .float
    }

    public var skRuntimeEffectUniformType: sk_runtimeeffect_uniform_type_t {
        return sk_runtimeeffect_uniform_type_t(rawValue: rawValue)
    }
}

public enum SkRuntimeEffectChildType: UInt32 {
    case shader = 0
    case colorFilter
    case blender

    public init(_ type: sk_runtimeeffect_child_type_t) {
        self = SkRuntimeEffectChildType(rawValue: type.rawValue) ?? .shader
    }

    public var skRuntimeEffectChildType: sk_runtimeeffect_child_type_t {
        return sk_runtimeeffect_child_type_t(rawValue: rawValue)
    }
}

public struct SkRuntimeEffectUniformFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let none = SkRuntimeEffectUniformFlags(rawValue: NONE_SK_RUNTIMEEFFECT_UNIFORM_FLAGS.rawValue)
    public static let array = SkRuntimeEffectUniformFlags(rawValue: ARRAY_SK_RUNTIMEEFFECT_UNIFORM_FLAGS.rawValue)
    public static let color = SkRuntimeEffectUniformFlags(rawValue: COLOR_SK_RUNTIMEEFFECT_UNIFORM_FLAGS.rawValue)
    public static let vertex = SkRuntimeEffectUniformFlags(rawValue: VERTEX_SK_RUNTIMEEFFECT_UNIFORM_FLAGS.rawValue)
    public static let fragment = SkRuntimeEffectUniformFlags(rawValue: FRAGMENT_SK_RUNTIMEEFFECT_UNIFORM_FLAGS.rawValue)
    public static let halfPrecision = SkRuntimeEffectUniformFlags(rawValue: HALF_PRECISION_SK_RUNTIMEEFFECT_UNIFORM_FLAGS.rawValue)

    public init(_ flags: sk_runtimeeffect_uniform_flags_t) {
        self.rawValue = flags.rawValue
    }

    public var skRuntimeEffectUniformFlags: sk_runtimeeffect_uniform_flags_t {
        return sk_runtimeeffect_uniform_flags_t(rawValue: rawValue)
    }
}

public struct SkRuntimeEffectUniform {
    public var name: String
    public var offset: Int
    public var type: SkRuntimeEffectUniformType
    public var count: Int32
    public var flags: SkRuntimeEffectUniformFlags

    public init(name: String, offset: Int, type: SkRuntimeEffectUniformType, count: Int32, flags: SkRuntimeEffectUniformFlags) {
        self.name = name
        self.offset = offset
        self.type = type
        self.count = count
        self.flags = flags
    }

    public init(_ uniform: sk_runtimeeffect_uniform_t) {
        self.name = String(cString: uniform.fName)
        self.offset = uniform.fOffset
        self.type = SkRuntimeEffectUniformType(uniform.fType)
        self.count = uniform.fCount
        self.flags = SkRuntimeEffectUniformFlags(uniform.fFlags)
    }

    public var skRuntimeEffectUniform: sk_runtimeeffect_uniform_t {
        return sk_runtimeeffect_uniform_t(fName: name.cString(using: .utf8), fNameLength: name.lengthOfBytes(using: .utf8),
                                          fOffset: offset, fType: type.skRuntimeEffectUniformType, fCount: count,
                                          fFlags: flags.skRuntimeEffectUniformFlags)
    }
}

public struct SkRuntimeEffectChild {
    public var name: String
    public var type: SkRuntimeEffectChildType
    public var index: Int32

    public init(name: String, type: SkRuntimeEffectChildType, index: Int32) {
        self.name = name
        self.type = type
        self.index = index
    }

    public init(_ child: sk_runtimeeffect_child_t) {
        self.name = String(cString: child.fName)
        self.type = SkRuntimeEffectChildType(child.fType)
        self.index = child.fIndex
    }

    public var skRuntimeEffectChild: sk_runtimeeffect_child_t {
        return sk_runtimeeffect_child_t(fName: name.cString(using: .utf8), fNameLength: name.lengthOfBytes(using: .utf8),
                                        fType: type.skRuntimeEffectChildType, fIndex: index)
    }
}

public enum SkFilterMode: UInt32 {
    case nearest = 0
    case linear

    public init(_ mode: sk_filter_mode_t) {
        self = SkFilterMode(rawValue: mode.rawValue) ?? .nearest
    }

    public var skFilterMode: sk_filter_mode_t {
        return sk_filter_mode_t(rawValue: rawValue)
    }
}

public enum SkMipmapMode: UInt32 {
    case none = 0
    case nearest
    case linear

    public init(_ mode: sk_mipmap_mode_t) {
        self = SkMipmapMode(rawValue: mode.rawValue) ?? .none
    }

    public var skMipmapMode: sk_mipmap_mode_t {
        return sk_mipmap_mode_t(rawValue: rawValue)
    }
}

public struct SkCubicResampler {
    public var b: Float
    public var c: Float

    public init(b: Float, c: Float) {
        self.b = b
        self.c = c
    }

    public init(_ resampler: sk_cubic_resampler_t) {
        self.b = resampler.fB
        self.c = resampler.fC
    }

    public var skCubicResampler: sk_cubic_resampler_t {
        return sk_cubic_resampler_t(fB: b, fC: c)
    }
}

public struct SkSamplingOptions {
    public var maxAniso: Int32
    public var useCubic: Bool
    public var cubic: SkCubicResampler
    public var filter: SkFilterMode
    public var mipmap: SkMipmapMode

    public init(maxAniso: Int32, useCubic: Bool, cubic: SkCubicResampler, filter: SkFilterMode, mipmap: SkMipmapMode) {
        self.maxAniso = maxAniso
        self.useCubic = useCubic
        self.cubic = cubic
        self.filter = filter
        self.mipmap = mipmap
    }

    public init(_ options: sk_sampling_options_t) {
        self.maxAniso = options.fMaxAniso
        self.useCubic = options.fUseCubic
        self.cubic = SkCubicResampler(options.fCubic)
        self.filter = SkFilterMode(options.fFilter)
        self.mipmap = SkMipmapMode(options.fMipmap)
    }

    public var skSamplingOptions: sk_sampling_options_t {
        return sk_sampling_options_t(fMaxAniso: maxAniso, fUseCubic: useCubic, fCubic: cubic.skCubicResampler,
                                     fFilter: filter.skFilterMode, fMipmap: mipmap.skMipmapMode)
    }
}

public struct SkCanvasSaveLayerRecFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let none = SkCanvasSaveLayerRecFlags(rawValue: NONE_SK_CANVAS_SAVELAYERREC_FLAGS.rawValue)
    public static let preserveLcdText = SkCanvasSaveLayerRecFlags(rawValue: PRESERVE_LCD_TEXT_SK_CANVAS_SAVELAYERREC_FLAGS.rawValue)
    public static let initializeWithPrevious = SkCanvasSaveLayerRecFlags(rawValue: INITIALIZE_WITH_PREVIOUS_SK_CANVAS_SAVELAYERREC_FLAGS.rawValue)
    public static let f16ColorType = SkCanvasSaveLayerRecFlags(rawValue: F16_COLOR_TYPE_SK_CANVAS_SAVELAYERREC_FLAGS.rawValue)

    public init(_ flags: sk_canvas_savelayerrec_flags_t) {
        self.rawValue = flags.rawValue
    }

    public var skCanvasSaveLayerRecFlags: sk_canvas_savelayerrec_flags_t {
        return sk_canvas_savelayerrec_flags_t(rawValue: rawValue)
    }
}

public struct SkCanvasSaveLayerRec {
    public var bounds: SkRect?
    public var paint: OpaquePointer? // sk_paint_t*
    public var backdrop: OpaquePointer? // sk_imagefilter_t*
    public var flags: SkCanvasSaveLayerRecFlags

    public init(bounds: SkRect?, paint: OpaquePointer?, backdrop: OpaquePointer?, flags: SkCanvasSaveLayerRecFlags) {
        self.bounds = bounds
        self.paint = paint
        self.backdrop = backdrop
        self.flags = flags
    }

    public init(_ rec: sk_canvas_savelayerrec_t) {
        self.bounds = rec.fBounds.map { SkRect($0.pointee) }
        self.paint = rec.fPaint
        self.backdrop = rec.fBackdrop
        self.flags = SkCanvasSaveLayerRecFlags(rec.fFlags)
    }

    public var skCanvasSaveLayerRec: sk_canvas_savelayerrec_t {
        var boundsPtr: UnsafeMutablePointer<sk_rect_t>? = nil
        if var b = bounds?.skRect {
            boundsPtr = UnsafeMutablePointer<sk_rect_t>.allocate(capacity: 1)
            boundsPtr?.initialize(to: b)
        }
        return sk_canvas_savelayerrec_t(fBounds: boundsPtr, fPaint: paint, fBackdrop: backdrop, fFlags: flags.skCanvasSaveLayerRecFlags)
    }
}

public enum SkottieAnimationRenderFlags: UInt32 {
    case skipTopLevelIsolation = 0x01
    case disableTopLevelClipping = 0x02

    public init(_ flags: skottie_animation_renderflags_t) {
        self = SkottieAnimationRenderFlags(rawValue: flags.rawValue) ?? .skipTopLevelIsolation
    }

    public var skottieAnimationRenderFlags: skottie_animation_renderflags_t {
        return skottie_animation_renderflags_t(rawValue: rawValue)
    }
}

public struct SkottieAnimationBuilderFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let none = SkottieAnimationBuilderFlags(rawValue: NONE_SKOTTIE_ANIMATION_BUILDER_FLAGS.rawValue)
    public static let deferImageLoading = SkottieAnimationBuilderFlags(rawValue: DEFER_IMAGE_LOADING_SKOTTIE_ANIMATION_BUILDER_FLAGS.rawValue)
    public static let preferEmbeddedFonts = SkottieAnimationBuilderFlags(rawValue: PREFER_EMBEDDED_FONTS_SKOTTIE_ANIMATION_BUILDER_FLAGS.rawValue)

    public init(_ flags: skottie_animation_builder_flags_t) {
        self.rawValue = flags.rawValue
    }

    public var skottieAnimationBuilderFlags: skottie_animation_builder_flags_t {
        return skottie_animation_builder_flags_t(rawValue: rawValue)
    }
}

public struct SkottieAnimationBuilderStats {
    public var totalLoadTimeMS: Float
    public var jsonParseTimeMS: Float
    public var sceneParseTimeMS: Float
    public var jsonSize: Int
    public var animatorCount: Int

    public init(totalLoadTimeMS: Float, jsonParseTimeMS: Float, sceneParseTimeMS: Float, jsonSize: Int, animatorCount: Int) {
        self.totalLoadTimeMS = totalLoadTimeMS
        self.jsonParseTimeMS = jsonParseTimeMS
        self.sceneParseTimeMS = sceneParseTimeMS
        self.jsonSize = jsonSize
        self.animatorCount = animatorCount
    }

    public init(_ stats: skottie_animation_builder_stats_t) {
        self.totalLoadTimeMS = stats.fTotalLoadTimeMS
        self.jsonParseTimeMS = stats.fJsonParseTimeMS
        self.sceneParseTimeMS = stats.fSceneParseTimeMS
        self.jsonSize = stats.fJsonSize
        self.animatorCount = stats.fAnimatorCount
    }

    public var skottieAnimationBuilderStats: skottie_animation_builder_stats_t {
        return skottie_animation_builder_stats_t(fTotalLoadTimeMS: totalLoadTimeMS, fJsonParseTimeMS: jsonParseTimeMS,
                                                  fSceneParseTimeMS: sceneParseTimeMS, fJsonSize: jsonSize,
                                                  fAnimatorCount: animatorCount)
    }
}

public struct GrD3DBackendContext {
    public var adapter: OpaquePointer? // d3d_dxgi_adapter_t*
    public var device: OpaquePointer? // d3d_d12_device_t*
    public var queue: OpaquePointer? // d3d_d12_command_queue_t*
    public var memoryAllocator: OpaquePointer? // gr_d3d_memory_allocator_t*
    public var protectedContext: Bool

    public init(adapter: OpaquePointer?, device: OpaquePointer?, queue: OpaquePointer?,
                memoryAllocator: OpaquePointer?, protectedContext: Bool) {
        self.adapter = adapter
        self.device = device
        self.queue = queue
        self.memoryAllocator = memoryAllocator
        self.protectedContext = protectedContext
    }

    public init(_ context: gr_d3d_backendcontext_t) {
        self.adapter = context.fAdapter
        self.device = context.fDevice
        self.queue = context.fQueue
        self.memoryAllocator = context.fMemoryAllocator
        self.protectedContext = context.fProtectedContext
    }

    public var grD3DBackendContext: gr_d3d_backendcontext_t {
        return gr_d3d_backendcontext_t(fAdapter: adapter, fDevice: device, fQueue: queue,
                                       fMemoryAllocator: memoryAllocator, fProtectedContext: protectedContext)
    }
}

public struct GrD3DTextureResourceInfo {
    public var resource: OpaquePointer? // d3d_d12_resource_t*
    public var alloc: OpaquePointer? // d3d_alloc_t*
    public var resourceState: UInt32
    public var format: UInt32
    public var sampleCount: UInt32
    public var levelCount: UInt32
    public var sampleQualityPattern: UInt32
    public var `protected`: Bool

    public init(resource: OpaquePointer?, alloc: OpaquePointer?, resourceState: UInt32, format: UInt32,
                sampleCount: UInt32, levelCount: UInt32, sampleQualityPattern: UInt32, `protected`: Bool) {
        self.resource = resource
        self.alloc = alloc
        self.resourceState = resourceState
        self.format = format
        self.sampleCount = sampleCount
        self.levelCount = levelCount
        self.sampleQualityPattern = sampleQualityPattern
        self.`protected` = `protected`
    }

    public init(_ info: gr_d3d_textureresourceinfo_t) {
        self.resource = info.fResource
        self.alloc = info.fAlloc
        self.resourceState = info.fResourceState
        self.format = info.fFormat
        self.sampleCount = info.fSampleCount
        self.levelCount = info.fLevelCount
        self.sampleQualityPattern = info.fSampleQualityPattern
        self.`protected` = info.fProtected
    }

    public var grD3DTextureResourceInfo: gr_d3d_textureresourceinfo_t {
        return gr_d3d_textureresourceinfo_t(fResource: resource, fAlloc: alloc, fResourceState: resourceState,
                                           fFormat: format, fSampleCount: sampleCount, fLevelCount: levelCount,
                                           fSampleQualityPattern: sampleQualityPattern, fProtected: `protected`)
    }
}