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
        cellClass = MockCrashItemCell.self
    }
    
    override func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        let cell = cell as! MockCrashItemCell
        cell.titleLabel.text = title
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        action?()
    }
}

private final class MockCrashItemCell: ListViewCell {
    
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
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 22),
        ])
        return imageView
    }()

    
    override func commonInit() {
        super.commonInit()
        let stackView = UIStackView(arrangedSubviews: [titleLabel, arrow])
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        contentView.addSubview(stackView)
        
        stackView.edgesEqual(to: self,
                             with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16))
    }
    
}

