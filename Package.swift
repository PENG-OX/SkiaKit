// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-skia-demo",
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .systemLibrary(
            name: "CSkia",
            path: "Sources/CSkia/include",
            pkgConfig: nil,
            providers: nil
        ),
         .target(
            name: "skiakit",
            dependencies:["CSkia"],
            path:"Sources/skiakit",
            linkerSettings: [
                .linkedLibrary("SkiaSharp"),
                .unsafeFlags(["-L", "Sources/CSkia/lib"])
            ]
        ),
        .testTarget(
            name: "swift-skia-test",
            dependencies:["skiakit"],
            path:"Sources",
            sources:["Test.swift"]
        ),
        .executableTarget(
            name:"demo",
            dependencies:["skiakit"],
            path:"Sources",
            sources:["main.swift"]
        )
        
    ]
)
