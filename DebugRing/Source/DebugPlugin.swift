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
public protocol DebugPluginRepresentable {
    
    var name: String { get }
    var icon: UIImage { get }
        
    func onDidSelect()
}

extension DebugPluginRepresentable {
    
    func onDidSelect() {}
}
