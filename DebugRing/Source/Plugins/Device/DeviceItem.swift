//
//  DeviceItem.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class DeviceItem: ListViewItem {
    
    var info: DeviceInfo!
    
    override init() {
        super.init()
        
        cellClass = DeviceItemCell.self
    }
    
    convenience init(_ info: DeviceInfo) {
        self.init()
        self.info = info
    }
    
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        let cell = cell as! DeviceItemCell
        
        cell.titleLabel.text = info.name
        cell.subtitleLabel.text = info.value
    }
}

private final class DeviceItemCell: ListViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultHigh + 10,
                                                      for: .horizontal)
        label.setContentHuggingPriority(.defaultLow + 10,
                                        for: .horizontal)
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()

    override func commonInit() {
        super.commonInit()
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        contentView.addSubview(stackView)
        
        stackView.bs.edgesEqual(to: self, with: UIEdgeInsets(horizontal: 16, vertical: 0))
    }
    
}
