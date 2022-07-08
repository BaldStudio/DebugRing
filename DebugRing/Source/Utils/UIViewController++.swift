//
//  UIViewController++.swift
//  DebugRing
//
//  Created by crzorz on 2022/7/8.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showRightBarItem(title: String, action: Selector) {
        navigationItem
            .rightBarButtonItem = UIBarButtonItem(title: title,
                                                  style: .plain,
                                                  target: self,
                                                  action: action)
    }

}
