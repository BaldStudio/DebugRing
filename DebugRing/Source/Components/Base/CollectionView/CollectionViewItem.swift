//
//  CollectionViewItem.swift
//  DebugRing
//
//  Created by crzorz on 2022/8/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

class CollectionViewItem {
    
    typealias Parent = CollectionViewSection

    weak var parent: Parent? = nil

    var nib: UINib? = nil

    var cellClass: UICollectionViewCell.Type = UICollectionViewCell.self

    var cellSize: CGSize = .zero

    var reuseIdentifier: String {
        "\(Self.self).\(cellClass).Cell"
    }
        
    init() {}

    var collectionView: CollectionView? {
        parent?.collectionView
    }

    var cell: UICollectionViewCell? {
        guard let collectionView = collectionView,
              let indexPath = indexPath else {
            return nil
        }
        
        return collectionView.cellForItem(at: indexPath)
    }

    var indexPath: IndexPath? {
        guard let parent = parent,
            let section = parent.index,
            let item = parent.children.firstIndex(of: self) else {
            return nil
        }
        
        return IndexPath(row: item, section: section)
    }
    
    func reload() {
        guard let collectionView = collectionView,
              let indexPath = indexPath else { return }
        collectionView.reloadItems(at: [indexPath])
    }
    
    // MARK: - Additions

    func removeFromParent() {
        parent?.remove(self)
    }
    
    // MARK: - Cell
    
    func collectionView(_ collectionView: CollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.registerCellIfNeeded(self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath)
        update(cell, at: indexPath)
        return cell
    }
    
    func update(_ cell: UICollectionViewCell, at indexPath: IndexPath) {}

    func willDisplay(_ cell: UICollectionViewCell, at indexPath: IndexPath) {}
    
    func didEndDisplaying(_ cell: UICollectionViewCell, at indexPath: IndexPath) {}
    
    func didSelectItem(at indexPath: IndexPath) {}
    
    func didHighlightItem(at indexPath: IndexPath) {}
    
    func didUnhighlightItem(at indexPath: IndexPath) {}

}

extension CollectionViewItem: Equatable {
    
    static func == (lhs: CollectionViewItem, rhs: CollectionViewItem) -> Bool {
        ObjectIdentifier(lhs).hashValue == ObjectIdentifier(rhs).hashValue
    }
    
}
