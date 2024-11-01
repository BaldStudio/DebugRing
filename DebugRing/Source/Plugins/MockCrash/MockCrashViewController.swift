//
//  MockCrashViewController.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class MockCrashViewController: BaseViewController {
    let mocker = DebugCrashMocker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupDataSource() {
        for tuple in mocker.caseData {
            let item = MockCrashItem(tuple[0])
            let selector = tuple[1]
            item.onDidSelectItem = { [weak self] _ in
                self?.mocker.perform(NSSelectorFromString(selector))
            }
            section.append(item)
        }
    }
}
