import Foundation
import CSkia

public class SkData: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public convenience override init() {
        self.init(handle: sk_data_new_empty())
    }

    public convenience init(bytes: UnsafeRawPointer, count: Int) {
        self.init(handle: sk_data_new_with_copy(bytes, count))
    }

    public convenience init(data: Data) {
        self.init(handle: data.withUnsafeBytes { buffer in
            sk_data_new_with_copy(buffer.baseAddress, buffer.count)
        })
    }

    public convenience init(subset src: SkData, offset: Int, length: Int) {
        self.init(handle: sk_data_new_subset(src.handle, offset, length))
    }

    public convenience init?(file path: String) {
        guard let handle = sk_data_new_from_file(path) else { return nil }
        self.init(handle: handle)
    }

    public convenience init?(stream: SkStream, length: Int) {
        guard let handle = sk_data_new_from_stream(stream.handle, length) else { return nil }
        self.init(handle: handle)
    }

    public convenience init(uninitialized size: Int) {
        self.init(handle: sk_data_new_uninitialized(size))
    }

    public convenience init(bytesNoCopy ptr: UnsafeRawPointer, count: Int, releaseProc: sk_data_release_proc?, context: UnsafeMutableRawPointer?) {
        self.init(handle: sk_data_new_with_proc(ptr, count, releaseProc, context))
    }

    public var size: Int {
        return Int(sk_data_get_size(handle))
    }

    public var bytes: UnsafeRawPointer? {
        return sk_data_get_data(handle)
    }

    public var uint8Bytes: UnsafePointer<UInt8>? {
        return sk_data_get_bytes(handle)
    }

    public var data: Data? {
        guard let bytes = self.bytes else { return nil }
        return Data(bytes: bytes, count: self.size)
    }
}