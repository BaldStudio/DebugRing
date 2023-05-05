//
//  NavigationController.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        commonInit()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        commonInit()
    }

    func commonInit() {
        modalPresentationStyle = .fullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
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
