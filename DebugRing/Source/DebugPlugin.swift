//
//  DebugPlugin.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/8.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

public typealias DebugPlugin = DebugPluginRepresentable & NSObject

public protocol DebugPluginRepresentable: AnyObject {
    
    var name: String { get }
    var icon: UIImage? { get }
        
    func onDidSelect()
}

private extension DebugPluginRepresentable {
    
    var icon: UIImage? {
        UIImage(systemName: "circle")
    }
    
    func onDidSelect() {}
}
