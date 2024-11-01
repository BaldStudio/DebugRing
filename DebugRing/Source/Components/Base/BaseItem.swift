//
//  BaseItem.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

class BaseItem: BsCollectionViewMutableItem {
    override init() {
        super.init()
        cellClass = BaseItemCell.self
    }
    
    override func didHighlightItem(at indexPath: IndexPath) {
        guard let cell = cell as? BaseItemCell else { return }
        
        cell.highlightedView.isHidden = false
        cell.highlightedView.alpha = 0
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveEaseIn) {
            cell.highlightedView.alpha = 1
        }
    }
    
    override func didUnhighlightItem(at indexPath: IndexPath) {
        guard let cell = cell as? BaseItemCell else { return }
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveEaseOut) {
            cell.highlightedView.alpha = 0.0
        } completion: { _ in
            cell.highlightedView.isHidden = true
        }
    }
}

class BaseItemCell: BsUICollectionViewCell {
    let highlightedView: UIView = UIView().then {
        $0.backgroundColor = UIColor(white: 0.7, alpha: 1)
        $0.isUserInteractionEnabled = false
        $0.isHidden = true
    }
    
    override func onInit() {
     super.onInit()
        contentView.addSubview(highlightedView)
        highlightedView.edgesEqualToSuperview()
    }
}
