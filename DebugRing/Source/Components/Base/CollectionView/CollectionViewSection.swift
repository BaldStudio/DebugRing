//
//  CollectionViewSection.swift
//  DebugRing
//
//  Created by crzorz on 2022/8/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

class CollectionViewSection {
    
    typealias Parent = CollectionViewDataSource
    typealias Child = CollectionViewItem

    weak var parent: Parent? = nil
    
    var children: ContiguousArray<Child> = []
    
    var insets: UIEdgeInsets = .zero
    var minimumLineSpacing: CGFloat = 0
    var minimumInteritemSpacing: CGFloat = 0

    init() {}

    var collectionView: CollectionView? {
        parent?.collectionView
    }
            
    func reload() {
        guard let collectionView = collectionView,
              let section = index else { return }
        collectionView.reloadSections([section])
    }

    // MARK: - Node Actions
    
    var count: Int {
        children.count
    }
    
    var isEmpty: Bool {
        children.count < 1
    }
    
    var index: Int? {
        parent?.children.firstIndex(of: self)
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
    
    func replace(childAt index: Int, with child: Child) {
        child.removeFromParent()
        
        children[index] = child
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
    
    func removeFromParent() {
        parent?.remove(self)
    }
    
    func child(at index: Int) -> Child {
        children[index]
    }
    
    func contains(_ child: Child) -> Bool {
        children.contains { $0 == child }
    }
    
    subscript(index: Int) -> Child {
        set {
            replace(childAt: index, with: newValue)
        }
        get {
            children[index]
        }
    }
    
    // MARK: - Header

    var headerSize: CGSize = .zero
    
    var headerClass: UICollectionReusableView.Type = UICollectionReusableView.self
    
    var headerNib: UINib? = nil

    var headerReuseIdentifier: String {
        "\(Self.self).\(headerClass).Header"
    }
    
    var headerView: UICollectionReusableView? {
        guard let index = index,
              let collectionView = collectionView else {
            return nil
        }

        return collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader,
                                                at: IndexPath(index: index))
    }

    func collectionView(_ collectionView: CollectionView,
                             viewForHeaderAt indexPath: IndexPath) -> UICollectionReusableView {
        collectionView.registerHeaderIfNeeded(self)
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                               withReuseIdentifier: headerReuseIdentifier,
                                                               for: indexPath)
        update(header: view, at: indexPath)
        return view
    }
    
    func update(header: UICollectionReusableView,
                     at indexPath: IndexPath) {}
        
    func willDisplay(header: UICollectionReusableView,
                          at indexPath: IndexPath) {}
    
    func didEndDisplaying(header: UICollectionReusableView,
                               at indexPath: IndexPath) {}

    // MARK: - Footer

    var footerSize: CGSize = .zero

    var footerClass: UICollectionReusableView.Type = UICollectionReusableView.self
    
    var footerNib: UINib? = nil

    var footerReuseIdentifier: String {
        "\(Self.self).\(footerClass).Footer"
    }
    
    var footerView: UICollectionReusableView? {
        guard let index = index,
              let collectionView = collectionView else {
            return nil
        }

        return collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter,
                                                at: IndexPath(index: index))
    }

    func collectionView(_ collectionView: CollectionView,
                             viewForFooterAt indexPath: IndexPath) -> UICollectionReusableView {
        collectionView.registerFooterIfNeeded(self)
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                               
                                                                   withReuseIdentifier: footerReuseIdentifier,
                                                               for: indexPath)
        update(footer: view, at: indexPath)
        return view
    }
    
    func update(footer: UICollectionReusableView,
                     at indexPath: IndexPath) {}
    
    func willDisplay(footer: UICollectionReusableView,
                          at indexPath: IndexPath) {}
    
    func didEndDisplaying(footer: UICollectionReusableView,
                               at indexPath: IndexPath) {}

    // MARK: - Supplementary
    
    func collectionView(_ collectionView: CollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        fatalError("需要子类重写")
    }
    
    func collectionView(_ collectionView: CollectionView,
                             willDisplaySupplementaryView view: UICollectionReusableView,
                             forElementKind elementKind: String,
                             at indexPath: IndexPath) {}

    func collectionView(_ collectionView: CollectionView,
                             didEndDisplayingSupplementaryView view: UICollectionReusableView,
                             forElementOfKind elementKind: String, at indexPath: IndexPath) {}
}

extension CollectionViewSection: Equatable {
    
    static func == (lhs: CollectionViewSection, rhs: CollectionViewSection) -> Bool {
        ObjectIdentifier(lhs).hashValue == ObjectIdentifier(rhs).hashValue
    }
    
}

extension CollectionViewSection {
    
    @inlinable
    static func += (left: CollectionViewSection, right: Child) {
        left.append(right)
    }
    
    @inlinable
    static func -= (left: CollectionViewSection, right: Child) {
        left.remove(right)
    }

}
