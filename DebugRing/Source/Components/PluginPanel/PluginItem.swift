//
//  PluginItem.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class PluginItem: CollectionViewHighlightedItem {
    
    var plugin: DebugPlugin!
    
    required override init() {
        super.init()
        cellClass = PluginItemCell.self
    }
        
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? PluginItemCell else { return }
        
        cell.nameLabel.text = plugin.name
        cell.iconView.image = plugin.icon
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        plugin.onDidSelect()
    }
}

private class PluginItemCell: CollectioViewHighlightedCell {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = UIColor(white: 0.3, alpha: 1.0)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
        
    override func commonInit() {
        super.commonInit()
        
        contentView.backgroundColor = .white
        
        highlightedView.layer.cornerRadius = 16
        
        contentView.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,
                                              constant: -8),
            iconView.widthAnchor.constraint(equalToConstant: 48),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor)
        ])

        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor,
                                           constant: 4),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -8),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
}
