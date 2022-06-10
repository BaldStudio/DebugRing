//
//  NavigationController.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override var shouldAutorotate: Bool {
        topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        topViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    override var childForStatusBarStyle: UIViewController? {
        topViewController ?? super.childForStatusBarStyle
    }
    
    override var childForStatusBarHidden: UIViewController? {
        topViewController ?? super.childForStatusBarHidden
    }
    
    override var childForHomeIndicatorAutoHidden: UIViewController? {
        topViewController ?? super.childForHomeIndicatorAutoHidden
    }
    
    override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
        topViewController ?? super.childForScreenEdgesDeferringSystemGestures
    }
}
