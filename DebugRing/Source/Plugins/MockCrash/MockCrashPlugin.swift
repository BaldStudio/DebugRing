//
//  MockCrashPlugin.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class MockCrashPlugin: DebugPlugin {
    
    let name = "模拟Crash"
    let icon = UIImage(named: "crash.mock", in: .debugRing, with: nil)

    func onDidSelect() {
        let detail = MockCrashViewController()
        detail.title = name
        DebugController.push(detail)
    }
}
