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
    
    var name: String = "FLEX"
    var icon: UIImage = UIImage(systemName: "circle")!
        
    func onDidSelect() {
        FLEXManager.shared.toggleExplorer()
        
        if FLEXManager.shared.isHidden {
            logger.debug("FLEX 【已关闭】")
        }
        else {
            logger.debug("FLEX 【已启用】")
        }
    }
}
