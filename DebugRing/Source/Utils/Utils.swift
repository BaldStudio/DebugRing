//
//  Utils.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

//MARK: - Logger

let logger: Logger = {
    let logger = Logger()
    logger.level = .none
    return logger
}()

//MARK: - Screen Size

struct Screen {
    static let bounds = UIScreen.main.bounds
    static let size = bounds.size
    static let width = bounds.width
    static let height = bounds.height
    static let scale = UIScreen.main.scale
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
    static let debug = MachOSegment(name: DEBUG_RING_SEG)
}

extension MachOSection {
    static let plugin = MachOSection(name: DEBUG_RING_SECT)
}

//MARK: - Haptic

func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let gen = UIImpactFeedbackGenerator(style: style)
    gen.prepare()
    gen.impactOccurred()
}
