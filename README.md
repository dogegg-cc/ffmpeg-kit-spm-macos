# FFmpegKit macOS SPM (Apple Silicon arm64)

专为 **macOS (Apple Silicon M系列芯片)** 平台量身定制的 `FFmpegKit` Swift Package Manager (SPM) 极速集成维护包。

---

## 🚀 核心特性

- **硬件架构**：仅编译并完美适配 Apple Silicon 芯片 (`arm64` 单架构)，大幅精简了最终包体积。
- **协议支持**：核心集成 `OpenSSL` 第三方依赖，完美支持所有 `https://` 加密协议的网络音视频串流播放。
- **授权协议**：严格遵循 **非 GPL 许可** 规范，商业项目集成友好。
- **高阶封装**：采用业界领先的保护伞 Target 封装设计，将底层 8 个复杂的子库 `.xcframework` 融为一体。在宿主项目中只需引入唯一 Product `FFmpegKit` 即可实现全量二进制库的自动链入。

---

## 📂 包含的 XCFramework 套件

本包已安全集成以下核心二进制子框架：
1. `ffmpegkit.xcframework` (核心封装)
2. `libavcodec.xcframework` (音视频编解码核心)
3. `libavdevice.xcframework` (输入输出设备)
4. `libavfilter.xcframework` (音视频滤镜)
5. `libavformat.xcframework` (多媒体封装与网络协议传输，支持 HTTPS)
6. `libavutil.xcframework` (通用基础工具)
7. `libswresample.xcframework` (音频重采样)
8. `libswscale.xcframework` (图像色彩及尺寸转换)

---

## 🛠 一键集成指南

### 1. 本地 Swift Package 引入方式
1. 打开您的 Xcode 项目（如 `JJPlayer`）。
2. 在顶部菜单栏中，依次选择 **File -> Add Packages...**。
3. 在弹出的包管理窗口左下角，点击 **Add Local...** 按钮。
4. 选中当前 `ffmpeg-kit-spm-macos` 文件夹并点击确认。
5. 将暴露的 `FFmpegKit` library 勾选添加到您播放器主 Target 的依赖项中。

### 2. 远程 Git 仓库分发方式
如果您已将此项目推送到私有 Git 仓库，可直接使用 Git URL 进行远程依赖注入：
1. 选择 **File -> Add Packages...**。
2. 在右上角的搜索框中输入您的 Git 仓库地址（例如 `git@github.com:your-username/ffmpeg-kit-spm-macos.git`）。
3. Dependency Rule 建议选择 `Branch` (如 `main`)，然后点击 **Add Package**。

---

## 📝 Swift 极速调用示例

引入包并添加到主 Target 后，即可在 Swift 代码中轻松导入并调用 FFmpeg API。

```swift
import Foundation
import ffmpegkit

func initializePlayer() {
    // 1. 验证 FFmpegKit 引擎是否正常工作
    let ffmpegVersion = FFmpegKitConfig.getFFmpegVersion()
    print("🎬 FFmpegKit macOS 引擎就绪！核心版本：\(ffmpegVersion ?? "未知")")
    
    // 2. 异步执行一段 FFmpeg 多媒体分析或转码指令
    let inputUrl = "https://www.w3school.com.cn/example/html5/mov_bbb.mp4" // HTTPS 支持测试
    let outputPath = "/Users/jiao/Desktop/test_output.gif"
    
    let ffmpegCmd = "-ss 00:00:00 -t 5 -i \(inputUrl) -s 320x180 -f gif \(outputPath)"
    
    FFmpegKit.executeAsync(ffmpegCmd) { session in
        guard let session = session else { return }
        let state = session.getState()
        let returnCode = session.getReturnCode()
        
        if ReturnCode.isSuccess(returnCode) {
            print("✅ 截取视频前 5 秒并生成 GIF 成功！路径：\(outputPath)")
        } else {
            print("❌ 执行失败，State: \(state), Code: \(String(describing: returnCode))")
        }
    }
}
```

---

## ⚙️ 后续维护与版本更新

若您后续通过 `macos.sh` 构建了新版 FFmpeg 库：
1. 清空 `Frameworks/` 目录下的旧 `.xcframework` 文件夹。
2. 将最新编译的产物拷贝至 `Frameworks/` 目录下。
3. 提交 Git 变更即可：
   ```bash
   git add .
   git commit -m "Upgrade xcframeworks to new version"
   ```
