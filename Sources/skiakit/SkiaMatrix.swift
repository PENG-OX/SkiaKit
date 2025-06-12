import Foundation
import CSkia

public extension SkMatrix {
    func tryInvert() -> SkMatrix? {
        var result = SkMatrix()
        var skMatrix = self.skMatrix
        if sk_matrix_try_invert(&skMatrix, &result.skMatrix) {
            return result
        }
        return nil
    }

    func concat(first: SkMatrix, second: SkMatrix) {
        var skResult = self.skMatrix
        var skFirst = first.skMatrix
        var skSecond = second.skMatrix
        sk_matrix_concat(&skResult, &skFirst, &skSecond)
        self = SkMatrix(skResult)
    }

    func preConcat(matrix: SkMatrix) {
        var skResult = self.skMatrix
        var skMatrix = matrix.skMatrix
        sk_matrix_pre_concat(&skResult, &skMatrix)
        self = SkMatrix(skResult)
    }

    func postConcat(matrix: SkMatrix) {
        var skResult = self.skMatrix
        var skMatrix = matrix.skMatrix
        sk_matrix_post_concat(&skResult, &skMatrix)
        self = SkMatrix(skResult)
    }

    func mapRect(source: SkRect) -> SkRect {
        var dest = SkRect()
        var skMatrix = self.skMatrix
        var skSource = source.skRect
        sk_matrix_map_rect(&skMatrix, &dest.skRect, &skSource)
        return dest
    }

    func mapPoints(src: [SkPoint]) -> [SkPoint] {
        var dst = [SkPoint](repeating: SkPoint(), count: src.count)
        var skMatrix = self.skMatrix
        src.withUnsafeBufferPointer { srcPtr in
            dst.withUnsafeMutableBufferPointer { dstPtr in
                sk_matrix_map_points(&skMatrix, &dstPtr.baseAddress!.pointee.skPoint, &srcPtr.baseAddress!.pointee.skPoint, Int32(src.count))
            }
        }
        return dst
    }

    func mapVectors(src: [SkPoint]) -> [SkPoint] {
        var dst = [SkPoint](repeating: SkPoint(), count: src.count)
        var skMatrix = self.skMatrix
        src.withUnsafeBufferPointer { srcPtr in
            dst.withUnsafeMutableBufferPointer { dstPtr in
                sk_matrix_map_vectors(&skMatrix, &dstPtr.baseAddress!.pointee.skPoint, &srcPtr.baseAddress!.pointee.skPoint, Int32(src.count))
            }
        }
        return dst
    }

    func mapXY(x: Float, y: Float) -> SkPoint {
        var result = SkPoint()
        var skMatrix = self.skMatrix
        sk_matrix_map_xy(&skMatrix, x, y, &result.skPoint)
        return result
    }

    func mapVector(x: Float, y: Float) -> SkPoint {
        var result = SkPoint()
        var skMatrix = self.skMatrix
        sk_matrix_map_vector(&skMatrix, x, y, &result.skPoint)
        return result
    }

    func mapRadius(radius: Float) -> Float {
        var skMatrix = self.skMatrix
        return sk_matrix_map_radius(&skMatrix, radius)
    }
}