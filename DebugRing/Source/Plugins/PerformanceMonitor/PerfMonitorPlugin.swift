//
//  PerfMonitorPlugin.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class PerfMonitorPlugin: DebugPlugin {
    
    private lazy var monitorView = PerfMonitorView.shared

    var name: String = "性能监控"
    var icon: UIImage = UIImage(systemName: "circle")!
        
    func onDidSelect() {
        monitorView.toggle()
        
        if monitorView.isHidden {
            DebugController.removeTouchReceiver(monitorView)
            logger.debug("性能监控 【已关闭】")
        }
        else {
            DebugController.addTouchReceiver(monitorView)
            logger.debug("性能监控 【已启用】")
        }
    }
}
