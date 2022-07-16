//
//  DeviceViewController.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class DeviceViewController: CollectionViewController {
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                             
        showRightBarItem(title: "复制",
                         action: #selector(onCopyAll))
        
        setupDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(onTimer(_:)),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
        timer!.fire()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer?.invalidate()
        timer = nil
    }
    
    private func setupDataSource() {
        for cate in categories {
            let section = CollectionViewSection(cate)
            collectionView.append(section: section)
            
            let infos = details[cate]!
            for info in infos {
                let item = DeviceItem(info)
                section.append(item)
            }
        }
    }
}

@objc
private extension DeviceViewController {
    
    func onCopyAll() {
        
        var report: [String] = []
        for cate in categories {
            let infos = details[cate]!
            for info in infos {
                report.append("\(info.name): \(info.value)")
            }
        }

        if let data = try? JSONSerialization.data(withJSONObject: report,
                                                  options: .prettyPrinted) {
            UIPasteboard.general.string = String(data: data, encoding: .utf8)
        }
        
    }
    
    func onTimer(_ sender: Timer) {
        // 这里去动态检测内存啊，网络啊啥的，
        // 先TODO吧、、、笑
    }
}

//MARK: - Menu

extension DeviceViewController {
            
    func collectionView(_ collectionView: UICollectionView,
                        shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        canPerformAction action: Selector,
                        forItemAt indexPath: IndexPath,
                        withSender sender: Any?) -> Bool {
        action == #selector(UIResponderStandardEditActions.copy(_:))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        performAction action: Selector,
                        forItemAt indexPath: IndexPath,
                        withSender sender: Any?) {
        let cate = categories[indexPath.section]
        let info = details[cate]![indexPath.row]
        
        UIPasteboard.general.string = "\(info.name): \(info.value)"
    }
}

//MARK: - Data

private extension DeviceViewController {
    
    var categories: [String] {
        [
            "基本信息",
            "硬件配置",
            "网络类型",
            "其他"
        ]
    }
        
    var details: [String: [DeviceInfo]] {
        [
            "基本信息": [
                DeviceInfo(name: "设备型号", value: DeviceHelper.deviceName),
                DeviceInfo(name: "设备系统版本", value: DeviceHelper.systemVersion),
                DeviceInfo(name: "设备用户名", value: DeviceHelper.phoneName),
                DeviceInfo(name: "当前电量", value: DeviceHelper.batteryLevel),
            ],
            
            "硬件配置": [
                DeviceInfo(name: "屏幕逻辑尺寸", value: DeviceHelper.logicalScreenSize),
                DeviceInfo(name: "CPU架构类型", value: DeviceHelper.cpuType),
                DeviceInfo(name: "CPU核心数", value: DeviceHelper.numberOfCPUs),
                DeviceInfo(name: "设备总内存", value: DeviceHelper.memoryTotal),
                DeviceInfo(name: "设备空闲内存", value: DeviceHelper.memoryFree),
                DeviceInfo(name: "当前App占用内存", value: DeviceHelper.memoryUsageInApp),
                DeviceInfo(name: "设备总存储", value: DeviceHelper.diskTotal),
                DeviceInfo(name: "设备剩余存储", value: DeviceHelper.diskFree),
            ],
            
            "网络类型": [
                DeviceInfo(name: "SIM个数", value: DeviceHelper.numberOfSIMs),
                DeviceInfo(name: "网络运营商", value: DeviceHelper.carrierName),
                DeviceInfo(name: "网络状态", value: DeviceHelper.netState),
                DeviceInfo(name: "局域网IP地址", value: DeviceHelper.ipLAN),
                DeviceInfo(name: "是否使用代理", value: DeviceHelper.isUsingProxy),
            ],
            
            "其他": [
                DeviceInfo(name: "App名称", value: DeviceHelper.appName),
                DeviceInfo(name: "App标识", value: DeviceHelper.appBundleID),
                DeviceInfo(name: "App更新时间", value: DeviceHelper.appLastUpdated),
                DeviceInfo(name: "是否是模拟器", value: DeviceHelper.isSimulator),
                DeviceInfo(name: "是否越狱", value: DeviceHelper.isJailbreak),
            ],

        ]
    }
}
