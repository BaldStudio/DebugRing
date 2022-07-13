//
//  StatisticsPlugin.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class StatisticsPlugin: DebugPlugin {
    
    private lazy var statsView = StatisticsView.shared

    let name = "性能监控"
    let icon = UIImage(named: "stats", in: .debugRing, with: nil)
    let instruction = "性能浮层的开关，显示FPS，CPU，内存的信息"

    func onDidSelect() {
        statsView.toggle()
        
        if statsView.isHidden {
            DebugController.removeTouchReceiver(statsView)
            logger.info("性能监控 【已关闭】")
        }
        else {
            DebugController.addTouchReceiver(statsView)
            logger.info("性能监控 【已启用】")
        }
    }
}
