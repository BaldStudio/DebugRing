//
//  Bundle++.swift
//  DebugRing
//
//  Created by crzorz on 2022/7/6.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import Foundation

extension Bundle {
    static let debugRing = Bundle(path: main.path(forResource: "DebugRing",
                                                  ofType: "bundle")!)!
}

