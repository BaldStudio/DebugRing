//
//  CollectionViewItem.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

class CollectionViewItem: BsCollectionViewItem {
    
    override init() {
        super.init()
         
        cellClass = CollectioViewCell.self
    }
    
    override func didHighlightItem(at indexPath: IndexPath) {
        
        guard let cell = cell as? CollectioViewCell else { return }
        
        cell.highlightedView.isHidden = false
        cell.highlightedView.alpha = 0
        
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseIn) {
            cell.highlightedView.alpha = 1
        }

    }
    
    override func didUnhighlightItem(at indexPath: IndexPath) {
        
        guard let cell = cell as? CollectioViewCell else { return }
        
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseOut) {
            cell.highlightedView.alpha = 0.0
        } completion: { _ in
            cell.highlightedView.isHidden = true
        }
    }

}

class CollectioViewCell: UICollectionViewCell {
    
    lazy var highlightedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.7, alpha: 1)
        view.isUserInteractionEnabled = false
        view.isHidden = true
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
                
        contentView.addSubview(highlightedView)
        highlightedView.edgesEqualToSuperview()

    }

}
