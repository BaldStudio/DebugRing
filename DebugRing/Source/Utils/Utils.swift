//
//  Utils.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

@_exported
import BsFoundation

@_exported
import BsUIKit

//MARK: - Logger

let logger: BsLogger = {
    let logger = BsLogger(subsystem: "com.bald-studio.DebugRing",
                          category: "DebugRing")
    logger.level = .none
    return logger
}()

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
    static let debug = MachOSegment(name: DEBUG_RING_SEG)
}

extension MachOSection {
    static let plugin = MachOSection(name: DEBUG_RING_SECT)
}
