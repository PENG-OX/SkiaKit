import Foundation
import Skia

public enum SkRRectType: UInt32 {
    case empty = 0
    case rect = 1
    case oval = 2
    case simple = 3
    case ninePatch = 4
    case complex = 5

    init(_ type: sk_rrect_type_t) {
        self = SkRRectType(rawValue: type.rawValue)!
    }

    var skRRectType: sk_rrect_type_t {
        return sk_rrect_type_t(rawValue: self.rawValue)
    }
}

public enum SkRRectCorner: UInt32 {
    case upperLeft = 0
    case upperRight = 1
    case lowerRight = 2
    case lowerLeft = 3

    init(_ corner: sk_rrect_corner_t) {
        self = SkRRectCorner(rawValue: corner.rawValue)!
    }

    var skRRectCorner: sk_rrect_corner_t {
        return sk_rrect_corner_t(rawValue: self.rawValue)
    }
}

public extension SkRRect {
    init() {
        self.init(sk_rrect_new())
    }

    init(copy rrect: SkRRect) {
        self.init(sk_rrect_new_copy(rrect.handle))
    }

    func delete() {
        sk_rrect_delete(handle)
    }

    var type: SkRRectType {
        return SkRRectType(sk_rrect_get_type(handle))
    }

    var rect: SkRect {
        var rect = SkRect()
        sk_rrect_get_rect(handle, &rect.skRect)
        return rect
    }

    func getRadii(corner: SkRRectCorner) -> SkVector {
        var radii = SkVector()
        sk_rrect_get_radii(handle, corner.skRRectCorner, &radii.skVector)
        return radii
    }

    var width: Float {
        return sk_rrect_get_width(handle)
    }

    var height: Float {
        return sk_rrect_get_height(handle)
    }

    mutating func setEmpty() {
        sk_rrect_set_empty(handle)
    }

    mutating func set(rect: SkRect) {
        var skRect = rect.skRect
        sk_rrect_set_rect(handle, &skRect)
    }

    mutating func setOval(rect: SkRect) {
        var skRect = rect.skRect
        sk_rrect_set_oval(handle, &skRect)
    }

    mutating func set(rect: SkRect, xRad: Float, yRad: Float) {
        var skRect = rect.skRect
        sk_rrect_set_rect_xy(handle, &skRect, xRad, yRad)
    }

    mutating func setNinePatch(rect: SkRect, leftRad: Float, topRad: Float, rightRad: Float, bottomRad: Float) {
        var skRect = rect.skRect
        sk_rrect_set_nine_patch(handle, &skRect, leftRad, topRad, rightRad, bottomRad)
    }

    mutating func set(rect: SkRect, radii: [SkVector]) {
        var skRect = rect.skRect
        radii.withUnsafeBufferPointer { radiiPtr in
            sk_rrect_set_rect_radii(handle, &skRect, &radiiPtr.baseAddress!.pointee.skVector)
        }
    }

    mutating func inset(dx: Float, dy: Float) {
        sk_rrect_inset(handle, dx, dy)
    }

    mutating func outset(dx: Float, dy: Float) {
        sk_rrect_outset(handle, dx, dy)
    }

    mutating func offset(dx: Float, dy: Float) {
        sk_rrect_offset(handle, dx, dy)
    }

    func contains(rect: SkRect) -> Bool {
        var skRect = rect.skRect
        return sk_rrect_contains(handle, &skRect)
    }

    var isValid: Bool {
        return sk_rrect_is_valid(handle)
    }

    mutating func transform(matrix: SkMatrix) -> SkRRect? {
        var dest = SkRRect()
        var skMatrix = matrix.skMatrix
        if sk_rrect_transform(handle, &skMatrix, dest.handle) {
            return dest
        }
        return nil
    }
}