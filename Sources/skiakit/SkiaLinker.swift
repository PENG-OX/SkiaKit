import Foundation
import CSkia

public class SkLinker {
    public static func keepAlive() {
        sk_linker_keep_alive()
    }
}