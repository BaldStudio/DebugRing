//
//  AnyOpenViewController.swift
//  DebugRing
//
//  Created by crzorz on 2022/7/13.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class AnyOpenViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        showRightBarItem(style: .add,
                         action: #selector(onAdd))
    }
    
    override func setupDataSource() {
        let item = AnyOpenItem()
        item.title = "再说吧"
        item.onDidSelectItem = { _ in
            logger.info("再说吧")
        }
        section.append(item)
    }
}

@objc
extension AnyOpenViewController {
    func onAdd(_ sender: UIBarButtonItem) {
        
    }
}
