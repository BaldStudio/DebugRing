//
//  CollectionViewDataSource.swift
//  DebugRing
//
//  Created by crzorz on 2022/8/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class CollectionViewDataSource: NSObject {
    
    typealias Child = CollectionViewSection

    weak var collectionView: CollectionView!

    var children: ContiguousArray<Child> = []
    
    // MARK: - Node Actions
    
    var count: Int {
        children.count
    }
    
    var isEmpty: Bool {
        children.count < 1
    }
    
    func append(_ child: Child) {
        child.removeFromParent()
        
        children.append(child)
        child.parent = self
    }
    
    func append(children: [Child]) {
        for child in children {
            append(child)
        }
    }
    
    func insert(_ child: Child, at index: Int) {
        child.removeFromParent()

        children.insert(child, at: index)
        child.parent = self
    }
    
    func remove(at index: Int) {
        children[index].parent = nil
        children.remove(at: index)
    }
    
    func remove(_ child: Child) {
        if let index = children.firstIndex(of: child) {
            remove(at: index)
        }
    }

    func remove(children: [Child]) {
        for child in children {
            remove(child)
        }
    }

    func removeAll() {
        for i in 0..<children.count {
            remove(at: i)
        }
    }
        
    func child(at index: Int) -> Child {
        children[index]
    }
    
    func contains(_ child: Child) -> Bool {
        children.contains { $0 == child }
    }
    
    subscript(index: Int) -> Child {
        set {
            newValue.removeFromParent()
            
            children[index] = newValue
            newValue.parent = self
        }
        get {
            children[index]
        }
    }
    
    subscript(indexPath: IndexPath) -> Child.Child {
        set {
            self[indexPath.section][indexPath.item] = newValue
        }
        get {
            self[indexPath.section][indexPath.item]
        }
    }

}

// MARK: - UICollectionViewDataSource

extension CollectionViewDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self[indexPath].collectionView(self.collectionView,
                                              cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return self[indexPath.section].collectionView(self.collectionView, viewForHeaderAt: indexPath)
        }
        
        if kind == UICollectionView.elementKindSectionFooter {
            return self[indexPath.section].collectionView(self.collectionView, viewForFooterAt: indexPath)
        }
        
        return self[indexPath.section].collectionView(self.collectionView,
                                                      viewForSupplementaryElementOfKind: kind,
                                                      at: indexPath)
    }
}

extension CollectionViewDataSource {
    
    @inlinable
    static func += (left: CollectionViewDataSource, right: Child) {
        left.append(right)
    }
    
    @inlinable
    static func -= (left: CollectionViewDataSource, right: Child) {
        left.remove(right)
    }

}
