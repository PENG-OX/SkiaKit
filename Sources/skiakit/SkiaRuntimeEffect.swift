import Foundation
import Skia

public class SkRuntimeEffect: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public static func makeForColorFilter(sksl: String) -> (effect: SkRuntimeEffect?, error: SkString?) {
        let skslString = SkString(string: sksl)
        let errorString = SkString()
        guard let handle = sk_runtimeeffect_make_for_color_filter(skslString.handle, errorString.handle) else {
            return (nil, errorString.count > 0 ? errorString : nil)
        }
        return (SkRuntimeEffect(handle: handle), nil)
    }

    public static func makeForShader(sksl: String) -> (effect: SkRuntimeEffect?, error: SkString?) {
        let skslString = SkString(string: sksl)
        let errorString = SkString()
        guard let handle = sk_runtimeeffect_make_for_shader(skslString.handle, errorString.handle) else {
            return (nil, errorString.count > 0 ? errorString : nil)
        }
        return (SkRuntimeEffect(handle: handle), nil)
    }

    public static func makeForBlender(sksl: String) -> (effect: SkRuntimeEffect?, error: SkString?) {
        let skslString = SkString(string: sksl)
        let errorString = SkString()
        guard let handle = sk_runtimeeffect_make_for_blender(skslString.handle, errorString.handle) else {
            return (nil, errorString.count > 0 ? errorString : nil)
        }
        return (SkRuntimeEffect(handle: handle), nil)
    }

    public func makeShader(uniforms: SkData, children: [SkFlattenable], localMatrix: SkMatrix?) -> SkShader? {
        let cChildren = children.map { $0.handle }
        var skLocalMatrix: sk_matrix_t? = localMatrix?.skMatrix
        guard let shaderHandle = cChildren.withUnsafeBufferPointer({ ptr in
            sk_runtimeeffect_make_shader(handle, uniforms.handle, ptr.baseAddress, ptr.count, &skLocalMatrix)
        }) else { return nil }
        return SkShader(handle: shaderHandle)
    }

    public func makeColorFilter(uniforms: SkData, children: [SkFlattenable]) -> SkColorFilter? {
        let cChildren = children.map { $0.handle }
        guard let colorFilterHandle = cChildren.withUnsafeBufferPointer({ ptr in
            sk_runtimeeffect_make_color_filter(handle, uniforms.handle, ptr.baseAddress, ptr.count)
        }) else { return nil }
        return SkColorFilter(handle: colorFilterHandle)
    }

    public func makeBlender(uniforms: SkData, children: [SkFlattenable]) -> SkBlender? {
        let cChildren = children.map { $0.handle }
        guard let blenderHandle = cChildren.withUnsafeBufferPointer({ ptr in
            sk_runtimeeffect_make_blender(handle, uniforms.handle, ptr.baseAddress, ptr.count)
        }) else { return nil }
        return SkBlender(handle: blenderHandle)
    }

    public var uniformByteSize: Int {
        return Int(sk_runtimeeffect_get_uniform_byte_size(handle))
    }

    public var uniformsSize: Int {
        return Int(sk_runtimeeffect_get_uniforms_size(handle))
    }

    public func getUniformName(index: Int) -> SkString {
        let skString = SkString()
        sk_runtimeeffect_get_uniform_name(handle, Int32(index), skString.handle)
        return skString
    }

    public func getUniform(index: Int) -> SkRuntimeEffectUniform {
        var uniform = sk_runtimeeffect_uniform_t()
        sk_runtimeeffect_get_uniform_from_index(handle, Int32(index), &uniform)
        return SkRuntimeEffectUniform(uniform)
    }

    public func getUniform(name: String) -> SkRuntimeEffectUniform? {
        let cName = name.cString(using: .utf8)!
        var uniform = sk_runtimeeffect_uniform_t()
        let found = cName.withUnsafeBufferPointer { ptr in
            sk_runtimeeffect_get_uniform_from_name(handle, ptr.baseAddress, ptr.count - 1, &uniform)
        }
        return found ? SkRuntimeEffectUniform(uniform) : nil
    }

    public var childrenSize: Int {
        return Int(sk_runtimeeffect_get_children_size(handle))
    }

    public func getChildName(index: Int) -> SkString {
        let skString = SkString()
        sk_runtimeeffect_get_child_name(handle, Int32(index), skString.handle)
        return skString
    }

    public func getChild(index: Int) -> SkRuntimeEffectChild {
        var child = sk_runtimeeffect_child_t()
        sk_runtimeeffect_get_child_from_index(handle, Int32(index), &child)
        return SkRuntimeEffectChild(child)
    }

    public func getChild(name: String) -> SkRuntimeEffectChild? {
        let cName = name.cString(using: .utf8)!
        var child = sk_runtimeeffect_child_t()
        let found = cName.withUnsafeBufferPointer { ptr in
            sk_runtimeeffect_get_child_from_name(handle, ptr.baseAddress, ptr.count - 1, &child)
        }
        return found ? SkRuntimeEffectChild(child) : nil
    }
}

public class SkFlattenable {
    public var handle: OpaquePointer?
    // Placeholder for actual implementation
    public init(handle: OpaquePointer?) { self.handle = handle }
}

public struct SkRuntimeEffectUniform {
    public var name: String
    public var offset: Int
    public var type: SkRuntimeEffectUniformType
    public var count: Int
    public var flags: SkRuntimeEffectUniformFlags

    public init(_ uniform: sk_runtimeeffect_uniform_t) {
        self.name = String(cString: uniform.fName)
        self.offset = Int(uniform.fOffset)
        self.type = SkRuntimeEffectUniformType(uniform.fType)
        self.count = Int(uniform.fCount)
        self.flags = SkRuntimeEffectUniformFlags(rawValue: uniform.fFlags)
    }
}

public enum SkRuntimeEffectUniformType: UInt32 {
    case kFloat = 0
    case kFloat2 = 1
    case kFloat3 = 2
    case kFloat4 = 3
    case kFloat2x2 = 4
    case kFloat3x3 = 5
    case kFloat4x4 = 6
    case kInt = 7
    case kInt2 = 8
    case kInt3 = 9
    case kInt4 = 10
    case kHalf = 11
    case kHalf2 = 12
    case kHalf3 = 13
    case kHalf4 = 14
    case kHalf2x2 = 15
    case kHalf3x3 = 16
    case kHalf4x4 = 17
    case kBool = 18
    case kBool2 = 19
    case kBool3 = 20
    case kBool4 = 21

    public init(_ type: sk_runtimeeffect_uniform_type_t) {
        self = SkRuntimeEffectUniformType(rawValue: type.rawValue)!
    }
}

public struct SkRuntimeEffectUniformFlags: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let kArray = SkRuntimeEffectUniformFlags(rawValue: SK_RUNTIME_EFFECT_UNIFORM_FLAGS_ARRAY.rawValue)
    public static let kColor = SkRuntimeEffectUniformFlags(rawValue: SK_RUNTIME_EFFECT_UNIFORM_FLAGS_COLOR.rawValue)
    public static let kSRGB2Linear = SkRuntimeEffectUniformFlags(rawValue: SK_RUNTIME_EFFECT_UNIFORM_FLAGS_SRGB_2_LINEAR.rawValue)
    public static let kLinear2SRGB = SkRuntimeEffectUniformFlags(rawValue: SK_RUNTIME_EFFECT_UNIFORM_FLAGS_LINEAR_2_SRGB.rawValue)
}

public struct SkRuntimeEffectChild {
    public var name: String
    public var index: Int
    public var type: SkRuntimeEffectChildType

    public init(_ child: sk_runtimeeffect_child_t) {
        self.name = String(cString: child.fName)
        self.index = Int(child.fIndex)
        self.type = SkRuntimeEffectChildType(child.fType)
    }
}

public enum SkRuntimeEffectChildType: UInt32 {
    case kShader = 0
    case kColorFilter = 1
    case kBlender = 2

    public init(_ type: sk_runtimeeffect_child_type_t) {
        self = SkRuntimeEffectChildType(rawValue: type.rawValue)!
    }
}