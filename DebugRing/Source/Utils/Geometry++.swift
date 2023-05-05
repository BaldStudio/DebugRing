//
//  Geometry++.swift
//  DebugRing
//
//  Created by crzorz on 2023/5/5.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit

//MARK:- CGPoint

extension CGPoint {
    
    @inlinable
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        CGPoint(x: left.x + right.x, y: left.y + right.y)
    }

    @inlinable
    static func += (left: inout CGPoint, right: CGPoint) {
        left = left + right
    }
    
    @inlinable
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        CGPoint(x: left.x - right.x, y: left.y - right.y)
    }

    @inlinable
    static func -= (left: inout CGPoint, right: CGPoint) {
        left = left - right
    }
    
    @inlinable
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

    @inlinable
    static func *= (point: inout CGPoint, scalar: CGFloat) {
        point = point * scalar
    }
     
    @inlinable
    static func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
        CGPoint(x: point.x / scalar, y: point.y / scalar)
    }

    @inlinable
    static func /= (point: inout CGPoint, scalar: CGFloat) {
        point = point / scalar
    }

}

//MARK:- UIEdgeInsets

extension UIEdgeInsets {

    @inlinable
    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical,
                  left: horizontal,
                  bottom: vertical,
                  right: horizontal)
    }
    
    @inlinable
    init(all inset: CGFloat) {
        self.init(top: inset,
                  left: inset,
                  bottom: inset,
                  right: inset)
    }
    
    @inlinable
    static func only(top: CGFloat = 0,
                     left: CGFloat = 0,
                     bottom: CGFloat = 0,
                     right: CGFloat = 0) -> Self {
        Self(top: top, left: left, bottom: bottom, right: right)
    }
}
