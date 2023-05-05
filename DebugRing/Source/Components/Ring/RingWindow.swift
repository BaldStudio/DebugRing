//
//  RingWindow.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/8.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

protocol RingWindowDelegate: AnyObject {
    func shouldHandleTouch(at point: CGPoint) -> Bool
    var canBecomeKeyWindow: Bool { get }
}

final class RingWindow: UIWindow {
    weak var delegate: RingWindowDelegate?
    var previousKeyWindow: UIWindow?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        windowLevel = .statusBar + 520
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if delegate?.shouldHandleTouch(at: point) == true {
            return super.point(inside: point, with: event)
        }
        return false
    }

    override var canBecomeKey: Bool {
        delegate?.canBecomeKeyWindow == true
    }

    override func makeKey() {
        let window = UIApplication.shared.appKeyWindow
        if let ringWindow = window as? RingWindow {
            previousKeyWindow = ringWindow.previousKeyWindow
        }
        else {
            previousKeyWindow = window
        }

        super.makeKey()
    }

    override func resignKey() {
        super.resignKey()
        previousKeyWindow = nil
    }
    
    @objc
    func shouldAffectStatusBarAppearance() -> Bool {
        isKeyWindow
    }
    
    static func replaceMethods() {
                
        func addMethod(_ originSelector: Selector, _ newSelector: Selector) {
            guard let newMethod = class_getInstanceMethod(self, newSelector)
            else { return }
            class_addMethod(self,
                            originSelector,
                            method_getImplementation(newMethod),
                            method_getTypeEncoding(newMethod))
        }
        
        let canAffectSelectorString = ["_can", "Affect", "Status", "Bar", "Appearance"].joined()
        let canAffectSelector = NSSelectorFromString(canAffectSelectorString)
        addMethod(canAffectSelector, #selector(shouldAffectStatusBarAppearance))
        
        let canBecomeKeySelectorString = "_" + NSStringFromSelector(#selector(getter: canBecomeKey))
        let canBecomeKeySelector = NSSelectorFromString(canBecomeKeySelectorString)
        addMethod(canBecomeKeySelector, #selector(getter: canBecomeKey))
    }
}
