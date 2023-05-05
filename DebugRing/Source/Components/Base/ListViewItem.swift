//
//  TableViewItem.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

class ListViewItem: CollectionViewHighlightedItem {
    
    override init() {
        super.init()
        
        cellClass = ListViewCell.self
        cellSize = CGSize(width: Screen.width, height: 44)
    }
}

class ListViewCell: CollectioViewHighlightedCell {
    
    lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        view.isUserInteractionEnabled = false
        view.layer.zPosition = 10;
        return view
    }()
    
    override func commonInit() {
        super.commonInit()
                
        contentView.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                              constant: 16),
            separator.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])

    }
}

//MARK: - Normal Cell

class ListViewNormalCell: ListViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var arrow: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .center
        return imageView
    }()
    
    override func commonInit() {
        super.commonInit()
        
        contentView.addSubview(arrow)
        NSLayoutConstraint.activate([
            arrow.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                         constant: -8),
            arrow.topAnchor.constraint(equalTo: contentView.topAnchor),
            arrow.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            arrow.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                             constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: arrow.leftAnchor,
                                              constant: -16)
        ])
    }
}
