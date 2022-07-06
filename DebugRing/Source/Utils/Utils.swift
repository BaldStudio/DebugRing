//
//  Utils.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

@_exported import UIKit
@_exported import BsListKit

import OSLog

struct DebugRing {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        return formatter
    }()
    
    struct Logger {
        
        func debug(_ message: Any) {
    #if DEBUG
            let timestamp = DebugRing.dateFormatter.string(from: Date())
            print("\(timestamp) [DebugRing] 🟤 DEBUG - \(message)")
    #endif
        }
        
        func info(_ message: Any) {
    #if DEBUG
            let timestamp = DebugRing.dateFormatter.string(from: Date())
            print("\(timestamp) [DebugRing] 🟢 INFO - \(message)")
    #endif
        }

    }

}

//MARK: - Impact

func impactFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.prepare()
    generator.impactOccurred()
}

//MARK: - Logger

let logger = DebugRing.Logger()

struct Screen {
    static let bounds = UIScreen.main.bounds
    static let width: CGFloat = bounds.width
    static let height: CGFloat = bounds.height

}
