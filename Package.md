# Swift Package Manager 配置指南 (`Package.swift`)

本文档旨在提供一份关于 `Package.swift` 文件配置的详细指南，帮助您理解和构建复杂的 Swift 项目，特别是那些涉及多目标、C/C++ 互操作性和预编译二进制依赖的项目。

## 1. 针对当前 SkiaKit 项目的推荐配置

根据您项目的结构，一个清晰、模块化的 `Package.swift` 配置如下所示。这个配置将 C 语言部分和 Swift 封装部分分离到不同的 Target 中，使得结构更清晰，更容易维护。

```swift
// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "SkiaKit",
    platforms: [
        .macOS(.v10_15) // 明确指定支持的平台
    ],
    products: [
        // 定义一个名为 SkiaKit 的库，其他项目可以引用它
        .library(
            name: "SkiaKit",
            targets: ["SkiaKit"]),
    ],
    targets: [
        // CSkia Target: 负责封装 C API 和链接动态库
        .target(
            name: "CSkia",
            dependencies: [],
            path: "Sources/CSkia", // 建议为 C 代码创建独立目录
            publicHeadersPath: "include",
            cSettings: [
                // 让编译器能找到 skia 的头文件
                .headerSearchPath("../../include"),
            ],
            linkerSettings: [
                // 链接 SkiaSharp 动态库
                .linkedLibrary("SkiaSharp"),
                // 指定动态库的搜索路径
                .unsafeFlags(["-L", "Sources/lib"])
            ]
        ),

        // SkiaKit Target: Swift 封装层
        .target(
            name: "SkiaKit",
            dependencies: ["CSkia"], // 依赖 CSkia 来调用 C API
            path: "Sources/skiakit"
        ),

        // Demo App Target: 用于测试和演示
        .executableTarget(
            name: "swift-skia-demo",
            dependencies: ["SkiaKit"],
            path: "Sources",
            sources: ["main.swift"] // 明确指定源文件，避免包含其他 Target 的代码
        )
    ]
)
```

**为了使上述配置生效，您需要做如下文件结构调整：**

1.  在 `Sources/` 目录下创建一个新目录 `CSkia`。
2.  在 `Sources/CSkia/` 目录下创建一个 `include` 目录。
3.  将 `Sources/skiakit/module.modulemap` 和 `Sources/skiakit/SkiaBridge.h` 移动到 `Sources/CSkia/include/`。
4.  在 `Sources/CSkia/` 目录下创建一个空的 C 文件，例如 `CSkia.c`，以确保 SwiftPM 将其识别为一个 C Target。

---

## 2. `Package.swift` 核心概念详解

`Package.swift` 使用 Swift 语言本身来定义包的配置，这种方式被称为“清单文件”（Manifest）。

### 2.1 `Package`

`Package` 是配置的根对象，它包含了包的所有信息。

*   `name`: (String) 包的名称。
*   `platforms`: ([Platform]) (可选) 指定包支持的最低平台版本，如 `.macOS(.v12)`、`.iOS(.v15)`。这有助于编译器检查 API 可用性。
*   `products`: ([Product]) 定义了包构建后生成的产物，可以被其他包依赖。
*   `dependencies`: ([Package.Dependency]) (可选) 声明对其他 Swift 包的依赖。
*   `targets`: ([Target]) 定义了组成包的各个模块。

### 2.2 `products` (产物)

产物是包的最终输出。

*   `.library(name: String, type: Library.LibraryType? = nil, targets: [String])`: 定义一个库。
    *   `name`: 库的名称，其他包通过这个名字来引用。
    *   `type`: (可选) 库的类型，可以是 `.static` 或 `.dynamic`。默认为自动选择。
    *   `targets`: 组成这个库的 Target 名称数组。
*   `.executable(name: String, targets: [String])`: 定义一个可执行文件。

### 2.3 `targets` (目标)

Target 是代码的基本组织单元，可以是一个模块或一个测试套件。

*   `.target(...)`: 定义一个常规的模块。
*   `.executableTarget(...)`: 定义一个可执行模块（会生成一个可执行文件）。
*   `.testTarget(...)`: 定义一个测试套件。
*   `.systemLibrary(...)`: 用于包装系统提供的库，但对于您的情况，使用常规 `.target` 配合链接器设置更灵活。

#### Target 的常用参数

*   `name`: (String) Target 的名称。
*   `dependencies`: 依赖关系。可以是同一个包中的其他 Target，也可以是外部包的产物。
    *   `.target(name: "MyOtherTarget")`: 依赖同包中的另一个 Target。
    *   `.product(name: "Alamofire", package: "Alamofire")`: 依赖外部包的产物。
*   `path`: (String) (可选) 指定 Target 源文件的根目录，相对于包的根目录。默认为 `Sources/<TargetName>`。
*   `sources`: ([String]) (可选) 明确指定 Target 包含的源文件或子目录，路径相对于 `path`。
*   `publicHeadersPath`: (String) (可选) 对于 C/C++/Objective-C Target，指定哪个目录下的头文件可以被依赖它的其他 Target 访问。
*   `cSettings`, `cxxSettings`, `swiftSettings`: ([Setting]) (可选) 为不同语言指定特定的构建设置。
*   `linkerSettings`: ([LinkerSetting]) (可选) 指定链接器设置。

### 2.4 构建设置 (`cSettings`, `linkerSettings`, etc.)

这是处理混合语言和二进制依赖的关键。

*   `.headerSearchPath(String)`: (C/C++) 添加一个头文件搜索路径。编译器会在这里寻找 `#include <...>` 的文件。
*   `.define(String, to: String? = nil)`: (C/C++/Swift) 定义一个预处理宏，等同于 C/C++ 中的 `#define` 或 Swift 中的 `-D` 标志。
*   `.linkedLibrary(String)`: (Linker) 链接一个库。例如，`"z"` 会链接 `libz.dylib`。
*   `.linkedFramework(String)`: (Linker) 链接一个 macOS/iOS 框架。
*   `.unsafeFlags([String])`: **(慎用)** 传递任意标志给编译器或链接器。这很强大但也可能导致配置变得脆弱。
    *   `-L <path>`: (链接器) 添加一个库搜索路径。
    *   `-F <path>`: (链接器) 添加一个框架搜索路径。

## 3. 常见场景示例

### 场景一：纯 Swift 库和可执行文件

这是最简单的场景，一个 App 依赖一个本地模块。

```swift
let package = Package(
    name: "MyApp",
    products: [
        .executable(name: "my-app", targets: ["MyApp"]),
        .library(name: "MyLibrary", targets: ["MyLibrary"]),
    ],
    targets: [
        .executableTarget(
            name: "MyApp",
            dependencies: ["MyLibrary"]
        ),
        .target(
            name: "MyLibrary",
            dependencies: []
        ),
    ]
)
```

### 场景二：包装一个 C 库 (如您的 SkiaKit)

这是处理 C/Swift 混合项目的经典模式。

1.  **C-Target (`CSkia`)**:
    *   使用 `module.modulemap` 将所有 C 头文件聚合到一个模块中。
    *   使用 `publicHeadersPath` 暴露这个 `module.modulemap`。
    *   使用 `cSettings` 的 `.headerSearchPath` 告诉编译器去哪里找真正的 `.h` 文件。
    *   使用 `linkerSettings` 的 `.linkedLibrary` 和 `.unsafeFlags(["-L", ...])` 来链接预编译的二进制库。
2.  **Swift-Target (`SkiaKit`)**:
    *   依赖于 C-Target (`dependencies: ["CSkia"]`)。
    *   在 Swift 代码中 `import CSkia` 即可调用 C 函数和使用 C 类型。

### 场景三：依赖外部开源库

```swift
let package = Package(
    name: "MyNetworkApp",
    dependencies: [
        // 声明对 Alamofire 包的依赖
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.1"),
    ],
    targets: [
        .executableTarget(
            name: "MyNetworkApp",
            dependencies: [
                // 在 Target 中使用 Alamofire 产物
                .product(name: "Alamofire", package: "Alamofire")
            ]
        ),
    ]
)
```

希望这份文档能帮助您更好地掌握 Swift Package Manager！