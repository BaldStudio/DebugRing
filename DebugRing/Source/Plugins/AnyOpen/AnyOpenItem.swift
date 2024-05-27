//
//  AnyOpenItem.swift
//  DebugRing
//
//  Created by crzorz on 2022/7/16.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class AnyOpenItem: RowItem {
    var title = ""
    
    convenience init(_ title: String) {
        self.init()
        self.title = title
    }
        
    override init() {
        super.init()
        cellClass = PrimaryRowItemCell.self
    }
    
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        let cell = cell as! PrimaryRowItemCell
        cell.titleLabel.text = title
    }
}
