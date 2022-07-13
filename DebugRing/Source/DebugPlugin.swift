//
//  DebugPlugin.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/8.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

public typealias DebugPlugin = DebugPluginRepresentable & NSObject

@objc
public protocol DebugPluginRepresentable: AnyObject {
    
    var name: String { get }
    var icon: UIImage? { get }
    
    @objc optional
    var instruction: String { get }
    
    func onDidSelect()
}

private extension DebugPluginRepresentable {
    
    var icon: UIImage? {
        UIImage(systemName: "circle")
    }
    
    var instruction: String { "" }
    
    func onDidSelect() {}
}
