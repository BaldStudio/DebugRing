//
//  UIViewController++.swift
//  DebugRing
//
//  Created by crzorz on 2022/7/8.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

extension UIViewController {
    
    enum BackBarItemStyle {
        case arrow
    }
    
    func setBackBarItem(_ style: BackBarItemStyle) {
        if style == .arrow {
            navigationItem
                .backBarButtonItem = UIBarButtonItem(title: nil,
                                                     style: .plain,
                                                     target: self,
                                                     action: nil)

        }
    }
    
    func showRightBarItem(title: String, action: Selector) {
        navigationItem
            .rightBarButtonItem = UIBarButtonItem(title: title,
                                                  style: .plain,
                                                  target: self,
                                                  action: action)
    }
    
    func showRightBarItem(style: UIBarButtonItem.SystemItem, action: Selector) {
        navigationItem
            .rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                  target: self,
                                                  action: action)
    }

}
