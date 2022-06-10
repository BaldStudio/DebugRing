//
//  DevicePlugin.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class DevicePlugin: DebugPlugin {
    
    var name: String = "设备信息"
    var icon: UIImage = UIImage(systemName: "circle")!
        
    func onDidSelect() {
        let detail = DeviceViewController()
        detail.title = name
        DebugController.push(detail)        
    }
}

