//
//  Logger.swift
//  DebugRing
//
//  Created by crzorz on 2023/5/5.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import Foundation

final class Logger {
    
    let bundle: String = "DebugRing"
    var plugin: String?
    var level: Level = .verbose
        
    func debug(_ message: String) {
        log(message, level: .debug)
    }

    func info(_ message: String) {
        log(message, level: .info)
    }

    func warning(_ message: String) {
        log(message, level: .warning)
    }

    func error(_ message: String) {
        log(message, level: .error)
    }

}

extension Logger {
    struct Level: OptionSet {
        
        let rawValue: Int
        
        init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        static let none = Level(rawValue: -1)

        static let verbose: Level = [.debug, .info, .warning, .error]
        
        static let debug = Level(rawValue: 1 << 0)
        static let info = Level(rawValue: 1 << 1)
        static let warning = Level(rawValue: 1 << 2)
        static let error = Level(rawValue: 1 << 3)
    }
    
    func log(_ message: String, level lv: Level = .verbose) {
        var prefix: String
        switch lv {
        case .error:
            prefix = "❌ ERROR"
        case .warning:
            prefix = "⚠️ WARNING"
        case .info:
            prefix = "🟢 INFO"
        case .debug:
            prefix = "🟤 DEBUG"
        default:
            fatalError("好好想想，为什么会走到今天这一步")
        }
        
        let timestamp = DateFormatter.common.string(from: Date())
        var content = "\(timestamp) [\(bundle)"
        if let plugin = plugin {
            content += ".\(plugin)"
        }
        content += "] \(prefix) - \(message)"
        
        if level == .none { return }
        guard level.contains(lv) else { return }
        print(content)
    }

}
