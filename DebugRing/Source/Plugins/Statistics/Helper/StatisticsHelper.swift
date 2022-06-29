//
//  StatisticsHelper.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/9.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class StatisticsHelper {
    
    enum InfoType {
        case fps
        case cpu
        case mem
    }

    private var timer: Timer?
    private var samplingInterval: TimeInterval = 1
    
    private var displayLink: CADisplayLink?
    
    private var frameCount: Int = 0
    private var lastFrameTime: TimeInterval = 0

    private var trackingCallback: (([InfoType: String]) -> Void)?
    
    private var infos: [InfoType: String]
        
    init() {
        infos = [
            .fps: "-1",
            .cpu: "-1",
            .mem: "-1",
        ]
    }
    
    func beginTracking(callback: @escaping ([InfoType: String]) -> Void) {
        trackingCallback = callback
        
        timer?.invalidate()
        timer = Timer(timeInterval: samplingInterval,
                      target: self,
                      selector: #selector(onTimer(_:)),
                      userInfo: nil,
                      repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
        timer!.fire()
        
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self,
                                    selector: #selector(onDisplayLink(_:)))
        displayLink!.add(to: .main, forMode: .common)
        lastFrameTime = displayLink!.timestamp
    }
    
    func stopTracking() {
        timer?.invalidate()
        timer = nil
        
        displayLink?.invalidate()
        displayLink = nil
        
        trackingCallback = nil
    }
}

@objc
private extension StatisticsHelper {
    
    func onTimer(_ sender: Timer) {
        infos[.cpu] = String(format: "%.f", updateCpuUsage())
        infos[.mem] = String(updateMemoryUsage())
        trackingCallback?(infos)
    }
    
    func onDisplayLink(_ sender: CADisplayLink) {
        
        frameCount += 1
        
        let threshold = sender.timestamp - lastFrameTime
        if threshold < 1 {
            return
        }
        
        let fps = Double(frameCount) / threshold
        lastFrameTime = sender.timestamp
        frameCount = 0
        infos[.fps] = String(format: "%.f", fps)
    }
}

private extension StatisticsHelper {
    
    func updateCpuUsage() -> Double {
        var thread_list: thread_act_array_t!
        var thread_count: mach_msg_type_number_t = 0
        var kr = task_threads(mach_task_self_,
                              &thread_list,
                              &thread_count)

        if kr != KERN_SUCCESS {
            return 0
        }
        
        var total_cpu_usage: Double = 0
        for i in 0..<thread_count {
            var info = thread_basic_info()
            var count = mach_msg_type_number_t(THREAD_INFO_MAX)
            kr = withUnsafeMutablePointer(to: &info) {
                $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                    thread_info(thread_list[Int(i)],
                                thread_flavor_t(THREAD_BASIC_INFO),
                                $0,
                                &count)
                }
            }
            
            if kr != KERN_SUCCESS {
                return 0
            }
            
            if (info.flags & TH_FLAGS_IDLE) == 0 {
                total_cpu_usage += Double(info.cpu_usage) / Double(TH_USAGE_SCALE) * 100
            }
        }
        
        let size = UInt32(MemoryLayout<thread_t>.stride) * thread_count
        
        kr = vm_deallocate(mach_task_self_,
                           vm_address_t(thread_list.pointee),
                           vm_size_t(size))
        assert(kr == KERN_SUCCESS)
        
        return total_cpu_usage
    }
    
    func updateMemoryUsage() -> UInt64 {
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
            return info.phys_footprint / 1024 / 1024
        }
        
        return 0
    }

}
