//
//  Bundle+.swift
//  DebugRing
//
//  Created by crzorz on 2023/5/5.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

extension Bundle {
    static let debug = Bundle(for: ModuleName)!
    
    static func resourcePath(for name: String) -> String? {
        debug.path(forResource: name, ofType: nil) ?? Bundle.main.path(forResource: name, ofType: nil)
    }
}
