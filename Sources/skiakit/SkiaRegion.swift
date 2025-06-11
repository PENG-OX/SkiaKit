import Foundation
import Skia

public class SkRegion {
    public var handle: OpaquePointer?

    public convenience init() {
        self.init(handle: sk_region_new())
    }

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_region_delete(handle)
    }

    public var isEmpty: Bool {
        return sk_region_is_empty(handle)
    }

    public var isRect: Bool {
        return sk_region_is_rect(handle)
    }

    public var isComplex: Bool {
        return sk_region_is_complex(handle)
    }

    public var bounds: SkIRect {
        var rect = sk_irect_t()
        sk_region_get_bounds(handle, &rect)
        return SkIRect(rect)
    }

    public func getBoundaryPath(path: SkPath) -> Bool {
        return sk_region_get_boundary_path(handle, path.handle)
    }

    public func setEmpty() -> Bool {
        return sk_region_set_empty(handle)
    }

    public func setRect(rect: SkIRect) -> Bool {
        var skRect = rect.skIRect
        return sk_region_set_rect(handle, &skRect)
    }

    public func setRects(rects: [SkIRect]) -> Bool {
        let skRects = rects.map { $0.skIRect }
        return skRects.withUnsafeBufferPointer { ptr in
            sk_region_set_rects(handle, ptr.baseAddress, Int32(ptr.count))
        }
    }

    public func setRegion(region: SkRegion) -> Bool {
        return sk_region_set_region(handle, region.handle)
    }

    public func setPath(path: SkPath, clip: SkRegion) -> Bool {
        return sk_region_set_path(handle, path.handle, clip.handle)
    }

    public func intersects(rect: SkIRect) -> Bool {
        var skRect = rect.skIRect
        return sk_region_intersects_rect(handle, &skRect)
    }

    public func intersects(region: SkRegion) -> Bool {
        return sk_region_intersects(handle, region.handle)
    }

    public func contains(x: Int, y: Int) -> Bool {
        return sk_region_contains_point(handle, Int32(x), Int32(y))
    }

    public func contains(rect: SkIRect) -> Bool {
        var skRect = rect.skIRect
        return sk_region_contains_rect(handle, &skRect)
    }

    public func contains(region: SkRegion) -> Bool {
        return sk_region_contains(handle, region.handle)
    }

    public func quickContains(rect: SkIRect) -> Bool {
        var skRect = rect.skIRect
        return sk_region_quick_contains(handle, &skRect)
    }

    public func quickReject(rect: SkIRect) -> Bool {
        var skRect = rect.skIRect
        return sk_region_quick_reject_rect(handle, &skRect)
    }

    public func quickReject(region: SkRegion) -> Bool {
        return sk_region_quick_reject(handle, region.handle)
    }

    public func translate(x: Int, y: Int) {
        sk_region_translate(handle, Int32(x), Int32(y))
    }

    public func op(rect: SkIRect, operation: SkRegionOp) -> Bool {
        var skRect = rect.skIRect
        return sk_region_op_rect(handle, &skRect, operation.skRegionOp)
    }

    public func op(region: SkRegion, operation: SkRegionOp) -> Bool {
        return sk_region_op(handle, region.handle, operation.skRegionOp)
    }
}

public enum SkRegionOp: UInt32 {
    case difference = 0
    case intersect = 1
    case union = 2
    case xor = 3
    case reverseDifference = 4
    case replace = 5

    public init(_ op: sk_region_op_t) {
        self = SkRegionOp(rawValue: op.rawValue)!
    }

    public var skRegionOp: sk_region_op_t {
        return sk_region_op_t(rawValue: self.rawValue)
    }
}

// MARK: - Iterators

public class SkRegionIterator {
    public var handle: OpaquePointer?

    public init(region: SkRegion) {
        self.handle = sk_region_iterator_new(region.handle)
    }

    deinit {
        sk_region_iterator_delete(handle)
    }

    public func rewind() -> Bool {
        return sk_region_iterator_rewind(handle)
    }

    public var isDone: Bool {
        return sk_region_iterator_done(handle)
    }

    public func next() {
        sk_region_iterator_next(handle)
    }

    public var rect: SkIRect {
        var skRect = sk_irect_t()
        sk_region_iterator_rect(handle, &skRect)
        return SkIRect(skRect)
    }
}

public class SkRegionCliperator {
    public var handle: OpaquePointer?

    public init(region: SkRegion, clip: SkIRect) {
        var skClip = clip.skIRect
        self.handle = sk_region_cliperator_new(region.handle, &skClip)
    }

    deinit {
        sk_region_cliperator_delete(handle)
    }

    public var isDone: Bool {
        return sk_region_cliperator_done(handle)
    }

    public func next() {
        sk_region_cliperator_next(handle)
    }

    public var rect: SkIRect {
        var skRect = sk_irect_t()
        sk_region_cliperator_rect(handle, &skRect)
        return SkIRect(skRect)
    }
}

public class SkRegionSpanerator {
    public var handle: OpaquePointer?

    public init(region: SkRegion, y: Int, left: Int, right: Int) {
        self.handle = sk_region_spanerator_new(region.handle, Int32(y), Int32(left), Int32(right))
    }

    deinit {
        sk_region_spanerator_delete(handle)
    }

    public func next() -> (left: Int, right: Int)? {
        var left: Int32 = 0
        var right: Int32 = 0
        if sk_region_spanerator_next(handle, &left, &right) {
            return (Int(left), Int(right))
        }
        return nil
    }
}