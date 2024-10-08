//
//  DebugController.swift
//  DebugRing
//
//  Created by crzorz on 2021/12/02.
//  Copyright © 2021 BaldStudio. All rights reserved.
//

@_exported import BsFoundation

public final class DebugController: NSObject {
    lazy var window = RingWindow(frame: Screen.bounds)
    
    lazy var ring = RingViewController()
    
    lazy var pluginRegistrar = PluginRegistrar()

    private override init() {
        super.init()
        
        window.delegate = self
        window.rootViewController = ring
    }
    
    @objc
    public static let shared = DebugController()

    @objc
    public var isHidden: Bool {
        window.isHidden
    }
        
}

//MARK: - Display

@objc
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

@objc
public extension DebugController {
    internal static var navigator: BsNavigationController {
        shared.ring.presentedViewController as! BsNavigationController
    }

    static func present(_ viewController: UIViewController) {
        let nav = BsNavigationController(rootViewController: viewController)
        shared.ring.present(nav, animated: true)
    }
    
    static func dismiss() {
        shared.ring.dismiss(animated: true)
    }
    
    static func push(_ viewController: UIViewController) {
        if let pre = navigator.topViewController {
            pre.setBackBarItem(.arrow)
        }
        
        navigator.pushViewController(viewController, animated: true)
    }
    
    static func pop() {
        navigator.popViewController(animated: true)
    }
}

//MARK: - Plugin

@objc
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

//MARK: - RingWindowDelegate

extension DebugController: RingWindowDelegate {
    func shouldHandleTouch(at pointInWindow: CGPoint) -> Bool {
        ring.shouldReceiveTouch(at: pointInWindow)
    }
    
    var canBecomeKeyWindow: Bool {
        ring.windowBecomeKeyIfCould
    }
}

// MARK: Bootstrap

@objc
private extension DebugController {
    static func objcLoad() {
        RingWindow.replaceMethods()
        
        NotificationCenter.default
            .addObserver(DebugController.self,
                         selector: #selector(onApplicationDidFinishLaunching),
                         name: UIScene.didActivateNotification,
                         object: nil)
    }
    
    static func onApplicationDidFinishLaunching(_ note: Notification) {
        logger.info("DebugRing已启动")
        show()
        for scene in BsApp.connectedScenes where scene.activationState == .foregroundActive {
            if let windowScene = scene as? UIWindowScene {
                shared.window.windowScene = windowScene
                break
            }
        }
    }
}
