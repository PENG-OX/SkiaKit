import Foundation
import Skia

public class SkTypeface: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public static func makeDefault() -> SkTypeface? {
        guard let handle = sk_typeface_ref_default() else { return nil }
        return SkTypeface(handle: handle)
    }

    public static func fromFile(path: String, index: Int) -> SkTypeface? {
        let cPath = path.cString(using: .utf8)!
        guard let handle = cPath.withUnsafeBufferPointer({ ptr in
            sk_typeface_create_from_file(ptr.baseAddress, Int32(index))
        }) else { return nil }
        return SkTypeface(handle: handle)
    }

    public static func fromData(data: SkData, index: Int) -> SkTypeface? {
        guard let handle = sk_typeface_create_from_data(data.handle, Int32(index)) else { return nil }
        return SkTypeface(handle: handle)
    }

    public static func fromStream(stream: SkStream, index: Int) -> SkTypeface? {
        guard let handle = sk_typeface_create_from_stream(stream.handle, Int32(index)) else { return nil }
        return SkTypeface(handle: handle)
    }

    public static func fromName(familyName: String?, fontStyle: SkFontStyle) -> SkTypeface? {
        let cFamilyName = familyName?.cString(using: .utf8)
        var skFontStyle = fontStyle.skFontStyle
        guard let handle = cFamilyName?.withUnsafeBufferPointer({ ptr in
            sk_typeface_create_from_name(ptr.baseAddress, &skFontStyle)
        }) ?? sk_typeface_create_from_name(nil, &skFontStyle) else { return nil }
        return SkTypeface(handle: handle)
    }

    public var uniqueId: UInt32 {
        return sk_typeface_get_unique_id(handle)
    }

    public var fontStyle: SkFontStyle {
        var style = sk_fontstyle_t()
        sk_typeface_get_fontstyle(handle, &style)
        return SkFontStyle(style)
    }

    public var isFixedPitch: Bool {
        return sk_typeface_is_fixed_pitch(handle)
    }

    public var familyName: SkString {
        let skString = SkString()
        sk_typeface_get_family_name(handle, skString.handle)
        return skString
    }

    public var glyphCount: Int {
        return Int(sk_typeface_get_glyph_count(handle))
    }

    public var unitsPerEm: Int {
        return Int(sk_typeface_get_units_per_em(handle))
    }

    public func getKerningPairAdjustments(glyphs: [UInt16], adjustments: inout [Int32]) -> Int {
        let count = Int(sk_typeface_get_kerning_pair_adjustments(handle, glyphs, Int32(glyphs.count), &adjustments))
        adjustments = Array(adjustments.prefix(count))
        return count
    }

    public func getGlyphWidths(glyphs: [UInt16], widths: inout [Float], paint: SkPaint?) -> Int {
        let count = Int(sk_typeface_get_glyph_widths(handle, glyphs, Int32(glyphs.count), &widths, paint?.handle))
        widths = Array(widths.prefix(count))
        return count
    }

    public func getGlyphPaths(glyphs: [UInt16], paths: inout [SkPath]) {
        let cPaths = paths.map { $0.handle }
        glyphs.withUnsafeBufferPointer { glyphPtr in
            cPaths.withUnsafeBufferPointer { pathPtr in
                sk_typeface_get_glyph_paths(handle, glyphPtr.baseAddress, Int32(glyphs.count), pathPtr.baseAddress)
            }
        }
    }

    public func getGlyphBounds(glyphs: [UInt16], bounds: inout [SkRect], paint: SkPaint?) -> Int {
        let skBounds = bounds.map { $0.skRect }
        let count = Int(sk_typeface_get_glyph_bounds(handle, glyphs, Int32(glyphs.count), UnsafeMutablePointer(mutating: skBounds), paint?.handle))
        bounds = skBounds.prefix(count).map { SkRect($0) }
        return count
    }

    public func getGlyphIntercepts(glyphs: [UInt16], x: Float, y: Float, paint: SkPaint?) -> [Float] {
        var intercepts = [Float](repeating: 0.0, count: glyphs.count)
        let count = Int(sk_typeface_get_glyph_intercepts(handle, glyphs, Int32(glyphs.count), x, y, &intercepts, paint?.handle))
        return Array(intercepts.prefix(count))
    }

    public func charsToGlyphs(text: String, encoding: SkTextEncoding, glyphs: inout [UInt16]) -> Int {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            let count = Int(sk_typeface_chars_to_glyphs(handle, encoding.skTextEncoding, ptr.baseAddress, ptr.count - 1, &glyphs, Int32(glyphs.count)))
            glyphs = Array(glyphs.prefix(count))
            return count
        }
    }

    public func countCharsToGlyphs(text: String, encoding: SkTextEncoding) -> Int {
        let utf8 = text.utf8CString
        return utf8.withUnsafeBufferPointer { ptr in
            Int(sk_typeface_count_chars_to_glyphs(handle, encoding.skTextEncoding, ptr.baseAddress, ptr.count - 1))
        }
    }
}

public struct SkFontStyle {
    public var weight: Int
    public var width: Int
    public var slant: SkFontSlant

    public init(weight: Int, width: Int, slant: SkFontSlant) {
        self.weight = weight
        self.width = width
        self.slant = slant
    }

    public init(_ style: sk_fontstyle_t) {
        self.weight = Int(style.fWeight)
        self.width = Int(style.fWidth)
        self.slant = SkFontSlant(style.fSlant)
    }

    public var skFontStyle: sk_fontstyle_t {
        return sk_fontstyle_t(
            fWeight: Int32(weight),
            fWidth: Int32(width),
            fSlant: slant.skFontSlant
        )
    }

    public static var normal: SkFontStyle {
        return SkFontStyle(sk_fontstyle_get_normal())
    }

    public static var bold: SkFontStyle {
        return SkFontStyle(sk_fontstyle_get_bold())
    }

    public static var italic: SkFontStyle {
        return SkFontStyle(sk_fontstyle_get_italic())
    }

    public static var boldItalic: SkFontStyle {
        return SkFontStyle(sk_fontstyle_get_bold_italic())
    }
}

public enum SkFontSlant: UInt32 {
    case upright = 0
    case italic = 1
    case oblique = 2

    public init(_ slant: sk_font_slant_t) {
        self = SkFontSlant(rawValue: slant.rawValue)!
    }

    public var skFontSlant: sk_font_slant_t {
        return sk_font_slant_t(rawValue: self.rawValue)
    }
}

public enum SkFontWeight: Int32 {
    case invisible = 0
    case thin = 100
    case extraLight = 200
    case light = 300
    case normal = 400
    case medium = 500
    case semiBold = 600
    case bold = 700
    case extraBold = 800
    case black = 900
    case extraBlack = 1000
}

public enum SkFontWidth: Int32 {
    case ultraCondensed = 1
    case extraCondensed = 2
    case condensed = 3
    case semiCondensed = 4
    case normal = 5
    case semiExpanded = 6
    case expanded = 7
    case extraExpanded = 8
    case ultraExpanded = 9
}