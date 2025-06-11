import Foundation
import Skia

public class SkLinker {
    public static func keepAlive() {
        sk_linker_keep_alive()
    }
}