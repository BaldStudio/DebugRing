//
//  PluginItem.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class PluginItem: BaseItem {
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        plugin.onDidSelect()
    }
}

private class PluginItemCell: BaseItemCell {
    let nameLabel: UILabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 12)
        $0.textColor = UIColor(white: 0.3, alpha: 1.0)
        $0.numberOfLines = 2
    }
    
    let iconView: UIImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
        
    override func onInit() {
        super.onInit()
        
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
