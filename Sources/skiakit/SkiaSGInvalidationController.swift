import Foundation
import Skia

public class SKSGInvalidationController {
    public var handle: OpaquePointer?

    public convenience init() {
        self.init(handle: sksg_invalidation_controller_new())
    }

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sksg_invalidation_controller_delete(handle)
    }

    public func inval(rect: SkRect, matrix: SkMatrix) {
        var skRect = rect.skRect
        var skMatrix = matrix.skMatrix
        sksg_invalidation_controller_inval(handle, &skRect, &skMatrix)
    }

    public var bounds: SkRect {
        var rect = sk_rect_t()
        sksg_invalidation_controller_get_bounds(handle, &rect)
        return SkRect(rect)
    }

    public func begin() {
        sksg_invalidation_controller_begin(handle)
    }

    public func end() {
        sksg_invalidation_controller_end(handle)
    }

    public func reset() {
        sksg_invalidation_controller_reset(handle)
    }
}