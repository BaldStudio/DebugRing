//
//  UIColor++.swift
//  DebugRing
//
//  Created by crzorz on 2022/7/8.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

extension UIColor {
        
    convenience init(_ hex: Int, alpha: CGFloat = 1.0) {
        let hex = min(0xFFFFFF, max(0, hex))
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255
        let g = CGFloat((hex & 0xFF00) >> 8) / 255
        let b = CGFloat((hex & 0xFF)) / 255
        self.init(red: r,
                  green: g,
                  blue: b,
                  alpha: alpha)
    }
    
    var toImage: UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1)
        defer {
            UIGraphicsEndImageContext()
        }
        setFill()
        UIRectFill(rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
