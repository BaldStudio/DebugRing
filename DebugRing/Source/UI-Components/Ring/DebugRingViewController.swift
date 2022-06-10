//
//  DebugRingViewController.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class DebugRingViewController: UIViewController {
    
    private var menuWindow: UIWindow?
    private var originMenuWindowLevel: UIWindow.Level = .normal

    private lazy var touchReceivers = NSHashTable<UIView>.weakObjects()
    
    private lazy var ringView = DebugRingView()
    
    private var window: DebugWindow {
        DebugController.shared.window
    }
    
    var windowBecomeKeyIfCould: Bool {
        window.previousKeyWindow != nil
    }
    
    func shouldReceiveTouch(at point: CGPoint) -> Bool {
        
        let pointInView = view.convert(point, from: nil)
        
        if ringView.frame.contains(pointInView) || presentedViewController != nil {
            return true
        }
                
        if touchReceivers.count > 0 {
            for subview in touchReceivers.allObjects {
                if subview.frame.contains(pointInView) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func addTouchReceiver(_ view: UIView) {
        guard !touchReceivers.contains(view) else {
            return
        }

        touchReceivers.add(view)
        self.view.addSubview(view)
    }
    
    func removeTouchReceiver(_ v: UIView) {
        v.removeFromSuperview()
        touchReceivers.remove(v)
    }

}

extension DebugRingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(ringView)
        
        setupNotifications()
    }
    
    private func setupNotifications() {
        
        let noteCenter = NotificationCenter.default
        noteCenter.addObserver(self,
                               selector: #selector(onMenuWillShow(_:)),
                               name: UIMenuController.willShowMenuNotification,
                               object: nil)
        noteCenter.addObserver(self,
                               selector: #selector(onMenuWillHide(_:)),
                               name: UIMenuController.willHideMenuNotification,
                               object: nil)
    }
    
    /*  解决 UIMenu (UICalloutBar) 显示问题
     */
    private func findMenuWindow() -> UIWindow? {
        let wcs = ["UI", "TextE", "ffect", "sW", "indow"].joined()
        guard let windowClass = NSClassFromString(wcs)
        else { return nil }
        
        let bcs = ["UI", "Cal", "lout", "Bar"].joined()
        guard let barClass = NSClassFromString(bcs)
        else { return nil }
        
        for w in UIApplication.shared.windows {
            if !w.isKind(of: windowClass) { continue }
            
            for v in w.subviews {
                if !v.isKind(of: barClass) { continue }
                return w;
            }

        }
        
        return nil
    }
    
    /*  解决输入问题，设置KeyWindow
     */
    override func present(_ viewControllerToPresent: UIViewController,
                          animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        window.makeKey()
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if let appWindow = window.previousKeyWindow {
            appWindow.makeKey()
            appWindow.rootViewController?.setNeedsStatusBarAppearanceUpdate()
        }
        super.dismiss(animated: flag, completion: completion)
    }

}

@objc
private extension DebugRingViewController {
    
    func onMenuWillShow(_ note: Notification) {
        menuWindow = findMenuWindow()
        guard let menuWindow = menuWindow else { return }
        
        originMenuWindowLevel = menuWindow.windowLevel
        menuWindow.windowLevel = window.windowLevel + 1
    }

    func onMenuWillHide(_ note: Notification) {
        guard let menuWindow = menuWindow else { return }

        menuWindow.windowLevel = originMenuWindowLevel
    }

}
