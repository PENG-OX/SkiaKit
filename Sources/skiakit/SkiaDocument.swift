import Foundation
import Skia

public class SkDocument: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public static func makePdf(stream: SkWStream) -> SkDocument? {
        guard let handle = sk_document_create_pdf_from_stream(stream.handle) else { return nil }
        return SkDocument(handle: handle)
    }

    public static func makePdf(stream: SkWStream, metadata: SkDocumentPdfMetadata) -> SkDocument? {
        var skMetadata = metadata.skDocumentPdfMetadata
        guard let handle = sk_document_create_pdf_from_stream_with_metadata(stream.handle, &skMetadata) else { return nil }
        return SkDocument(handle: handle)
    }

    public static func makeXps(stream: SkWStream, dpi: Float) -> SkDocument? {
        guard let handle = sk_document_create_xps_from_stream(stream.handle, dpi) else { return nil }
        return SkDocument(handle: handle)
    }

    public func beginPage(width: Float, height: Float, content: SkRect?) -> SkCanvas? {
        var skContent: sk_rect_t? = content?.skRect
        guard let canvasHandle = sk_document_begin_page(handle, width, height, &skContent) else { return nil }
        return SkCanvas(handle: canvasHandle)
    }

    public func endPage() {
        sk_document_end_page(handle)
    }

    public func close() {
        sk_document_close(handle)
    }

    public func abort() {
        sk_document_abort(handle)
    }
}

public struct SkDocumentPdfMetadata {
    public var title: SkString?
    public var author: SkString?
    public var subject: SkString?
    public var keywords: SkString?
    public var creator: SkString?
    public var producer: SkString?
    public var creation: Int64
    public var modified: Int64
    public var rasterDPI: Float
    public var pdfA: Bool
    public var encodingQuality: Int

    public init(title: SkString? = nil, author: SkString? = nil, subject: SkString? = nil, keywords: SkString? = nil, creator: SkString? = nil, producer: SkString? = nil, creation: Int64 = 0, modified: Int64 = 0, rasterDPI: Float = 0, pdfA: Bool = false, encodingQuality: Int = 100) {
        self.title = title
        self.author = author
        self.subject = subject
        self.keywords = keywords
        self.creator = creator
        self.producer = producer
        self.creation = creation
        self.modified = modified
        self.rasterDPI = rasterDPI
        self.pdfA = pdfA
        self.encodingQuality = encodingQuality
    }

    public var skDocumentPdfMetadata: sk_document_pdf_metadata_t {
        return sk_document_pdf_metadata_t(
            fTitle: title?.handle,
            fAuthor: author?.handle,
            fSubject: subject?.handle,
            fKeywords: keywords?.handle,
            fCreator: creator?.handle,
            fProducer: producer?.handle,
            fCreation: creation,
            fModified: modified,
            fRasterDPI: rasterDPI,
            fPdfA: pdfA,
            fEncodingQuality: Int32(encodingQuality)
        )
    }
}