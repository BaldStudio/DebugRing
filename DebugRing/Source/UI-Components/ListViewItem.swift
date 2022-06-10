//
//  TableViewItem.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

class ListViewItem: CollectionViewItem {
    
    override init() {
        super.init()
        
        cellClass = ListViewCell.self
        cellSize = CGSize(width: Screen.width, height: 44)
    }
}

class ListViewCell: CollectioViewCell {
    
    lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override func commonInit() {
        super.commonInit()
        
        contentView.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                              constant: 16),
            separator.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                             constant: 48),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !separator.isHidden {
            contentView.bringSubviewToFront(separator)
        }
    }
}
