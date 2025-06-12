import Foundation
import CSkia

public class SkDrawable: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public var generationId: UInt32 {
        return sk_drawable_get_generation_id(handle)
    }

    public var bounds: SkRect {
        var rect = SkRect()
        sk_drawable_get_bounds(handle, &rect.skRect)
        return rect
    }

    public func draw(canvas: SkCanvas, matrix: SkMatrix?) {
        var skMatrix: sk_matrix_t? = nil
        if let matrix = matrix {
            skMatrix = matrix.skMatrix
        }
        sk_drawable_draw(handle, canvas.handle, skMatrix)
    }

    public func newPictureSnapshot() -> SkPicture? {
        return SkPicture(handle: sk_drawable_new_picture_snapshot(handle))
    }

    public func notifyDrawingChanged() {
        sk_drawable_notify_drawing_changed(handle)
    }

    public var approximateBytesUsed: Int {
        return Int(sk_drawable_approximate_bytes_used(handle))
    }
}