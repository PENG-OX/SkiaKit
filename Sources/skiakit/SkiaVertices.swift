import Foundation
import Skia

public class SkVertices: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public static func makeCopy(mode: SkVerticesVertexMode, vertexCount: Int, positions: [SkPoint], texCoords: [SkPoint]?, colors: [SkColor]?, indexCount: Int, indices: [UInt16]?, isVolatile: Bool) -> SkVertices? {
        let skPositions = positions.map { $0.skPoint }
        let skTexCoords = texCoords?.map { $0.skPoint }
        let skColors = colors?.map { $0 }

        guard let handle = skPositions.withUnsafeBufferPointer({ positionsPtr in
            skTexCoords?.withUnsafeBufferPointer({ texCoordsPtr in
                skColors?.withUnsafeBufferPointer({ colorsPtr in
                    indices?.withUnsafeBufferPointer({ indicesPtr in
                        sk_vertices_make_copy(mode.skVerticesVertexMode, Int32(vertexCount), positionsPtr.baseAddress, texCoordsPtr.baseAddress, colorsPtr.baseAddress, Int32(indexCount), indicesPtr.baseAddress, isVolatile)
                    }) ?? sk_vertices_make_copy(mode.skVerticesVertexMode, Int32(vertexCount), positionsPtr.baseAddress, texCoordsPtr.baseAddress, colorsPtr.baseAddress, Int32(indexCount), nil, isVolatile)
                }) ?? sk_vertices_make_copy(mode.skVerticesVertexMode, Int32(vertexCount), positionsPtr.baseAddress, texCoordsPtr.baseAddress, nil, Int32(indexCount), nil, isVolatile)
            }) ?? sk_vertices_make_copy(mode.skVerticesVertexMode, Int32(vertexCount), positionsPtr.baseAddress, nil, nil, Int32(indexCount), nil, isVolatile)
        }) else { return nil }
        return SkVertices(handle: handle)
    }

    public var uniqueId: UInt32 {
        return sk_vertices_get_unique_id(handle)
    }

    public var bounds: SkRect {
        var rect = sk_rect_t()
        sk_vertices_get_bounds(handle, &rect)
        return SkRect(rect)
    }

    public var approximateBytesUsed: Int {
        return Int(sk_vertices_approximate_bytes_used(handle))
    }
}

public enum SkVerticesVertexMode: UInt32 {
    case triangles = 0
    case triangleStrip = 1
    case triangleFan = 2

    public init(_ mode: sk_vertices_vertex_mode_t) {
        self = SkVerticesVertexMode(rawValue: mode.rawValue)!
    }

    public var skVerticesVertexMode: sk_vertices_vertex_mode_t {
        return sk_vertices_vertex_mode_t(rawValue: self.rawValue)
    }
}