import Foundation
import Skia

public class SkString {
    public var handle: OpaquePointer?

    public init() {
        self.handle = sk_string_new_empty()
    }

    public init(copy src: OpaquePointer?) {
        guard let src = src else {
            self.handle = sk_string_new_empty()
            return
        }
        let length = sk_string_get_size(src)
        let cStr = sk_string_get_c_str(src)
        self.handle = sk_string_new_with_copy(cStr, length)
    }

    public init(string: String) {
        let utf8 = string.utf8
        self.handle = utf8.withContiguousStorageIfAvailable { buffer in
            sk_string_new_with_copy(buffer.baseAddress, buffer.count)
        }
        // Fallback if withContiguousStorageIfAvailable returns nil (shouldn't happen for String)
        if self.handle == nil {
            let cString = string.cString(using: .utf8)!
            self.handle = cString.withUnsafeBufferPointer { buffer in
                sk_string_new_with_copy(buffer.baseAddress, buffer.count - 1) // -1 to exclude null terminator
            }
        }
    }

    deinit {
        sk_string_destructor(handle)
    }

    public var count: Int {
        return Int(sk_string_get_size(handle))
    }

    public var cString: UnsafePointer<CChar>? {
        return sk_string_get_c_str(handle)
    }

    public var description: String {
        guard let cStr = cString else { return "" }
        return String(cString: cStr)
    }
}