//
//  DebugController.swift
//  DebugRing
//
//  Created by crzorz on 2021/12/02.
//  Copyright © 2021 BaldStudio. All rights reserved.
//

import UIKit

public final class DebugController: NSObject {
    
    lazy var window = DebugWindow(frame: Screen.bounds)
    
    lazy var ring = DebugRingViewController()
    
    lazy var pluginRegistrar = PluginRegistrar()

    private override init() {
        super.init()
        
        window.delegate = self
        window.rootViewController = ring
    }
    
    public static let shared = DebugController()

    public var isHidden: Bool {
        window.isHidden
    }
        
}

//MARK: - Display

public extension DebugController {
    
    static func show() {
        shared.window.isHidden = false
    }
    
    static func hide() {
        shared.window.isHidden = true
    }
    
    static func toggle() {
        if shared.window.isHidden {
            show()
        }
        else {
            hide()
        }
    }
    
    static func addTouchReceiver(_ view: UIView) {
        shared.ring.addTouchReceiver(view)
    }
    
    static func removeTouchReceiver(_ view: UIView) {
        shared.ring.removeTouchReceiver(view)
    }
}

//MARK: - Navigation

public extension DebugController {
    
    internal static var navigator: NavigationController {
        shared.ring.presentedViewController as! NavigationController
    }

    static func present(_ viewController: UIViewController) {
        let nav = NavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .fullScreen
        shared.ring.present(nav, animated: true)
    }
    
    static func dismissViewController() {
        shared.ring.dismiss(animated: true)
    }
    
    static func push(_ viewController: UIViewController) {
        if let pre = navigator.topViewController {
            pre.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil,
                                                                   style: .plain,
                                                                   target: pre,
                                                                   action: nil)
        }
        
        navigator.pushViewController(viewController, animated: true)
    }
    
    static func popViewController() {
        navigator.popViewController(animated: true)
    }

}

//MARK: - Plugin

public extension DebugController {
    
    static var plugins: [String] {
        shared.pluginRegistrar.plugins
    }
    
    @discardableResult
    static func registerPlugin(_ name: String) -> Bool {
        shared.pluginRegistrar.registerPlugin(name)
    }
    
    @discardableResult
    static func registerPlugins(from plistPath: String,
                                for bundleName: String) -> Bool {
        shared.pluginRegistrar.registerPlugins(from: plistPath, for: bundleName)
    }

}

//MARK: - DebugWindowDelegate

extension DebugController: DebugWindowDelegate {
    
    func shouldHandleTouch(at pointInWindow: CGPoint) -> Bool {
        ring.shouldReceiveTouch(at: pointInWindow)
    }
    
    var canBecomeKeyWindow: Bool {
        ring.windowBecomeKeyIfCould
    }

}

@objc
extension DebugController {
    static func onApplicationDidFinishLaunching(_ note: Notification) {
        logger.debug("DebugRing已启动")
        show()
        
        if #available(iOS 13.0, *) {
            for scene in UIApplication.shared.connectedScenes {
                if scene.activationState == .foregroundActive,
                    let windowScene = scene as? UIWindowScene {
                    shared.window.windowScene = windowScene
                }
            }
        }
    }
}

//MARK: - DebugRingLoader

public class DebugRingLoader: NSObject, DebueRingLoadAutomatable {
    
    public static func objcLoad() {
        
        DebugWindow.replaceMethods()
        
        var noteName = UIApplication.didFinishLaunchingNotification
        if #available(iOS 13.0, *) {
            noteName = UIScene.didActivateNotification
        }
        
        NotificationCenter.default.addObserver(DebugController.self,
                                               selector: #selector(DebugController.onApplicationDidFinishLaunching(_:)),
                                               name: noteName,
                                               object: nil)

    }
}
