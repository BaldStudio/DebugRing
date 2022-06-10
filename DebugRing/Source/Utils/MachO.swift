//
//  MachO.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import MachO

protocol BinaryConvertible {
    associatedtype RawType
    static func convert(_ t: RawType) -> Self
}

struct MachO {
    
    struct Segment {
        let rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        static let debugRing = Self(rawValue: DEBUG_RING_SEG)
    }

    struct Section {
        let rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        static let plugin = Self(rawValue: DEBUG_RING_SECT)
    }

    static func fetch<T: BinaryConvertible>(seg: MachO.Segment,
                                            sect: MachO.Section) -> [T] {
        
        var fileNames: [String] = []

        if let exePath = Bundle.main.executablePath {
            fileNames.append((exePath as NSString).lastPathComponent)
        }
        
        if let fwRoot = Bundle.main.privateFrameworksPath,
           let frameworks = try? FileManager.default.contentsOfDirectory(atPath: fwRoot) {
            for fw in frameworks {
                fileNames.append((fw as NSString).deletingPathExtension)
            }
        }
        
        var results: [T] = []
        
        for name in fileNames {
            var size: UInt = 0
            guard let memory = getsectdatafromFramework(name,
                                                        seg.rawValue,
                                                        sect.rawValue,
                                                        &size)
            else { continue }
            
            let stride = MemoryLayout<T.RawType>.stride
            let count = Int(size) / stride

            for i in 0..<count {
                let raw = UnsafeRawPointer(memory.advanced(by: i * stride))
                let value = raw.assumingMemoryBound(to: T.RawType.self).pointee
                results.append( T.convert(value) )
            }
        }
        
        return results;
    }

}

struct PluginData: BinaryConvertible {
    typealias RawType = DebugRingPluginData

    let name: String

    static func convert(_ t: RawType) -> Self {
        Self(name: String(cString: t.name))
    }
            
}

