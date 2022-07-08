//
//  UIApplication++.swift
//  DebugRing
//
//  Created by crzorz on 2022/7/8.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static var appKeyWindow: UIWindow? {
        
        for scene in shared.connectedScenes {
            if scene.activationState == .foregroundActive,
               let windowScene = scene as? UIWindowScene {
                if #available(iOS 15.0, *),
                    let keyWindow = windowScene.keyWindow {
                    return keyWindow
                }
                else {
                    for window in windowScene.windows {
                        if window.isKeyWindow {
                            return window
                        }
                    }
                }
            }
        }
        
        logger.warning("未找到keyWindow")
        return nil
    }

}
