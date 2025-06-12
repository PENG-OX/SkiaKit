import Foundation
import CSkia

public class SkStream {
    public var handle: OpaquePointer?

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_stream_destroy(handle)
    }

    public func read(buffer: UnsafeMutableRawPointer, size: Int) -> Int {
        return Int(sk_stream_read(handle, buffer, size))
    }

    public func peek(buffer: UnsafeMutableRawPointer, size: Int) -> Int {
        return Int(sk_stream_peek(handle, buffer, size))
    }

    public func skip(size: Int) -> Int {
        return Int(sk_stream_skip(handle, size))
    }

    public var isAtEnd: Bool {
        return sk_stream_is_at_end(handle)
    }

    public func readS8() -> Int8? {
        var value: Int8 = 0
        if sk_stream_read_s8(handle, &value) { return value }
        return nil
    }

    public func readS16() -> Int16? {
        var value: Int16 = 0
        if sk_stream_read_s16(handle, &value) { return value }
        return nil
    }

    public func readS32() -> Int32? {
        var value: Int32 = 0
        if sk_stream_read_s32(handle, &value) { return value }
        return nil
    }

    public func readU8() -> UInt8? {
        var value: UInt8 = 0
        if sk_stream_read_u8(handle, &value) { return value }
        return nil
    }

    public func readU16() -> UInt16? {
        var value: UInt16 = 0
        if sk_stream_read_u16(handle, &value) { return value }
        return nil
    }

    public func readU32() -> UInt32? {
        var value: UInt32 = 0
        if sk_stream_read_u32(handle, &value) { return value }
        return nil
    }

    public func readBool() -> Bool? {
        var value: Bool = false
        if sk_stream_read_bool(handle, &value) { return value }
        return nil
    }

    public func rewind() -> Bool {
        return sk_stream_rewind(handle)
    }

    public var hasPosition: Bool {
        return sk_stream_has_position(handle)
    }

    public var position: Int {
        return Int(sk_stream_get_position(handle))
    }

    public func seek(position: Int) -> Bool {
        return sk_stream_seek(handle, position)
    }

    public func move(offset: Int) -> Bool {
        return sk_stream_move(handle, Int(offset))
    }

    public var hasLength: Bool {
        return sk_stream_has_length(handle)
    }

    public var length: Int {
        return Int(sk_stream_get_length(handle))
    }

    public var memoryBase: UnsafeRawPointer? {
        return sk_stream_get_memory_base(handle)
    }

    public func fork() -> SkStream? {
        guard let newHandle = sk_stream_fork(handle) else { return nil }
        return SkStream(handle: newHandle)
    }

    public func duplicate() -> SkStream? {
        guard let newHandle = sk_stream_duplicate(handle) else { return nil }
        return SkStream(handle: newHandle)
    }
}

public class SkFileStream: SkStream {
    public convenience init?(path: String) {
        guard let handle = sk_filestream_new(path) else { return nil }
        self.init(handle: OpaquePointer(handle))
    }

    public var isValid: Bool {
        return sk_filestream_is_valid(OpaquePointer(handle))
    }

    deinit {
        sk_filestream_destroy(OpaquePointer(handle))
    }
}

public class SkMemoryStream: SkStream {
    public convenience override init() {
        self.init(handle: OpaquePointer(sk_memorystream_new()))
    }

    public convenience init(length: Int) {
        self.init(handle: OpaquePointer(sk_memorystream_new_with_length(length)))
    }

    public convenience init(data: UnsafeRawPointer, length: Int, copyData: Bool) {
        self.init(handle: OpaquePointer(sk_memorystream_new_with_data(data, length, copyData)))
    }

    public convenience init(skData: SkData) {
        self.init(handle: OpaquePointer(sk_memorystream_new_with_skdata(skData.handle)))
    }

    public func setMemory(data: UnsafeRawPointer, length: Int, copyData: Bool) {
        sk_memorystream_set_memory(OpaquePointer(handle), data, length, copyData)
    }

    deinit {
        sk_memorystream_destroy(OpaquePointer(handle))
    }
}

public class SkWStream {
    public var handle: OpaquePointer?

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        // No explicit destroy for base SkWStream, subclasses handle it.
    }

    public func write(buffer: UnsafeRawPointer, size: Int) -> Bool {
        return sk_wstream_write(handle, buffer, size)
    }

    public func newline() -> Bool {
        return sk_wstream_newline(handle)
    }

    public func flush() {
        sk_wstream_flush(handle)
    }

    public var bytesWritten: Int {
        return Int(sk_wstream_bytes_written(handle))
    }

    public func write8(value: UInt8) -> Bool {
        return sk_wstream_write_8(handle, value)
    }

    public func write16(value: UInt16) -> Bool {
        return sk_wstream_write_16(handle, value)
    }

    public func write32(value: UInt32) -> Bool {
        return sk_wstream_write_32(handle, value)
    }

    public func writeText(value: String) -> Bool {
        return value.withCString { cString in
            sk_wstream_write_text(handle, cString)
        }
    }

    public func writeDecAsText(value: Int32) -> Bool {
        return sk_wstream_write_dec_as_text(handle, value)
    }

    public func writeBigDecAsText(value: Int64, minDigits: Int) -> Bool {
        return sk_wstream_write_bigdec_as_text(handle, value, Int32(minDigits))
    }

    public func writeHexAsText(value: UInt32, minDigits: Int) -> Bool {
        return sk_wstream_write_hex_as_text(handle, value, Int32(minDigits))
    }

    public func writeScalarAsText(value: Float) -> Bool {
        return sk_wstream_write_scalar_as_text(handle, value)
    }

    public func writeBool(value: Bool) -> Bool {
        return sk_wstream_write_bool(handle, value)
    }

    public func writeScalar(value: Float) -> Bool {
        return sk_wstream_write_scalar(handle, value)
    }

    public func writePackedUInt(value: Int) -> Bool {
        return sk_wstream_write_packed_uint(handle, value)
    }

    public func writeStream(input: SkStream, length: Int) -> Bool {
        return sk_wstream_write_stream(handle, input.handle, length)
    }

    public static func getSizeOfPackedUInt(value: Int) -> Int {
        return Int(sk_wstream_get_size_of_packed_uint(value))
    }
}

public class SkFileWStream: SkWStream {
    public convenience init?(path: String) {
        guard let handle = sk_filewstream_new(path) else { return nil }
        self.init(handle: OpaquePointer(handle))
    }

    public var isValid: Bool {
        return sk_filewstream_is_valid(OpaquePointer(handle))
    }

    deinit {
        sk_filewstream_destroy(OpaquePointer(handle))
    }
}

public class SkDynamicMemoryWStream: SkWStream {
    public convenience override init() {
        self.init(handle: OpaquePointer(sk_dynamicmemorywstream_new()))
    }

    public func detachAsStream() -> SkStream? {
        guard let streamHandle = sk_dynamicmemorywstream_detach_as_stream(OpaquePointer(handle)) else { return nil }
        return SkStream(handle: streamHandle)
    }

    public func detachAsData() -> SkData? {
        guard let dataHandle = sk_dynamicmemorywstream_detach_as_data(OpaquePointer(handle)) else { return nil }
        return SkData(handle: dataHandle)
    }

    public func copyTo(data: UnsafeMutableRawPointer) {
        sk_dynamicmemorywstream_copy_to(OpaquePointer(handle), data)
    }

    public func writeToStream(dst: SkWStream) -> Bool {
        return sk_dynamicmemorywstream_write_to_stream(OpaquePointer(handle), dst.handle)
    }

    deinit {
        sk_dynamicmemorywstream_destroy(OpaquePointer(handle))
    }
}