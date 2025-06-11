import Foundation
import Skia

public class SkPicture: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public var uniqueId: UInt32 {
        return sk_picture_get_unique_id(handle)
    }

    public var cullRect: SkRect {
        var rect = sk_rect_t()
        sk_picture_get_cull_rect(handle, &rect)
        return SkRect(rect)
    }

    public func makeShader(tileModeX: SkShaderTileMode, tileModeY: SkShaderTileMode, filterMode: SkFilterMode, localMatrix: SkMatrix?, tile: SkRect?) -> SkShader? {
        var skLocalMatrix: sk_matrix_t? = localMatrix?.skMatrix
        var skTile: sk_rect_t? = tile?.skRect
        guard let shaderHandle = sk_picture_make_shader(handle, tileModeX.skShaderTileMode, tileModeY.skShaderTileMode, filterMode.skFilterMode, &skLocalMatrix, &skTile) else { return nil }
        return SkShader(handle: shaderHandle)
    }

    public func serializeToData() -> SkData? {
        guard let dataHandle = sk_picture_serialize_to_data(handle) else { return nil }
        return SkData(handle: dataHandle)
    }

    public func serializeToStream(stream: SkWStream) {
        sk_picture_serialize_to_stream(handle, stream.handle)
    }

    public static func deserialize(from stream: SkStream) -> SkPicture? {
        guard let handle = sk_picture_deserialize_from_stream(stream.handle) else { return nil }
        return SkPicture(handle: handle)
    }

    public static func deserialize(from data: SkData) -> SkPicture? {
        guard let handle = sk_picture_deserialize_from_data(data.handle) else { return nil }
        return SkPicture(handle: handle)
    }

    public static func deserialize(from buffer: UnsafeMutableRawPointer, length: Int) -> SkPicture? {
        guard let handle = sk_picture_deserialize_from_memory(buffer, length) else { return nil }
        return SkPicture(handle: handle)
    }

    public func playback(canvas: SkCanvas) {
        sk_picture_playback(handle, canvas.handle)
    }

    public func approximateOpCount(nested: Bool) -> Int {
        return Int(sk_picture_approximate_op_count(handle, nested))
    }

    public var approximateBytesUsed: Int {
        return Int(sk_picture_approximate_bytes_used(handle))
    }
}

public class SkPictureRecorder {
    public var handle: OpaquePointer?

    public convenience init() {
        self.init(handle: sk_picture_recorder_new())
    }

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_picture_recorder_delete(handle)
    }

    public func beginRecording(cullRect: SkRect) -> SkCanvas? {
        var skCullRect = cullRect.skRect
        guard let canvasHandle = sk_picture_recorder_begin_recording(handle, &skCullRect) else { return nil }
        return SkCanvas(handle: canvasHandle)
    }

    public func beginRecording(cullRect: SkRect, bbhFactory: SkBBHFactory?) -> SkCanvas? {
        var skCullRect = cullRect.skRect
        guard let canvasHandle = sk_picture_recorder_begin_recording_with_bbh_factory(handle, &skCullRect, bbhFactory?.handle) else { return nil }
        return SkCanvas(handle: canvasHandle)
    }

    public func endRecording() -> SkPicture? {
        guard let pictureHandle = sk_picture_recorder_end_recording(handle) else { return nil }
        return SkPicture(handle: pictureHandle)
    }

    public func endRecordingAsDrawable() -> SkDrawable? {
        guard let drawableHandle = sk_picture_recorder_end_recording_as_drawable(handle) else { return nil }
        return SkDrawable(handle: drawableHandle)
    }

    public var recordingCanvas: SkCanvas? {
        guard let canvasHandle = sk_picture_get_recording_canvas(handle) else { return nil }
        return SkCanvas(handle: canvasHandle)
    }
}

public class SkBBHFactory {
    public var handle: OpaquePointer?
    // Placeholder for actual implementation
    public init(handle: OpaquePointer?) { self.handle = handle }
}

public class SkDrawable: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }
    // Placeholder for actual implementation
}

public class SkRTreeFactory {
    public var handle: OpaquePointer?

    public convenience init() {
        self.init(handle: sk_rtree_factory_new())
    }

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_rtree_factory_delete(handle)
    }
}