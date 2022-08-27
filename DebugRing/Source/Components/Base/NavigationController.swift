//
//  NavigationController.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import BsUIKit

final class NavigationController: BsNavigationController {
    override func commonInit() {
        modalPresentationStyle = .fullScreen
    }
}
