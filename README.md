# SkiaKit for Swift

cpp skia -> c skia -> swift skia
动态库是从 nuget 下载的 microsoft mono维护的 c skia fork。
swift 绑定是用 gemini 2.5 生成的。
尚不可用，未调试。


swift 不能直接使用 c 的函数式宏 
这是一个实验性项目，旨在为 [Skia](https://skia.org/) 图形库创建一个现代、易用的 Swift 绑定。项目利用了 SkiaSharp 预编译的 C API，并通过 Swift 进行了封装，目标是让 Swift 开发者能够方便地使用 Skia 的强大功能。

> **注意:** 该项目目前处于早期开发阶段，API 可能会发生变化，功能尚不完整，仅供学习和探索使用。

## 项目架构

本项目的核心思想是通过 Swift Package Manager 将 C API、Swift 封装和动态库链接在一起。

```c
graph TD
    A[SkiaSharp 动态库 (.dll/.lib)] --> B{CSkia (C Target)};
    C[Skia C 头文件 (.h)] --> B;
    B --> D[SkiaKit (Swift Target)];
    D --> E[Demo App (Executable)];

    subgraph "C Interoperability Layer"
        B
        C
    end

    subgraph "Swift Layer"
        D
    end
    
    subgraph "Binary Dependency"
        A
    end
```

*   **`Sources/lib`**: 存放从 [SkiaSharp NuGet](https://www.nuget.org/packages/SkiaSharp.NativeAssets.Win32) 下载的预编译动态库 (`libSkiaSharp.dll`, `libSkiaSharp.lib`)。这些库导出了 Skia 的 C API。
*   **`Sources/include/skia`**: 存放与动态库版本相匹配的 Skia C API 头文件。
*   **`Sources/CSkia` (建议)**: 这是一个专门的 C Target，通过 `module.modulemap` 将 Skia 的 C 头文件组织成一个可供 Swift 导入的模块。它还负责通过链接器设置来链接 `libSkiaSharp` 动态库。
*   **`Sources/skiakit`**: 项目的核心，包含了所有 AI 生成的 Swift 代码。这些代码将 C API 封装成面向对象的 Swift 类和结构体，提供了更友好的接口。
*   **`Sources/main.swift`**: 一个简单的可执行目标，用于演示和测试 `SkiaKit` 的功能。

## 特点

*   **现代 Swift 封装**: 提供面向对象的 API，隐藏了 C API 的复杂性。
*   **跨平台潜力**: 基于 Skia 和 .NET 的 SkiaSharp，理论上可以扩展到 Windows, Linux, macOS, iOS 和 Android。
*   **AI辅助生成**: Swift 绑定代码主要由 AI（Gemini 2.5）生成，展示了 AI 在跨语言开发中的应用潜力。
*   **SwiftPM 集成**: 使用 Swift Package Manager 进行构建和依赖管理，易于集成到其他 Swift 项目中。

## 如何构建

1.  确保您已安装 Swift 6.1.2 或更高版本的工具链。
2.  在项目根目录下运行：
    ```bash
    swift build
    ```
3.  运行 Demo 程序：
    ```bash
    swift run swift-skia-demo
    ```

## 当前状态

*   [ ] C API 链接和调用
*   [ ] Swift 封装层实现
*   [ ] 基础绘图功能测试
*   [ ] 完善文档和示例

项目正在积极开发中，欢迎贡献和反馈。
