import Foundation
import CSkia

public class SkSVGCanvas {
    public static func create(bounds: SkRect, stream: SkWStream) -> SkCanvas? {
        var skBounds = bounds.skRect
        guard let handle = sk_svgcanvas_create_with_stream(&skBounds, stream.handle) else { return nil }
        return SkCanvas(handle: handle)
    }
}