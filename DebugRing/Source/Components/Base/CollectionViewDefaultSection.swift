//
//  CollectionViewDefaultSection.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/8.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

class CollectionViewDefaultSection: BsCollectionViewSection {
    
    var title = ""
    
    override init() {
        super.init()
        
        headerClass = CollectionViewDefaultSectionHeader.self
        
        headerSize = CGSize(width: Screen.width, height: 54)
        footerSize = CGSize(width: Screen.width, height: 24)
    }
    
    convenience init(_ title: String) {
        self.init()
        self.title = title
    }
    
    override func update(header: UICollectionReusableView,
                         at indexPath: IndexPath) {
        let header = header as! CollectionViewDefaultSectionHeader
        header.titleLabel.text = title
    }
}

class CollectionViewDefaultSectionHeader: UICollectionReusableView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stubView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 30/255,
                                       green: 144/250,
                                       blue: 1,
                                       alpha: 1)
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        backgroundColor = .white
        addSubview(stubView)
        NSLayoutConstraint.activate([
            stubView.leftAnchor.constraint(equalTo: leftAnchor,
                                           constant: 8),
            stubView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stubView.widthAnchor.constraint(equalToConstant: 8),
            stubView.heightAnchor.constraint(equalToConstant: 24)
        ])

        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: stubView.rightAnchor,
                                             constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])

    }
}
