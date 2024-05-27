//
//  RowItem.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

class RowItem: BaseItem {
    override init() {
        super.init()
        cellClass = RowItemCell.self
        size = [0, 44]
        preferredLayoutSizeFixed = .horizontal
    }
}

class RowItemCell: BaseItemCell {
    let separator: UIView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .separator
        $0.isUserInteractionEnabled = false
        $0.layer.zPosition = 10
    }
    
    override func commonInit() {
        super.commonInit()
        contentView.backgroundColor = .white
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

class PrimaryRowItemCell: RowItemCell {
    let titleLabel: UILabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .black
    }
    
    let arrow: UIImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "chevron.right")
        $0.contentMode = .center
    }
    
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
