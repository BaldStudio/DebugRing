//
//  MockCrashViewController.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class MockCrashViewController: CollectionViewController {
    
    let mocker = DebugCrashMocker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataSource()
    }
    
    private func setupDataSource() {
        let section = CollectionViewDefaultSection()
        collectionView.append(section: section)
        
        for data in mocker.caseData {
            let item = MockCrashItem(data[0])
            item.action = performMock(data[1])
            section.append(item)
        }
    }
}

private extension MockCrashViewController {
    func performMock(_ sel: String) -> () -> Void {
        { [weak self] in
            self?.mocker.perform(NSSelectorFromString(sel))
        }
    }    
}
