//
//  FlexPlugin.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import FLEX

final class FlexPlugin: DebugPlugin {
    
    let name = "FLEX"
    let icon = UIImage(named: "flex", in: .debugRing, with: nil)
        
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
