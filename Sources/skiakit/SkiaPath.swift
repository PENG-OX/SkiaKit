import Foundation
import CSkia

public class SkPath {
    public var handle: OpaquePointer?

    public convenience init() {
        self.init(handle: sk_path_new())
    }

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_path_delete(handle)
    }

    public func moveTo(x: Float, y: Float) {
        sk_path_move_to(handle, x, y)
    }

    public func lineTo(x: Float, y: Float) {
        sk_path_line_to(handle, x, y)
    }

    public func quadTo(x0: Float, y0: Float, x1: Float, y1: Float) {
        sk_path_quad_to(handle, x0, y0, x1, y1)
    }

    public func conicTo(x0: Float, y0: Float, x1: Float, y1: Float, w: Float) {
        sk_path_conic_to(handle, x0, y0, x1, y1, w)
    }

    public func cubicTo(x0: Float, y0: Float, x1: Float, y1: Float, x2: Float, y2: Float) {
        sk_path_cubic_to(handle, x0, y0, x1, y1, x2, y2)
    }

    public func arcTo(rx: Float, ry: Float, xAxisRotate: Float, largeArc: SkPathArcSize, sweep: SkPathDirection, x: Float, y: Float) {
        sk_path_arc_to(handle, rx, ry, xAxisRotate, largeArc.skPathArcSize, sweep.skPathDirection, x, y)
    }

    public func rArcTo(rx: Float, ry: Float, xAxisRotate: Float, largeArc: SkPathArcSize, sweep: SkPathDirection, x: Float, y: Float) {
        sk_path_rarc_to(handle, rx, ry, xAxisRotate, largeArc.skPathArcSize, sweep.skPathDirection, x, y)
    }

    public func arcTo(oval: SkRect, startAngle: Float, sweepAngle: Float, forceMoveTo: Bool) {
        var skOval = oval.skRect
        sk_path_arc_to_with_oval(handle, &skOval, startAngle, sweepAngle, forceMoveTo)
    }

    public func arcTo(x1: Float, y1: Float, x2: Float, y2: Float, radius: Float) {
        sk_path_arc_to_with_points(handle, x1, y1, x2, y2, radius)
    }

    public func close() {
        sk_path_close(handle)
    }

    public func addRect(rect: SkRect, direction: SkPathDirection) {
        var skRect = rect.skRect
        sk_path_add_rect(handle, &skRect, direction.skPathDirection)
    }

    public func addRRect(rrect: SkRRect, direction: SkPathDirection) {
        var skRRect = rrect.skRRect
        sk_path_add_rrect(handle, &skRRect, direction.skPathDirection)
    }

    public func addRRect(rrect: SkRRect, direction: SkPathDirection, startIndex: UInt32) {
        var skRRect = rrect.skRRect
        sk_path_add_rrect_start(handle, &skRRect, direction.skPathDirection, startIndex)
    }

    public func addRoundedRect(rect: SkRect, rx: Float, ry: Float, direction: SkPathDirection) {
        var skRect = rect.skRect
        sk_path_add_rounded_rect(handle, &skRect, rx, ry, direction.skPathDirection)
    }

    public func addOval(oval: SkRect, direction: SkPathDirection) {
        var skOval = oval.skRect
        sk_path_add_oval(handle, &skOval, direction.skPathDirection)
    }

    public func addCircle(x: Float, y: Float, radius: Float, direction: SkPathDirection) {
        sk_path_add_circle(handle, x, y, radius, direction.skPathDirection)
    }

    public var bounds: SkRect {
        var skRect = sk_rect_t()
        sk_path_get_bounds(handle, &skRect)
        return SkRect(skRect)
    }

    public var tightBounds: SkRect {
        var skRect = sk_rect_t()
        sk_path_compute_tight_bounds(handle, &skRect)
        return SkRect(skRect)
    }

    public func rMoveTo(dx: Float, dy: Float) {
        sk_path_rmove_to(handle, dx, dy)
    }

    public func rLineTo(dx: Float, dy: Float) {
        sk_path_rline_to(handle, dx, dy)
    }

    public func rQuadTo(dx0: Float, dy0: Float, dx1: Float, dy1: Float) {
        sk_path_rquad_to(handle, dx0, dy0, dx1, dy1)
    }

    public func rConicTo(dx0: Float, dy0: Float, dx1: Float, dy1: Float, w: Float) {
        sk_path_rconic_to(handle, dx0, dy0, dx1, dy1, w)
    }

    public func rCubicTo(dx0: Float, dy0: Float, dx1: Float, dy1: Float, dx2: Float, dy2: Float) {
        sk_path_rcubic_to(handle, dx0, dy0, dx1, dy1, dx2, dy2)
    }

    public func addRect(rect: SkRect, direction: SkPathDirection, startIndex: UInt32) {
        var skRect = rect.skRect
        sk_path_add_rect_start(handle, &skRect, direction.skPathDirection, startIndex)
    }

    public func addArc(rect: SkRect, startAngle: Float, sweepAngle: Float) {
        var skRect = rect.skRect
        sk_path_add_arc(handle, &skRect, startAngle, sweepAngle)
    }

    public var fillType: SkPathFillType {
        get { return SkPathFillType(sk_path_get_filltype(handle)) }
        set { sk_path_set_filltype(handle, newValue.skPathFillType) }
    }

    public func transform(_ matrix: SkMatrix) {
        var skMatrix = matrix.skMatrix
        sk_path_transform(handle, &skMatrix)
    }

    public func transform(matrix: SkMatrix, destination: SkPath) {
        var skMatrix = matrix.skMatrix
        sk_path_transform_to_dest(handle, &skMatrix, destination.handle)
    }

    public func clone() -> SkPath? {
        guard let clonedHandle = sk_path_clone(handle) else { return nil }
        return SkPath(handle: clonedHandle)
    }

    public func addPath(other: SkPath, dx: Float, dy: Float, mode: SkPathAddMode) {
        sk_path_add_path_offset(handle, other.handle, dx, dy, mode.skPathAddMode)
    }

    public func addPath(other: SkPath, matrix: SkMatrix, mode: SkPathAddMode) {
        var skMatrix = matrix.skMatrix
        sk_path_add_path_matrix(handle, other.handle, &skMatrix, mode.skPathAddMode)
    }

    public func addPath(other: SkPath, mode: SkPathAddMode) {
        sk_path_add_path(handle, other.handle, mode.skPathAddMode)
    }

    public func addPathReverse(other: SkPath) {
        sk_path_add_path_reverse(handle, other.handle)
    }

    public func reset() {
        sk_path_reset(handle)
    }

    public func rewind() {
        sk_path_rewind(handle)
    }

    public var countPoints: Int {
        return Int(sk_path_count_points(handle))
    }

    public var countVerbs: Int {
        return Int(sk_path_count_verbs(handle))
    }

    public func getPoint(index: Int) -> SkPoint {
        var skPoint = sk_point_t()
        sk_path_get_point(handle, Int32(index), &skPoint)
        return SkPoint(skPoint)
    }

    public func getPoints(max: Int) -> [SkPoint] {
        var skPoints = [sk_point_t](repeating: sk_point_t(), count: max)
        let count = Int(sk_path_get_points(handle, &skPoints, Int32(max)))
        return skPoints[0..<count].map { SkPoint($0) }
    }

    public func contains(x: Float, y: Float) -> Bool {
        return sk_path_contains(handle, x, y)
    }

    public func parseSvgString(_ svgString: String) -> Bool {
        let cString = svgString.cString(using: .utf8)!
        return cString.withUnsafeBufferPointer { ptr in
            sk_path_parse_svg_string(handle, ptr.baseAddress)
        }
    }

    public func toSvgString() -> SkString {
        let skString = SkString()
        sk_path_to_svg_string(handle, skString.handle)
        return skString
    }

    public var lastPoint: SkPoint? {
        var skPoint = sk_point_t()
        if sk_path_get_last_point(handle, &skPoint) {
            return SkPoint(skPoint)
        }
        return nil
    }

    public static func convertConicToQuads(p0: SkPoint, p1: SkPoint, p2: SkPoint, w: Float, pow2: Int) -> [SkPoint] {
        var skP0 = p0.skPoint
        var skP1 = p1.skPoint
        var skP2 = p2.skPoint
        let count = Int(pow(2.0, Float(pow2))) * 2 + 1 // Number of points in the resulting quadratic Bezier curve
        var skPoints = [sk_point_t](repeating: sk_point_t(), count: count)
        let resultCount = Int(sk_path_convert_conic_to_quads(&skP0, &skP1, &skP2, w, &skPoints, Int32(pow2)))
        return skPoints[0..<resultCount].map { SkPoint($0) }
    }

    public func addPoly(points: [SkPoint], close: Bool) {
        let skPoints = points.map { $0.skPoint }
        skPoints.withUnsafeBufferPointer { ptr in
            sk_path_add_poly(handle, ptr.baseAddress, Int32(ptr.count), close)
        }
    }

    public var segmentMasks: UInt32 {
        return sk_path_get_segment_masks(handle)
    }

    public func isOval() -> SkRect? {
        var skRect = sk_rect_t()
        if sk_path_is_oval(handle, &skRect) {
            return SkRect(skRect)
        }
        return nil
    }

    public func isRRect() -> SkRRect? {
        var skRRect = sk_rrect_t()
        if sk_path_is_rrect(handle, &skRRect) {
            return SkRRect(skRRect)
        }
        return nil
    }

    public func isLine() -> (SkPoint, SkPoint)? {
        var line = [sk_point_t](repeating: sk_point_t(), count: 2)
        if sk_path_is_line(handle, &line) {
            return (SkPoint(line[0]), SkPoint(line[1]))
        }
        return nil
    }

    public func isRect() -> (rect: SkRect, isClosed: Bool, direction: SkPathDirection)? {
        var skRect = sk_rect_t()
        var isClosed: Bool = false
        var direction: sk_path_direction_t = SK_PATH_DIRECTION_CW
        if sk_path_is_rect(handle, &skRect, &isClosed, &direction) {
            return (SkRect(skRect), isClosed, SkPathDirection(direction))
        }
        return nil
    }

    public var isConvex: Bool {
        return sk_path_is_convex(handle)
    }
}

public enum SkPathDirection: UInt32 {
    case clockwise = 0
    case counterClockwise = 1

    public init(_ direction: sk_path_direction_t) {
        self = SkPathDirection(rawValue: direction.rawValue)!
    }

    public var skPathDirection: sk_path_direction_t {
        return sk_path_direction_t(rawValue: self.rawValue)
    }
}

public enum SkPathArcSize: UInt32 {
    case small = 0
    case large = 1

    public init(_ size: sk_path_arc_size_t) {
        self = SkPathArcSize(rawValue: size.rawValue)!
    }

    public var skPathArcSize: sk_path_arc_size_t {
        return sk_path_arc_size_t(rawValue: self.rawValue)
    }
}

public enum SkPathFillType: UInt32 {
    case winding = 0
    case evenOdd = 1
    case inverseWinding = 2
    case inverseEvenOdd = 3

    public init(_ fillType: sk_path_filltype_t) {
        self = SkPathFillType(rawValue: fillType.rawValue)!
    }

    public var skPathFillType: sk_path_filltype_t {
        return sk_path_fill_type_t(rawValue: self.rawValue)
    }
}

public enum SkPathAddMode: UInt32 {
    case append = 0
    case extend = 1

    public init(_ mode: sk_path_add_mode_t) {
        self = SkPathAddMode(rawValue: mode.rawValue)!
    }

    public var skPathAddMode: sk_path_add_mode_t {
        return sk_path_add_mode_t(rawValue: self.rawValue)
    }
}

public enum SkPathVerb: UInt32 {
    case move = 0
    case line = 1
    case quad = 2
    case conic = 3
    case cubic = 4
    case close = 5
    case done = 6

    public init(_ verb: sk_path_verb_t) {
        self = SkPathVerb(rawValue: verb.rawValue)!
    }

    public var skPathVerb: sk_path_verb_t {
        return sk_path_verb_t(rawValue: self.rawValue)
    }
}

public enum SkPathOp: UInt32 {
    case difference = 0
    case intersect = 1
    case union = 2
    case xor = 3
    case reverseDifference = 4

    public init(_ op: sk_pathop_t) {
        self = SkPathOp(rawValue: op.rawValue)!
    }

    public var skPathOp: sk_pathop_t {
        return sk_pathop_t(rawValue: self.rawValue)
    }
}

public struct SkPathMeasureMatrixFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let getPosition = SkPathMeasureMatrixFlags(rawValue: GET_POSITION_SK_PATHMEASURE_MATRIXFLAGS.rawValue)
    public static let getTangent = SkPathMeasureMatrixFlags(rawValue: GET_TANGENT_SK_PATHMEASURE_MATRIXFLAGS.rawValue)
    public static let getMatrixAll = SkPathMeasureMatrixFlags(rawValue: GET_MATRIX_ALL_SK_PATHMEASURE_MATRIXFLAGS.rawValue)
}

// MARK: - Iterators

public class SkPathIterator {
    public var handle: OpaquePointer?

    public init(path: SkPath, forceClose: Bool) {
        self.handle = sk_path_create_iter(path.handle, forceClose ? 1 : 0)
    }

    deinit {
        sk_path_iter_destroy(handle)
    }

    public func next(points: inout [SkPoint]) -> SkPathVerb {
        var skPoints = [sk_point_t](repeating: sk_point_t(), count: 4)
        let verb = sk_path_iter_next(handle, &skPoints)
        points = skPoints.map { SkPoint($0) }
        return SkPathVerb(verb)
    }

    public var conicWeight: Float {
        return sk_path_iter_conic_weight(handle)
    }

    public var isCloseLine: Bool {
        return sk_path_iter_is_close_line(handle) != 0
    }

    public var isClosedContour: Bool {
        return sk_path_iter_is_closed_contour(handle) != 0
    }
}

public class SkPathRawIterator {
    public var handle: OpaquePointer?

    public init(path: SkPath) {
        self.handle = sk_path_create_rawiter(path.handle)
    }

    deinit {
        sk_path_rawiter_destroy(handle)
    }

    public func peek() -> SkPathVerb {
        return SkPathVerb(sk_path_rawiter_peek(handle))
    }

    public func next(points: inout [SkPoint]) -> SkPathVerb {
        var skPoints = [sk_point_t](repeating: sk_point_t(), count: 4)
        let verb = sk_path_rawiter_next(handle, &skPoints)
        points = skPoints.map { SkPoint($0) }
        return SkPathVerb(verb)
    }

    public var conicWeight: Float {
        return sk_path_rawiter_conic_weight(handle)
    }
}

// MARK: - Path Ops

public extension SkPath {
    static func op(one: SkPath, two: SkPath, operation: SkPathOp, result: SkPath) -> Bool {
        return sk_pathop_op(one.handle, two.handle, operation.skPathOp, result.handle)
    }

    func simplify(result: SkPath) -> Bool {
        return sk_pathop_simplify(handle, result.handle)
    }

    var tightBoundsOp: SkRect? {
        var skRect = sk_rect_t()
        if sk_pathop_tight_bounds(handle, &skRect) {
            return SkRect(skRect)
        }
        return nil
    }

    func asWinding(result: SkPath) -> Bool {
        return sk_pathop_as_winding(handle, result.handle)
    }
}

// MARK: - Path Op Builder

public class SkOpBuilder {
    public var handle: OpaquePointer?

    public init() {
        self.handle = sk_opbuilder_new()
    }

    deinit {
        sk_opbuilder_destroy(handle)
    }

    public func add(path: SkPath, operation: SkPathOp) {
        sk_opbuilder_add(handle, path.handle, operation.skPathOp)
    }

    public func resolve(result: SkPath) -> Bool {
        return sk_opbuilder_resolve(handle, result.handle)
    }
}

// MARK: - Path Measure

public class SkPathMeasure {
    public var handle: OpaquePointer?

    public convenience init() {
        self.init(handle: sk_pathmeasure_new())
    }

    public convenience init?(path: SkPath, forceClosed: Bool, resScale: Float) {
        guard let handle = sk_pathmeasure_new_with_path(path.handle, forceClosed, resScale) else { return nil }
        self.init(handle: handle)
    }

    public init(handle: OpaquePointer?) {
        self.handle = handle
    }

    deinit {
        sk_pathmeasure_destroy(handle)
    }

    public func setPath(path: SkPath?, forceClosed: Bool) {
        sk_pathmeasure_set_path(handle, path?.handle, forceClosed)
    }

    public var length: Float {
        return sk_pathmeasure_get_length(handle)
    }

    public func getPosTan(distance: Float, position: inout SkPoint, tangent: inout SkVector) -> Bool {
        var skPosition = position.skPoint
        var skTangent = tangent.skVector
        let result = sk_pathmeasure_get_pos_tan(handle, distance, &skPosition, &skTangent)
        position = SkPoint(skPosition)
        tangent = SkVector(skTangent)
        return result
    }

    public func getMatrix(distance: Float, matrix: inout SkMatrix, flags: SkPathMeasureMatrixFlags) -> Bool {
        var skMatrix = matrix.skMatrix
        let result = sk_pathmeasure_get_matrix(handle, distance, &skMatrix, flags.skPathMeasureMatrixFlags)
        matrix = SkMatrix(skMatrix)
        return result
    }

    public func getSegment(start: Float, stop: Float, dst: SkPath, startWithMoveTo: Bool) -> Bool {
        return sk_pathmeasure_get_segment(handle, start, stop, dst.handle, startWithMoveTo)
    }

    public var isClosed: Bool {
        return sk_pathmeasure_is_closed(handle)
    }

    public func nextContour() -> Bool {
        return sk_pathmeasure_next_contour(handle)
    }
}