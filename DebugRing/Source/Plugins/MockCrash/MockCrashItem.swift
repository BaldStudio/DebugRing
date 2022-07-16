//
//  MockCrashItem.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class MockCrashItem: ListViewItem {
    
    var title = ""
    var action: (() -> Void)?
    
    convenience init(_ title: String) {
        self.init()
        self.title = title
    }
    
    override init() {
        super.init()
        cellClass = ListViewNormalCell.self
    }
    
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        let cell = cell as! ListViewNormalCell
        cell.titleLabel.text = title
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        action?()
    }
}
