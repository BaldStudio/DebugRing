//
//  AnyOpenPlugin.swift
//  DebugRing
//
//  Created by crzorz on 2022/7/13.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class AnyOpenPlugin: DebugPlugin {
    
    let name = "任意门"
    let icon = UIImage(named: "door.dimension", in: .debugRing, with: nil)
    let instruction = "通过scheme打开任意页面"

    func onDidSelect() {
        let detail = AnyOpenViewController()
        detail.title = name
        DebugController.push(detail)
    }
}

