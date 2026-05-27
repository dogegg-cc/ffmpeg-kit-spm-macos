// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "FFmpegKitSPM",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "FFmpegKit",
            targets: ["FFmpegKit"]
        ),
    ],
    targets: [
        // 核心包装 Target，封装了底层的 8 个二进制 XCFramework 依赖
        .target(
            name: "FFmpegKit",
            dependencies: [
                "ffmpegkit",
                "libavcodec",
                "libavdevice",
                "libavfilter",
                "libavformat",
                "libavutil",
                "libswresample",
                "libswscale"
            ],
            path: "Sources/FFmpegKit"
        ),
        // 底层二进制 xcframework Target 相对路径声明
        .binaryTarget(name: "ffmpegkit", path: "Frameworks/ffmpegkit.xcframework"),
        .binaryTarget(name: "libavcodec", path: "Frameworks/libavcodec.xcframework"),
        .binaryTarget(name: "libavdevice", path: "Frameworks/libavdevice.xcframework"),
        .binaryTarget(name: "libavfilter", path: "Frameworks/libavfilter.xcframework"),
        .binaryTarget(name: "libavformat", path: "Frameworks/libavformat.xcframework"),
        .binaryTarget(name: "libavutil", path: "Frameworks/libavutil.xcframework"),
        .binaryTarget(name: "libswresample", path: "Frameworks/libswresample.xcframework"),
        .binaryTarget(name: "libswscale", path: "Frameworks/libswscale.xcframework")
    ]
)
