//
//  Bundle+.swift
//  DebugRing
//
//  Created by crzorz on 2023/5/5.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

extension Bundle {
    static let debug = Bundle(path: main.path(forResource: "DebugRing",
                                              ofType: "bundle")!)!
}
