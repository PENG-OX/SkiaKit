import Foundation
import Skia

public class SkShader: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public func withLocalMatrix(localMatrix: SkMatrix) -> SkShader? {
        var skLocalMatrix = localMatrix.skMatrix
        guard let handle = sk_shader_with_local_matrix(self.handle, &skLocalMatrix) else { return nil }
        return SkShader(handle: handle)
    }

    public func withColorFilter(filter: SkColorFilter) -> SkShader? {
        guard let handle = sk_shader_with_color_filter(self.handle, filter.handle) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeEmpty() -> SkShader? {
        guard let handle = sk_shader_new_empty() else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeColor(color: SkColor) -> SkShader? {
        guard let handle = sk_shader_new_color(color) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeColor(color: SkColor4f, colorspace: SkColorSpace?) -> SkShader? {
        var skColor4f = color.skColor4f
        guard let handle = sk_shader_new_color4f(&skColor4f, colorspace?.handle) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeBlend(mode: SkBlendMode, dst: SkShader, src: SkShader) -> SkShader? {
        guard let handle = sk_shader_new_blend(mode.skBlendMode, dst.handle, src.handle) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeBlender(blender: SkBlender, dst: SkShader, src: SkShader) -> SkShader? {
        guard let handle = sk_shader_new_blender(blender.handle, dst.handle, src.handle) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeLinearGradient(points: [SkPoint], colors: [SkColor], colorPositions: [Float]?, tileMode: SkShaderTileMode, localMatrix: SkMatrix?) -> SkShader? {
        guard points.count == 2 else { return nil }
        let skPoints = points.map { $0.skPoint }
        let skColors = colors.map { $0 }
        var skLocalMatrix: sk_matrix_t? = localMatrix?.skMatrix

        guard let handle = skPoints.withUnsafeBufferPointer({ pointsPtr in
            skColors.withUnsafeBufferPointer({ colorsPtr in
                colorPositions?.withUnsafeBufferPointer({ posPtr in
                    sk_shader_new_linear_gradient(pointsPtr.baseAddress, colorsPtr.baseAddress, posPtr.baseAddress, Int32(colors.count), tileMode.skShaderTileMode, &skLocalMatrix)
                }) ?? sk_shader_new_linear_gradient(pointsPtr.baseAddress, colorsPtr.baseAddress, nil, Int32(colors.count), tileMode.skShaderTileMode, &skLocalMatrix)
            })
        }) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeLinearGradient(points: [SkPoint], colors: [SkColor4f], colorspace: SkColorSpace?, colorPositions: [Float]?, tileMode: SkShaderTileMode, localMatrix: SkMatrix?) -> SkShader? {
        guard points.count == 2 else { return nil }
        let skPoints = points.map { $0.skPoint }
        let skColors = colors.map { $0.skColor4f }
        var skColorspace: OpaquePointer? = colorspace?.handle
        var skLocalMatrix: sk_matrix_t? = localMatrix?.skMatrix

        guard let handle = skPoints.withUnsafeBufferPointer({ pointsPtr in
            skColors.withUnsafeBufferPointer({ colorsPtr in
                colorPositions?.withUnsafeBufferPointer({ posPtr in
                    sk_shader_new_linear_gradient_color4f(pointsPtr.baseAddress, colorsPtr.baseAddress, skColorspace, posPtr.baseAddress, Int32(colors.count), tileMode.skShaderTileMode, &skLocalMatrix)
                }) ?? sk_shader_new_linear_gradient_color4f(pointsPtr.baseAddress, colorsPtr.baseAddress, skColorspace, nil, Int32(colors.count), tileMode.skShaderTileMode, &skLocalMatrix)
            })
        }) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeRadialGradient(center: SkPoint, radius: Float, colors: [SkColor], colorPositions: [Float]?, tileMode: SkShaderTileMode, localMatrix: SkMatrix?) -> SkShader? {
        var skCenter = center.skPoint
        let skColors = colors.map { $0 }
        var skLocalMatrix: sk_matrix_t? = localMatrix?.skMatrix

        guard let handle = skColors.withUnsafeBufferPointer({ colorsPtr in
            colorPositions?.withUnsafeBufferPointer({ posPtr in
                sk_shader_new_radial_gradient(&skCenter, radius, colorsPtr.baseAddress, posPtr.baseAddress, Int32(colors.count), tileMode.skShaderTileMode, &skLocalMatrix)
            }) ?? sk_shader_new_radial_gradient(&skCenter, radius, colorsPtr.baseAddress, nil, Int32(colors.count), tileMode.skShaderTileMode, &skLocalMatrix)
        }) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeRadialGradient(center: SkPoint, radius: Float, colors: [SkColor4f], colorspace: SkColorSpace?, colorPositions: [Float]?, tileMode: SkShaderTileMode, localMatrix: SkMatrix?) -> SkShader? {
        var skCenter = center.skPoint
        let skColors = colors.map { $0.skColor4f }
        var skColorspace: OpaquePointer? = colorspace?.handle
        var skLocalMatrix: sk_matrix_t? = localMatrix?.skMatrix

        guard let handle = skColors.withUnsafeBufferPointer({ colorsPtr in
            colorPositions?.withUnsafeBufferPointer({ posPtr in
                sk_shader_new_radial_gradient_color4f(&skCenter, radius, colorsPtr.baseAddress, skColorspace, posPtr.baseAddress, Int32(colors.count), tileMode.skShaderTileMode, &skLocalMatrix)
            }) ?? sk_shader_new_radial_gradient_color4f(&skCenter, radius, colorsPtr.baseAddress, skColorspace, nil, Int32(colors.count), tileMode.skShaderTileMode, &skLocalMatrix)
        }) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeSweepGradient(center: SkPoint, colors: [SkColor], colorPositions: [Float]?, tileMode: SkShaderTileMode, startAngle: Float, endAngle: Float, localMatrix: SkMatrix?) -> SkShader? {
        var skCenter = center.skPoint
        let skColors = colors.map { $0 }
        var skLocalMatrix: sk_matrix_t? = localMatrix?.skMatrix

        guard let handle = skColors.withUnsafeBufferPointer({ colorsPtr in
            colorPositions?.withUnsafeBufferPointer({ posPtr in
                sk_shader_new_sweep_gradient(&skCenter, colorsPtr.baseAddress, posPtr.baseAddress, Int32(colors.count), tileMode.skShaderTileMode, startAngle, endAngle, &skLocalMatrix)
            }) ?? sk_shader_new_sweep_gradient(&skCenter, colorsPtr.baseAddress, nil, Int32(colors.count), tileMode.skShaderTileMode, startAngle, endAngle, &skLocalMatrix)
        }) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeSweepGradient(center: SkPoint, colors: [SkColor4f], colorspace: SkColorSpace?, colorPositions: [Float]?, tileMode: SkShaderTileMode, startAngle: Float, endAngle: Float, localMatrix: SkMatrix?) -> SkShader? {
        var skCenter = center.skPoint
        let skColors = colors.map { $0.skColor4f }
        var skColorspace: OpaquePointer? = colorspace?.handle
        var skLocalMatrix: sk_matrix_t? = localMatrix?.skMatrix

        guard let handle = skColors.withUnsafeBufferPointer({ colorsPtr in
            colorPositions?.withUnsafeBufferPointer({ posPtr in
                sk_shader_new_sweep_gradient_color4f(&skCenter, colorsPtr.baseAddress, skColorspace, posPtr.baseAddress, Int32(colors.count), tileMode.skShaderTileMode, startAngle, endAngle, &skLocalMatrix)
            }) ?? sk_shader_new_sweep_gradient_color4f(&skCenter, colorsPtr.baseAddress, skColorspace, nil, Int32(colors.count), tileMode.skShaderTileMode, startAngle, endAngle, &skLocalMatrix)
        }) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeTwoPointConicalGradient(start: SkPoint, startRadius: Float, end: SkPoint, endRadius: Float, colors: [SkColor], colorPositions: [Float]?, tileMode: SkShaderTileMode, localMatrix: SkMatrix?) -> SkShader? {
        var skStart = start.skPoint
        var skEnd = end.skPoint
        let skColors = colors.map { $0 }
        var skLocalMatrix: sk_matrix_t? = localMatrix?.skMatrix

        guard let handle = skColors.withUnsafeBufferPointer({ colorsPtr in
            colorPositions?.withUnsafeBufferPointer({ posPtr in
                sk_shader_new_two_point_conical_gradient(&skStart, startRadius, &skEnd, endRadius, colorsPtr.baseAddress, posPtr.baseAddress, Int32(colors.count), tileMode.skShaderTileMode, &skLocalMatrix)
            }) ?? sk_shader_new_two_point_conical_gradient(&skStart, startRadius, &skEnd, endRadius, colorsPtr.baseAddress, nil, Int32(colors.count), tileMode.skShaderTileMode, &skLocalMatrix)
        }) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makeTwoPointConicalGradient(start: SkPoint, startRadius: Float, end: SkPoint, endRadius: Float, colors: [SkColor4f], colorspace: SkColorSpace?, colorPositions: [Float]?, tileMode: SkShaderTileMode, localMatrix: SkMatrix?) -> SkShader? {
        var skStart = start.skPoint
        var skEnd = end.skPoint
        let skColors = colors.map { $0.skColor4f }
        var skColorspace: OpaquePointer? = colorspace?.handle
        var skLocalMatrix: sk_matrix_t? = localMatrix?.skMatrix

        guard let handle = skColors.withUnsafeBufferPointer({ colorsPtr in
            colorPositions?.withUnsafeBufferPointer({ posPtr in
                sk_shader_new_two_point_conical_gradient_color4f(&skStart, startRadius, &skEnd, endRadius, colorsPtr.baseAddress, skColorspace, posPtr.baseAddress, Int32(colors.count), tileMode.skShaderTileMode, &skLocalMatrix)
            }) ?? sk_shader_new_two_point_conical_gradient_color4f(&skStart, startRadius, &skEnd, endRadius, colorsPtr.baseAddress, skColorspace, nil, Int32(colors.count), tileMode.skShaderTileMode, &skLocalMatrix)
        }) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makePerlinNoiseFractalNoise(baseFrequencyX: Float, baseFrequencyY: Float, numOctaves: Int, seed: Float, tileSize: SkISize?) -> SkShader? {
        var skTileSize: sk_isize_t? = tileSize?.skISize
        guard let handle = sk_shader_new_perlin_noise_fractal_noise(baseFrequencyX, baseFrequencyY, Int32(numOctaves), seed, &skTileSize) else { return nil }
        return SkShader(handle: handle)
    }

    public static func makePerlinNoiseTurbulence(baseFrequencyX: Float, baseFrequencyY: Float, numOctaves: Int, seed: Float, tileSize: SkISize?) -> SkShader? {
        var skTileSize: sk_isize_t? = tileSize?.skISize
        guard let handle = sk_shader_new_perlin_noise_turbulence(baseFrequencyX, baseFrequencyY, Int32(numOctaves), seed, &skTileSize) else { return nil }
        return SkShader(handle: handle)
    }
}

public enum SkShaderTileMode: UInt32 {
    case clamp = 0
    case repeat = 1
    case mirror = 2
    case decal = 3

    public init(_ mode: sk_shader_tilemode_t) {
        self = SkShaderTileMode(rawValue: mode.rawValue)!
    }

    public var skShaderTileMode: sk_shader_tilemode_t {
        return sk_shader_tilemode_t(rawValue: self.rawValue)
    }
}