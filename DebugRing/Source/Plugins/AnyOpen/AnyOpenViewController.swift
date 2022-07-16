//
//  AnyOpenViewController.swift
//  DebugRing
//
//  Created by crzorz on 2022/7/13.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import BsListKit

final class AnyOpenViewController: CollectionViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showRightBarItem(style: .add,
                         action: #selector(onAdd))

        setupDataSource()
    }
    
    private func setupDataSource() {
        let section = BsCollectionViewSection()
        collectionView.append(section: section)
        
        let item = AnyOpenItem()
        item.title = "再说吧"
        section.append(item)
    }
}

@objc
extension AnyOpenViewController {
    
    func onAdd(_ sender: UIBarButtonItem) {
        
    }
    
}
