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

//MARK: - DateFormatter

extension DateFormatter {
    static let common: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        return formatter
    }()
}

//MARK: - Bundle

extension Bundle {
    static let debug = Bundle(path: main.path(forResource: "DebugRing",
                                              ofType: "bundle")!)!
}

//MARK: - UIImage

extension UIImage {
    convenience init?(debug name: String) {
        self.init(named: name, in: .debug, with: nil)
    }
}

//MARK: - MachO

// c的结构体转成swift
struct PluginData: MachODataConvertible {
    typealias RawType = DebugRingPluginData

    let name: String

    static func convert(_ t: RawType) -> Self {
        Self(name: String(cString: t.name))
    }
}

extension MachOSegment {
    static let debug = Self(rawValue: DEBUG_RING_SEG)
}

extension MachOSection {
    static let plugin = Self(rawValue: DEBUG_RING_SECT)
}

