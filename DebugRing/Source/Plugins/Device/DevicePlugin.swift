//
//  DevicePlugin.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//
//  设备信息的汇总

import UIKit

final class DevicePlugin: DebugPlugin {
    
    let name = "设备信息"
    let icon = UIImage(named: "device.info", in: .debugRing, with: nil)

    func onDidSelect() {
        let detail = DeviceViewController()
        detail.title = name
        DebugController.push(detail)        
    }
}

