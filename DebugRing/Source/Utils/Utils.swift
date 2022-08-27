//
//  Utils.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

//MARK: - Logger

let logger: BsLogger = {
    let logger = BsLogger(subsystem: "com.bald-studio.DebugRing",
                          category: "DebugRing")
    logger.level = .none
    return logger
}()

extension DateFormatter {
    static let common: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        return formatter
    }()
}

extension Bundle {
    static let debug = Bundle(path: main.path(forResource: "DebugRing",
                                              ofType: "bundle")!)!
}

extension UIImage {
    convenience init?(debug name: String) {
        self.init(named: name, in: .debug, with: nil)
    }
}
