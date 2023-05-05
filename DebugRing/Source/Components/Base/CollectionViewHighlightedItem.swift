//
//  CollectionViewHighlightedItem.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

class CollectionViewHighlightedItem: CollectionViewItem {
    
    override init() {
        super.init()
         
        cellClass = CollectioViewHighlightedCell.self
    }
    
    override func didHighlightItem(at indexPath: IndexPath) {
        
        guard let cell = cell as? CollectioViewHighlightedCell else { return }
        
        cell.highlightedView.isHidden = false
        cell.highlightedView.alpha = 0
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveEaseIn) {
            cell.highlightedView.alpha = 1
        }

    }
    
    override func didUnhighlightItem(at indexPath: IndexPath) {
        
        guard let cell = cell as? CollectioViewHighlightedCell else { return }
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveEaseOut) {
            cell.highlightedView.alpha = 0.0
        } completion: { _ in
            cell.highlightedView.isHidden = true
        }
    }

}

class CollectioViewHighlightedCell: UICollectionViewCell {
    
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
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
                
        contentView.addSubview(highlightedView)
        highlightedView.edgesEqualToSuperview()

    }

}
