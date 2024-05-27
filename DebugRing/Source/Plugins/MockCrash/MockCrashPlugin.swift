//
//  MockCrashPlugin.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//
//  模拟各种常见的crash场景

import UIKit

final class MockCrashPlugin: DebugPlugin {
    let name = "模拟Crash"
    let icon = UIImage(debug: "crash.mock")
    let instruction = "模拟各种常见的crash场景"

    func onDidSelect() {
        let detail = MockCrashViewController()
        detail.title = name
        DebugController.push(detail)
    }
}
