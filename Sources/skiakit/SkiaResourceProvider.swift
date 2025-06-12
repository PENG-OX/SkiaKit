import Foundation
import CSkia

public class SkottieResourceProvider: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }

    public func load(path: String, name: String) -> SkData? {
        let cPath = path.cString(using: .utf8)!
        let cName = name.cString(using: .utf8)!
        guard let dataHandle = cPath.withUnsafeBufferPointer({ pathPtr in
            cName.withUnsafeBufferPointer({ namePtr in
                skresources_resource_provider_load(handle, pathPtr.baseAddress, namePtr.baseAddress)
            })
        }) else { return nil }
        return SkData(handle: dataHandle)
    }

    public func loadImageAsset(path: String, name: String, id: String) -> SkottieImageAsset? {
        let cPath = path.cString(using: .utf8)!
        let cName = name.cString(using: .utf8)!
        let cId = id.cString(using: .utf8)!
        guard let assetHandle = cPath.withUnsafeBufferPointer({ pathPtr in
            cName.withUnsafeBufferPointer({ namePtr in
                cId.withUnsafeBufferPointer({ idPtr in
                    skresources_resource_provider_load_image_asset(handle, pathPtr.baseAddress, namePtr.baseAddress, idPtr.baseAddress)
                })
            })
        }) else { return nil }
        return SkottieImageAsset(handle: assetHandle)
    }

    public func loadAudioAsset(path: String, name: String, id: String) -> SkottieExternalTrackAsset? {
        let cPath = path.cString(using: .utf8)!
        let cName = name.cString(using: .utf8)!
        let cId = id.cString(using: .utf8)!
        guard let assetHandle = cPath.withUnsafeBufferPointer({ pathPtr in
            cName.withUnsafeBufferPointer({ namePtr in
                cId.withUnsafeBufferPointer({ idPtr in
                    skresources_resource_provider_load_audio_asset(handle, pathPtr.baseAddress, namePtr.baseAddress, idPtr.baseAddress)
                })
            })
        }) else { return nil }
        return SkottieExternalTrackAsset(handle: assetHandle)
    }

    public func loadTypeface(name: String, url: String) -> SkTypeface? {
        let cName = name.cString(using: .utf8)!
        let cUrl = url.cString(using: .utf8)!
        guard let typefaceHandle = cName.withUnsafeBufferPointer({ namePtr in
            cUrl.withUnsafeBufferPointer({ urlPtr in
                skresources_resource_provider_load_typeface(handle, namePtr.baseAddress, urlPtr.baseAddress)
            })
        }) else { return nil }
        return SkTypeface(handle: typefaceHandle)
    }

    public static func makeFileResourceProvider(baseDir: SkString, predecode: Bool) -> SkottieResourceProvider? {
        guard let handle = skresources_file_resource_provider_make(baseDir.handle, predecode) else { return nil }
        return SkottieResourceProvider(handle: handle)
    }

    public static func makeCachingResourceProviderProxy(resourceProvider: SkottieResourceProvider) -> SkottieResourceProvider? {
        guard let handle = skresources_caching_resource_provider_proxy_make(resourceProvider.handle) else { return nil }
        return SkottieResourceProvider(handle: handle)
    }

    public static func makeDataUriResourceProviderProxy(resourceProvider: SkottieResourceProvider, predecode: Bool) -> SkottieResourceProvider? {
        guard let handle = skresources_data_uri_resource_provider_proxy_make(resourceProvider.handle, predecode) else { return nil }
        return SkottieResourceProvider(handle: handle)
    }
}

public class SkottieImageAsset: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }
    // Placeholder for actual implementation
}

public class SkottieExternalTrackAsset: SkRefCnt {
    public override init(handle: OpaquePointer?) {
        super.init(handle: handle)
    }
    // Placeholder for actual implementation
}