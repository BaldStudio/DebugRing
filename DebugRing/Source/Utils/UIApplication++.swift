//
//  UIApplication++.swift
//  DebugRing
//
//  Created by crzorz on 2023/5/5.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit

extension UIApplication {
    
    var appKeyWindow: UIWindow {
        
        if #available(iOS 13.0, *) {
            for scene in connectedScenes {
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
        }
        else {
            if let window = keyWindow {
                return window
            }
            
            for window in windows {
                if window.isKeyWindow {
                    return window
                }
            }
        }
        
        fatalError("Can not find key window")
        
    }

}
