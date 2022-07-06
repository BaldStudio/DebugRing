//
//  PluginRegistrar.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import Foundation

struct PluginRegistrar {

    var plugins: [String] = []
    
    init() {
        if let plistPath = Bundle.debugRing.path(forResource: "DebugPlugins",
                                                 ofType: "plist") {
            registerPlugins(from: plistPath, for: "DebugRing")
        }
        registerPluginsFromMachO()
        
        logger.debug("已加载插件: \(self)")
    }
        
    @discardableResult
    mutating func registerPlugin(_ name: String) -> Bool {
        if plugins.contains(name) {
            return false
        }
        
        plugins.append(name)
        return true
    }
    
    @discardableResult
    mutating func registerPlugins(from plistPath: String,
                                  for bundleName: String) -> Bool {
        guard let pluginsLoaded = NSArray(contentsOfFile: plistPath) as? [String]
        else { return false }
        
        for name in pluginsLoaded {
            plugins.append(bundleName + "." + name)
        }
        return true
    }

    @discardableResult
    mutating func registerPluginsFromMachO() -> Bool {
        var data: [PluginData] = MachO.fetch(seg: .debugRing, sect: .plugin)
        data.sort { $0.name > $1.name }
        for info in data {
            plugins.append(info.name)
        }
        return true
    }

    mutating func unregisterPlugin(_ name: String) {
        plugins.removeAll {
            $0 == name
        }
    }
}

extension PluginRegistrar: CustomStringConvertible {
    
    var description: String {
        if let data = try? JSONSerialization.data(withJSONObject: plugins, options: [.fragmentsAllowed, .prettyPrinted]),
           let json = String(data: data, encoding: .utf8) {
            return json
        }
        return "[]"
    }
}
