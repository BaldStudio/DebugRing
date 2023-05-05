# DebugRing
调试工具合集

[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/BaldStudio/DebugRing/master/LICENSE)
![iOS 13.0+](https://img.shields.io/badge/iOS-13.0%2B-blue.svg)

## 安装

## Cocoapods

在 Podfile 中添加依赖：
```
pod 'DebugRing', :configurations => ['Debug']
```
然后执行 `pod install`

## 自定义插件

### 无需新开页面
```
final class FlexPlugin: DebugPlugin {
    
    let name = "FLEX"
    let icon = UIImage(debug: "flex")
    let instruction = "FLEX工具的开关"
    
    func onDidSelect() {
        FLEXManager.shared.toggleExplorer()
        
        if FLEXManager.shared.isHidden {
            logger.info("FLEX 【已关闭】")
        }
        else {
            logger.info("FLEX 【已启用】")
        }
    }
}
```

### 需要新开页面

```
final class DevicePlugin: DebugPlugin {
    
    let name = "设备信息"
    let icon = UIImage(named: "device.info", in: .debug, with: nil)

    func onDidSelect() {
        let detail = DeviceViewController()
        detail.title = name
        DebugController.push(detail)        
    }
}
```

## 注册插件
在合适的位置调用
```
DebugController.registerPlugin("xxx")
```
或者
```
DebugController.registerPlugins(from: "PATH/xxx.plist", bundle: "YOUR_BUNDLE")
```