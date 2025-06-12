import Foundation
import CSkia

// MARK: - Reference Counting

public class SkRefCnt {
    public var handle: OpaquePointer?

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_refcnt_safe_unref(handle)
    }

    public var isUnique: Bool {
        return sk_refcnt_unique(handle)
    }

    public var refCount: Int {
        return Int(sk_refcnt_get_ref_count(handle))
    }

    public func `ref`() {
        sk_refcnt_safe_ref(handle)
    }

    public func unref() {
        sk_refcnt_safe_unref(handle)
    }
}

public class SkNVRefCnt {
    public var handle: OpaquePointer?

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_nvrefcnt_safe_unref(handle)
    }

    public var isUnique: Bool {
        return sk_nvrefcnt_unique(handle)
    }

    public var refCount: Int {
        return Int(sk_nvrefcnt_get_ref_count(handle))
    }

    public func `ref`() {
        sk_nvrefcnt_safe_ref(handle)
    }

    public func unref() {
        sk_nvrefcnt_safe_unref(handle)
    }
}

// MARK: - Color Type

public extension SkColorType {
    static var default8888: SkColorType {
        return SkColorType(sk_colortype_get_default_8888())
    }
}

// MARK: - Library Information

public struct SkVersion {
    public static var milestone: Int {
        return Int(sk_version_get_milestone())
    }

    public static var increment: Int {
        return Int(sk_version_get_increment())
    }

    public static var string: String {
        guard let cStr = sk_version_get_string() else { return "" }
        return String(cString: cStr)
    }
}