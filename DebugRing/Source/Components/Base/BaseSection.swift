//
//  BaseSection.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/8.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

class BaseSection: BsCollectionViewSection {
    var title = ""
    
    override init() {
        super.init()
        
        headerClass = BaseSectionHeader.self
        
        headerSize = CGSize(width: Screen.width, height: 54)
        footerSize = CGSize(width: Screen.width, height: 24)
    }
    
    convenience init(_ title: String) {
        self.init()
        self.title = title
    }
    
    override func update(header: UICollectionReusableView,
                         at indexPath: IndexPath) {
        let header = header as! BaseSectionHeader
        header.titleLabel.text = title
    }
}

class BaseSectionHeader: BsUICollectionSupplementaryView {
    
    let titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 20)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let stubView: UIView = UIView().then {
        $0.backgroundColor = UIColor(red: 30/255,
                                       green: 144/250,
                                       blue: 1,
                                       alpha: 1)
        $0.applying(rounded: 2)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func commonInit() {
        super.commonInit()
        backgroundColor = .white
        addSubview(stubView)
        NSLayoutConstraint.activate([
            stubView.leftAnchor.constraint(equalTo: leftAnchor,
                                           constant: 8),
            stubView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stubView.widthAnchor.constraint(equalToConstant: 4),
            stubView.heightAnchor.constraint(equalToConstant: 20)
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
