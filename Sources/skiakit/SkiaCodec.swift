import Foundation
import CSkia

public class SkCodec {
    public var handle: OpaquePointer?

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_codec_destroy(handle)
    }

    public static var minBufferedBytesNeeded: Int {
        return Int(sk_codec_min_buffered_bytes_needed())
    }

    public convenience init?(stream: SkStream, result: inout SkCodecResult) {
        var skResult = result.skCodecResult
        guard let handle = sk_codec_new_from_stream(stream.handle, &skResult) else { return nil }
        result = SkCodecResult(skResult)
        self.init(handle: handle)
    }

    public convenience init?(data: SkData) {
        guard let handle = sk_codec_new_from_data(data.handle) else { return nil }
        self.init(handle: handle)
    }

    public var info: SkImageInfo {
        var skInfo = sk_imageinfo_t()
        sk_codec_get_info(handle, &skInfo)
        return SkImageInfo(skInfo)
    }

    public var origin: SkEncodedOrigin {
        return SkEncodedOrigin(sk_codec_get_origin(handle))
    }

    public func getScaledDimensions(desiredScale: Float) -> SkISize {
        var dimensions = sk_isize_t()
        sk_codec_get_scaled_dimensions(handle, desiredScale, &dimensions)
        return SkISize(dimensions)
    }

    public func getValidSubset(desiredSubset: inout SkIRect) -> Bool {
        var skDesiredSubset = desiredSubset.skIRect
        let result = sk_codec_get_valid_subset(handle, &skDesiredSubset)
        desiredSubset = SkIRect(skDesiredSubset)
        return result
    }

    public var encodedFormat: SkEncodedImageFormat {
        return SkEncodedImageFormat(sk_codec_get_encoded_format(handle))
    }

    public func getPixels(info: SkImageInfo, pixels: UnsafeMutableRawPointer, rowBytes: Int, options: SkCodecOptions?) -> SkCodecResult {
        var skInfo = info.skImageInfo
        var skOptions: sk_codec_options_t? = options?.skCodecOptions
        return SkCodecResult(sk_codec_get_pixels(handle, &skInfo, pixels, rowBytes, &skOptions))
    }

    public func startIncrementalDecode(info: SkImageInfo, pixels: UnsafeMutableRawPointer, rowBytes: Int, options: SkCodecOptions?) -> SkCodecResult {
        var skInfo = info.skImageInfo
        var skOptions: sk_codec_options_t? = options?.skCodecOptions
        return SkCodecResult(sk_codec_start_incremental_decode(handle, &skInfo, pixels, rowBytes, &skOptions))
    }

    public func incrementalDecode(rowsDecoded: inout Int) -> SkCodecResult {
        var skRowsDecoded: Int32 = Int32(rowsDecoded)
        let result = SkCodecResult(sk_codec_incremental_decode(handle, &skRowsDecoded))
        rowsDecoded = Int(skRowsDecoded)
        return result
    }

    public func startScanlineDecode(info: SkImageInfo, options: SkCodecOptions?) -> SkCodecResult {
        var skInfo = info.skImageInfo
        var skOptions: sk_codec_options_t? = options?.skCodecOptions
        return SkCodecResult(sk_codec_start_scanline_decode(handle, &skInfo, &skOptions))
    }

    public func getScanlines(dst: UnsafeMutableRawPointer, countLines: Int, rowBytes: Int) -> Int {
        return Int(sk_codec_get_scanlines(handle, dst, Int32(countLines), rowBytes))
    }

    public func skipScanlines(countLines: Int) -> Bool {
        return sk_codec_skip_scanlines(handle, Int32(countLines))
    }

    public var scanlineOrder: SkCodecScanlineOrder {
        return SkCodecScanlineOrder(sk_codec_get_scanline_order(handle))
    }

    public func nextScanline() -> Int {
        return Int(sk_codec_next_scanline(handle))
    }

    public func outputScanline(inputScanline: Int) -> Int {
        return Int(sk_codec_output_scanline(handle, Int32(inputScanline)))
    }

    public var frameCount: Int {
        return Int(sk_codec_get_frame_count(handle))
    }

    public func getFrameInfo() -> SkCodecFrameInfo {
        var frameInfo = sk_codec_frameinfo_t()
        sk_codec_get_frame_info(handle, &frameInfo)
        return SkCodecFrameInfo(frameInfo)
    }

    public func getFrameInfo(for index: Int) -> SkCodecFrameInfo? {
        var frameInfo = sk_codec_frameinfo_t()
        if sk_codec_get_frame_info_for_index(handle, Int32(index), &frameInfo) {
            return SkCodecFrameInfo(frameInfo)
        }
        return nil
    }

    public var repetitionCount: Int {
        return Int(sk_codec_get_repetition_count(handle))
    }
}

public enum SkCodecResult: UInt32 {
    case success = 0
    case invalidInput = 1
    case inconclusiveInput = 2
    case unimplemented = 3
    case errorInInput = 4
    case internalError = 5
    case cancelled = 6

    public init(_ result: sk_codec_result_t) {
        self = SkCodecResult(rawValue: result.rawValue)!
    }

    public var skCodecResult: sk_codec_result_t {
        return sk_codec_result_t(rawValue: self.rawValue)
    }
}

public enum SkEncodedOrigin: UInt32 {
    case topLeft = 1
    case topRight = 2
    case bottomRight = 3
    case bottomLeft = 4
    case topLeft90 = 5
    case topRight90 = 6
    case bottomRight90 = 7
    case bottomLeft90 = 8
    case defaultOrigin = 1
    case count = 8

    public init(_ origin: sk_encodedorigin_t) {
        self = SkEncodedOrigin(rawValue: origin.rawValue)!
    }

    public var skEncodedOrigin: sk_encodedorigin_t {
        return sk_encodedorigin_t(rawValue: self.rawValue)
    }
}

public enum SkEncodedImageFormat: UInt32 {
    case bmp = 0
    case gif = 1
    case ico = 2
    case jpeg = 3
    case png = 4
    case wbmp = 5
    case webp = 6
    case pkm = 7
    case ktx = 8
    case astc = 9
    case dng = 10
    case heif = 11
    case avif = 12
    case jxl = 13
    case wmf = 14
    case unknown = 15

    public init(_ format: sk_encoded_image_format_t) {
        self = SkEncodedImageFormat(rawValue: format.rawValue)!
    }

    public var skEncodedImageFormat: sk_encoded_image_format_t {
        return sk_encoded_image_format_t(rawValue: self.rawValue)
    }
}

public struct SkCodecOptions {
    public var zeroInitialized: SkCodecZeroInitialized
    public var subset: SkIRect?
    public var frameIndex: Int
    public var priorFrame: Int
    public var discardFrame: Bool

    public init(zeroInitialized: SkCodecZeroInitialized = .no, subset: SkIRect? = nil, frameIndex: Int = 0, priorFrame: Int = -1, discardFrame: Bool = false) {
        self.zeroInitialized = zeroInitialized
        self.subset = subset
        self.frameIndex = frameIndex
        self.priorFrame = priorFrame
        self.discardFrame = discardFrame
    }

    public var skCodecOptions: sk_codec_options_t {
        var options = sk_codec_options_t()
        options.fZeroInitialized = zeroInitialized.skCodecZeroInitialized
        options.fSubset = subset?.skIRect
        options.fFrameIndex = Int32(frameIndex)
        options.fPriorFrame = Int32(priorFrame)
        options.fDiscardFrame = discardFrame
        return options
    }
}

public enum SkCodecZeroInitialized: UInt32 {
    case no = 0
    case yes = 1

    public init(_ zeroInitialized: sk_codec_zero_initialized_t) {
        self = SkCodecZeroInitialized(rawValue: zeroInitialized.rawValue)!
    }

    public var skCodecZeroInitialized: sk_codec_zero_initialized_t {
        return sk_codec_zero_initialized_t(rawValue: self.rawValue)
    }
}

public enum SkCodecScanlineOrder: UInt32 {
    case topDown = 0
    case bottomUp = 1

    public init(_ order: sk_codec_scanline_order_t) {
        self = SkCodecScanlineOrder(rawValue: order.rawValue)!
    }

    public var skCodecScanlineOrder: sk_codec_scanline_order_t {
        return sk_codec_scanline_order_t(rawValue: self.rawValue)
    }
}

public struct SkCodecFrameInfo {
    public var requiredFrame: Int
    public var duration: Int
    public var alphaType: SkAlphaType
    public var blend: SkCodecFrameBlend
    public var has  : Bool
    public var fullyOpaque: Bool

    public init(_ frameInfo: sk_codec_frameinfo_t) {
        self.requiredFrame = Int(frameInfo.fRequiredFrame)
        self.duration = Int(frameInfo.fDuration)
        self.alphaType = SkAlphaType(frameInfo.fAlphaType)
        self.blend = SkCodecFrameBlend(frameInfo.fBlend)
        self.has = frameInfo.fHas
        self.fullyOpaque = frameInfo.fFullyOpaque
    }

    public var skCodecFrameInfo: sk_codec_frameinfo_t {
        return sk_codec_frameinfo_t(
            fRequiredFrame: Int32(requiredFrame),
            fDuration: Int32(duration),
            fAlphaType: alphaType.skAlphaType,
            fBlend: blend.skCodecFrameBlend,
            fHas: has,
            fFullyOpaque: fullyOpaque
        )
    }
}

public enum SkCodecFrameBlend: UInt32 {
    case src = 0
    case srcOver = 1

    public init(_ blend: sk_codec_frame_blend_t) {
        self = SkCodecFrameBlend(rawValue: blend.rawValue)!
    }

    public var skCodecFrameBlend: sk_codec_frame_blend_t {
        return sk_codec_frame_blend_t(rawValue: self.rawValue)
    }
}