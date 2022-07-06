//
//  Helper.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import CoreTelephony

struct DeviceInfo {
    let name: String
    let value: String
}

struct DeviceHelper {
    private static let unknown = "㊙️"
    private static let device = UIDevice.current
    private static let appInfo = Bundle.main.infoDictionary!

    /// 设备名称 e.g. "iPhone XS Max"
    static let deviceName = device.model
    
    /// 系统版本 e.g. "iOS 14.0"
    static let systemVersion = device.systemName + " " + device.systemVersion
    
    /// 用户设置的设备名称，设置-->通用-->关于本机-->名称，e.g. "My iPhone"
    static let phoneName = device.name

    /// 当前电池用量
    static var batteryLevel: String {
        device.isBatteryMonitoringEnabled = true
        if device.batteryState == .unknown {
            return unknown
        }
        return String(device.batteryLevel * 100)
    }
    
    /// 屏幕逻辑尺寸
    static var logicalScreenSize: String {
        let size = UIScreen.main.bounds.size
        let scale = UIScreen.main.scale

        let width = Int(size.width * scale)
        let height = Int(size.height * scale)
        return "\(width) x \(height)"
    }
    
    /// 处理器类型 e.g. "ARM64"
    static var cpuType: String {
        var count = mach_msg_type_number_t(MemoryLayout<host_basic_info_data_t>.stride / MemoryLayout<integer_t>.stride)
        
        var info = host_basic_info()
        
        _ = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                host_info(mach_host_self(), HOST_BASIC_INFO, $0, &count)
            }
        }

        switch info.cpu_type {
        case CPU_TYPE_ARM:
            return "ARM"
        case CPU_TYPE_ARM64:
            return "ARM64"
        case CPU_TYPE_ARM64_32:
            return "ARM64_32"
        case CPU_TYPE_X86:
            return "x86"
        case CPU_TYPE_X86_64:
            return "x86_64"
        case CPU_TYPE_ANY:
            return "ANY"
        case CPU_TYPE_VAX:
            return "VAX"
        case CPU_TYPE_MC680x0:
            return "MC680x0"
        case CPU_TYPE_I386:
            return "I386"
        case CPU_TYPE_MC98000:
            return "MC98000"
        case CPU_TYPE_HPPA:
            return "HPPA"
        case CPU_TYPE_MC88000:
            return "MC88000"
        case CPU_TYPE_SPARC:
            return "SPARC"
        case CPU_TYPE_I860:
            return "I860"
        case CPU_TYPE_POWERPC:
            return "POWERPC"
        case CPU_TYPE_POWERPC64:
            return "POWERPC64"
        default:
            return unknown
        }
    }
    
    /// CPU 核心数
    static var numberOfCPUs: String {
        var ncpu: UInt = 0
        var len: size_t = MemoryLayout.size(ofValue: ncpu)
        sysctlbyname("hw.ncpu", &ncpu, &len, nil, 0)
        return String(ncpu)
    }
    
    /// 全部内存大小
    static var memoryTotal: String {
        let size = ProcessInfo.processInfo.physicalMemory / 1024 / 1024
        return String(size) + " MB"
    }
    
    /// 空闲内存
    static var memoryFree: String {
        let mach_port = mach_host_self()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64_data_t>.stride / MemoryLayout<integer_t>.stride)
        
        var page_size: vm_size_t = 0
        var vmStats = vm_statistics64()
        host_page_size(mach_port, &page_size)
        
        _ = withUnsafeMutablePointer(to: &vmStats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                host_statistics64(mach_port,
                                  HOST_VM_INFO64,
                                  $0,
                                  &count)
            }
        }
        
        let size = (vmStats.free_count + vmStats.external_page_count + vmStats.purgeable_count - vmStats.speculative_count) * UInt32(page_size)
        return String(size / 1024 / 1024) + " MB"
    }
    
    /// 当前 App已使用内存大小
    static var memoryUsageInApp: String {
        var count = mach_msg_type_number_t(MemoryLayout<task_vm_info_data_t>.stride / MemoryLayout<natural_t>.stride)
        
        var info = task_vm_info()

        let kr = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_,
                          task_flavor_t(TASK_VM_INFO),
                          $0,
                          &count)
            }
        }
        
        if kr == KERN_SUCCESS {
            let usage = info.phys_footprint / 1024 / 1024
            return String(usage) + " MB"
        }
        
        return unknown
    }
    
    /// 全部磁盘大小
    static var diskTotal: String {
        let fsPtr = UnsafeMutablePointer<statfs>.allocate(capacity: 1)
        defer { fsPtr.deallocate() }
        
        var fs = fsPtr.pointee
        if statfs(NSHomeDirectory(), &fs) < 0 {
            return unknown + " GB"
        }
        
        return String(UInt64(fs.f_bsize) * fs.f_blocks / UInt64(1e9)) + " GB"
    }
    
    /// 剩余磁盘大小
    static var diskFree: String {
        let fsPtr = UnsafeMutablePointer<statfs>.allocate(capacity: 1)
        defer { fsPtr.deallocate() }
        
        var fs = fsPtr.pointee
        if statfs(NSHomeDirectory(), &fs) < 0 {
            return unknown + " GB"
        }

        return String(UInt64(fs.f_bsize) * fs.f_bavail / UInt64(1e9)) + " GB"
    }
    
    /// SIM数量
    static var numberOfSIMs: String {
#if targetEnvironment(simulator)
        return "0"
#else
        let info = CTTelephonyNetworkInfo()
        guard let infoDict = info.serviceSubscriberCellularProviders
        else {
            return "0"
        }
        
        var nsim = 0
        for carrier in infoDict.values {
            if carrier.mobileCountryCode == nil
                || carrier.mobileNetworkCode == nil {
                continue
            }
            
            nsim += 1
        }
        
        return String(nsim)
#endif
    }

    /// 运营商名称
    static var carrierName: String {
#if targetEnvironment(simulator)
        return unknown
#else
        let info = CTTelephonyNetworkInfo()
        if let carriers = info.serviceSubscriberCellularProviders {
            if carriers.keys.count == 0 {
                return unknown
            }
            else {
                
                var supplier = ""
                
                for (index, carrier) in carriers.values.enumerated() {
                    if (carrier.carrierName == nil) { return unknown }
                    
                    //查看运营商信息 通过CTCarrier类
                    if index == 0 {
                        supplier = carrier.carrierName!
                    }
                    else {
                        supplier = supplier + "," + carrier.carrierName!
                    }
                }
                
                return supplier
            }
        }
        else {
            return unknown
        }
#endif
    }

    /// 网络状态
    static let netState = unknown

    /// 局域网 IP 地址
    static var ipLAN: String {
        
        var addrs: [String] = []
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        
        guard getifaddrs(&ifaddr) == 0 else {
            return unknown
        }
        
        defer { freeifaddrs(ifaddr) }

        var ptr = ifaddr
        while (ptr != nil) {
            let flags = Int32(ptr!.pointee.ifa_flags)
            var addr = ptr!.pointee.ifa_addr.pointee
            if (flags & (IFF_UP | IFF_RUNNING | IFF_LOOPBACK)) == (IFF_UP | IFF_RUNNING) {
                if addr.sa_family == AF_INET || addr.sa_family == AF_INET6 {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0) {
                        if let address = String(validatingUTF8:hostname) {
                            addrs.append(address)
                        }
                    }
                }
            }
            ptr = ptr!.pointee.ifa_next
        }
        
        return addrs.first ?? unknown

    }

    /// 是否使用网络代理
    static var isUsingProxy: String {
        
        guard let settings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue(),
              let info = settings as? [String: AnyObject],
              let isUsing = info["HTTPEnable"] as? Bool
        else { return unknown }
        
        return isUsing ? "✅" : "❌"
    }

    /// App 名称
    static var appName: String {
        guard let name = appInfo["CFBundleName"] as? String,
        let ver = appInfo["CFBundleVersion"] as? String
        else {
            return unknown
        }
        
        return name + "(\(ver))"
    }

    /// App 标识符
    static var appBundleID: String {
        guard let id = appInfo["CFBundleIdentifier"] as? String
        else {
            return unknown
        }
        return id
    }

    /// App 上次更新时间
    static var appLastUpdated: String {
        guard let infoPath = Bundle.main.path(forResource: "Info.plist",
                                              ofType: nil)
        else {
            return unknown
        }
        
        guard let attrs = try? FileManager.default.attributesOfItem(atPath: infoPath),
              let date = attrs[.creationDate] as? Date
        else { return unknown }
        
        return DebugRing.dateFormatter.string(from: date)
    }

    /// 是否是模拟器
    static var isSimulator: String {
#if targetEnvironment(simulator)
        "✅"
#else
        "❌"
#endif
    }

    /// 是否越狱
    static var isJailbreak: String {
        
        let paths = [
            "/User/Applications/",
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
        ]
        
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return "✅"
            }
        }
        
        return "❌"
    }

}


