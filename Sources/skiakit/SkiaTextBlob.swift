import Foundation
import CSkia

public class SkTextBlob: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public var bounds: SkRect {
        var rect = sk_rect_t()
        sk_textblob_get_bounds(handle, &rect)
        return SkRect(rect)
    }

    public var uniqueId: UInt32 {
        return sk_textblob_get_unique_id(handle)
    }

    public static func makeFromText(text: String, font: SkFont, encoding: SkTextEncoding) -> SkTextBlob? {
        let utf8 = text.utf8CString
        guard let handle = utf8.withUnsafeBufferPointer({ ptr in
            sk_textblob_create_from_text(ptr.baseAddress, ptr.count - 1, font.handle, encoding.skTextEncoding)
        }) else { return nil }
        return SkTextBlob(handle: handle)
    }

    public static func makeFromPosText(text: String, positions: [SkPoint], font: SkFont, encoding: SkTextEncoding) -> SkTextBlob? {
        let utf8 = text.utf8CString
        let skPositions = positions.map { $0.skPoint }
        guard let handle = utf8.withUnsafeBufferPointer({ textPtr in
            skPositions.withUnsafeBufferPointer({ posPtr in
                sk_textblob_create_from_pos_text(textPtr.baseAddress, textPtr.count - 1, posPtr.baseAddress, font.handle, encoding.skTextEncoding)
            })
        }) else { return nil }
        return SkTextBlob(handle: handle)
    }

    public static func makeFromPosTextH(text: String, xpos: [Float], y: Float, font: SkFont, encoding: SkTextEncoding) -> SkTextBlob? {
        let utf8 = text.utf8CString
        let skXpos = xpos.map { $0 }
        guard let handle = utf8.withUnsafeBufferPointer({ textPtr in
            skXpos.withUnsafeBufferPointer({ xposPtr in
                sk_textblob_create_from_pos_text_h(textPtr.baseAddress, textPtr.count - 1, xposPtr.baseAddress, y, font.handle, encoding.skTextEncoding)
            })
        }) else { return nil }
        return SkTextBlob(handle: handle)
    }

    public static func makeFromRSXform(text: String, xforms: [SkRSXform], font: SkFont, encoding: SkTextEncoding) -> SkTextBlob? {
        let utf8 = text.utf8CString
        let skXforms = xforms.map { $0.skRSXform }
        guard let handle = utf8.withUnsafeBufferPointer({ textPtr in
            skXforms.withUnsafeBufferPointer({ xformsPtr in
                sk_textblob_create_from_rsxform(textPtr.baseAddress, textPtr.count - 1, xformsPtr.baseAddress, font.handle, encoding.skTextEncoding)
            })
        }) else { return nil }
        return SkTextBlob(handle: handle)
    }

    public static func makeFromRSXform(text: String, xforms: [SkRSXform], font: SkFont, encoding: SkTextEncoding, bounds: SkRect) -> SkTextBlob? {
        let utf8 = text.utf8CString
        let skXforms = xforms.map { $0.skRSXform }
        var skBounds = bounds.skRect
        guard let handle = utf8.withUnsafeBufferPointer({ textPtr in
            skXforms.withUnsafeBufferPointer({ xformsPtr in
                sk_textblob_create_from_rsxform_with_bounds(textPtr.baseAddress, textPtr.count - 1, xformsPtr.baseAddress, font.handle, encoding.skTextEncoding, &skBounds)
            })
        }) else { return nil }
        return SkTextBlob(handle: handle)
    }
}