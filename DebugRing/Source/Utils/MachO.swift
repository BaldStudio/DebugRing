//
//  MachO.swift
//  DebugRing
//
//  Created by crzorz on 2023/5/5.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import Foundation
import MachO

protocol MachODataConvertible {
    associatedtype RawType
    static func convert(_ t: RawType) -> Self
}

final class MachOSegment {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

final class MachOSection {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

func loadMachOData<T: MachODataConvertible>(segment: MachOSegment,
                                                   section: MachOSection) -> [T] {
    
    var frameworkNames: [String] = []
    
    /*
        按照下面的目录找二进制文件，其他目录看情况加吧
     
        ├── Demo   # App的主二进制，包含需要找的静态库信息
        ├── Frameworks # App的动态库目录
        ├── Plugins # 其他Bundle目录，如单测Bundle

    */
            
    // 主二进制
    if let url = Bundle.main.executableURL {
        let name = url.lastPathComponent
        if !name.isEmpty {
            frameworkNames.append(name)
        }
    }
    
    // Frameworks
    if let path = Bundle.main.privateFrameworksPath,
       let contents = try? FileManager.default.contentsOfDirectory(atPath: path) {
        for filePath in contents {
            frameworkNames.append((filePath as NSString).deletingPathExtension)
        }
    }

    // Plugins
    if let path = Bundle.main.builtInPlugInsPath,
       let contents = try? FileManager.default.contentsOfDirectory(atPath: path) {
        for filePath in contents {
            frameworkNames.append((filePath as NSString).deletingPathExtension)
        }
    }
    
    return loadMachOData(by: frameworkNames, segment: segment, section: section)
}

func loadMachOData<T: MachODataConvertible>(by frameworkNames: [String],
                                                    segment: MachOSegment,
                                                    section: MachOSection) -> [T] {
    var results: [T] = []
    for name in frameworkNames {
        var size: UInt = 0
        guard let memory = getsectdatafromFramework(name,
                                                    segment.name,
                                                    section.name,
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
    
    return results

}
