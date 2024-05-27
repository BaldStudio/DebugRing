//
//  PluginRegistrar.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import Foundation

final class PluginRegistrar {
    var plugins: [String] = []
    
    init() {
        if let plistPath = Bundle.debug.path(forResource: "DebugPlugins",
                                             ofType: "plist") {
            registerPlugins(from: plistPath, for: "DebugRing")
        }
        registerPluginsFromMachO()
    }
        
    @discardableResult
    func registerPlugin(_ name: String) -> Bool {
        if plugins.contains(name) {
            return false
        }
        
        plugins.append(name)
        return true
    }
    
    @discardableResult
    func registerPlugins(from plistPath: String,
                         for bundleName: String) -> Bool {
        guard let pluginsLoaded = NSArray(contentsOfFile: plistPath) as? [String]
        else { return false }
        
        for name in pluginsLoaded {
            plugins.append(bundleName + "." + name)
        }
        return true
    }

    @discardableResult
    func registerPluginsFromMachO() -> Bool {
        var data: [PluginData] = loadMachOData(segment: .debug,
                                               section: .plugin)
        data.sort { $0.name > $1.name }
        for info in data {
            plugins.append(info.name)
        }
        return true
    }

    func unregisterPlugin(_ name: String) {
        plugins.removeAll {
            $0 == name
        }
    }
}

extension PluginRegistrar: CustomStringConvertible {
    var description: String {
        if let data = try? JSONSerialization.data(withJSONObject: plugins,
                                                  options: [.fragmentsAllowed, .prettyPrinted]),
           let json = String(data: data, encoding: .utf8) {
            return json
        }
        return "[]"
    }
}
