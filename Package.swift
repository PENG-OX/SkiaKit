// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-skia-demo",
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "swift-skia-demo",
            dependencies: ["SkiaKit"],
            path: "Sources", // 指定源文件路径为 Sources
            linkerSettings: [
                .linkedLibrary("SkiaSharp"),
                .unsafeFlags(["-L", "Sources/lib"])
            ]
        ),
        .target(
            name: "SkiaKit",
            dependencies: ["CSkia"],
            path: "Sources/skiakit",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("../include/skia")
            ]
        ),
        .target(
            name: "CSkia",
            sources: ["skiakit/SkiaWindow.c"],
            publicHeadersPath: "skiakit",
            cSettings: [
                .headerSearchPath("include/skia")
            ]
        )
    ]
)
