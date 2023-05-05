//
//  UIImage++.swift
//  DebugRing
//
//  Created by crzorz on 2023/5/5.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(debug name: String) {
        self.init(named: name, in: .debug, with: nil)
    }
}

