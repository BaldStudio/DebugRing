//
//  CollectionView.swift
//  DebugRing
//
//  Created by crzorz on 2022/8/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class CollectionView: UICollectionView {
    
    final private(set) var ext = Extends()
    
    private(set) var registryMap: [String: AnyObject] = [:]

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init(delegate: UICollectionViewDelegate) {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.delegate = delegate
    }

    private func commonInit() {
        backgroundColor = .systemGroupedBackground
        
        delegate = ext.proxy
        dataSource = ext.dataSource
        
        ext.proxy.collectionView = self
    }
    
    // MARK: - Override

    override var dataSource: UICollectionViewDataSource? {
        get {
            ext.dataSource
        }
        set {
            if let dataSource = newValue as? CollectionViewDataSource {
                super.dataSource = dataSource
                ext.dataSource = dataSource
                ext.proxy.dataSource = dataSource
                dataSource.collectionView = self
            }
            else {
                super.dataSource = newValue
            }
        }
    }
    
    override var delegate: UICollectionViewDelegate? {
        set {
            guard let newValue = newValue else {
                ext.proxy.target = nil
                return
            }
            
            if !(newValue is CollectionViewProxy) {
                ext.proxy.target = newValue
            }
            
            super.delegate = ext.proxy
        }
        get {
            super.delegate
        }
    }
    
    override func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        super.register(cellClass, forCellWithReuseIdentifier: identifier)
//        guard identifier != "com.apple.UIKit.shadowReuseCellIdentifier" else { return }
        registryMap[identifier] = cellClass
    }
    
    override func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        super.register(nib, forCellWithReuseIdentifier: identifier)
        registryMap[identifier] = nib
    }
    
    override func register(_ viewClass: AnyClass?,
                                forSupplementaryViewOfKind elementKind: String,
                                withReuseIdentifier identifier: String) {
        super.register(viewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        registryMap[identifier] = viewClass
    }
    
    override func register(_ nib: UINib?,
                                forSupplementaryViewOfKind kind: String,
                                withReuseIdentifier identifier: String) {
        super.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        registryMap[identifier] = nib
    }

    // MARK: - Additions

    func append(section: CollectionViewSection) {
        ext.dataSource.append(section)
    }
    
    func remove(section: CollectionViewSection) {
        ext.dataSource.remove(section)
    }

}

// MARK: - Extends

extension CollectionView {
    
    struct Extends {
        fileprivate var proxy = CollectionViewProxy()
        var dataSource = CollectionViewDataSource()
    }
    
}

// MARK: - Registry

extension CollectionView {
    
    final func registerCellIfNeeded(_ item: CollectionViewItem) {
        
        let id = item.reuseIdentifier
        if registryMap.contains(where: { $0.key == id }) {
            return
        }
        
        if let nib = item.nib {
            register(nib, forCellWithReuseIdentifier: id)
        }
        else {
            register(item.cellClass, forCellWithReuseIdentifier: id)
        }
    }
    
    final func registerHeaderIfNeeded(_ section: CollectionViewSection) {
        
        let id = section.headerReuseIdentifier
        if registryMap.contains(where: { $0.key == id }) {
            return
        }

        if let nib = section.headerNib {
            register(nib,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                     withReuseIdentifier: id)
        }
        else {
            register(section.headerClass,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                     withReuseIdentifier: id)
        }
        
    }

    final func registerFooterIfNeeded(_ section: CollectionViewSection) {
        
        let id = section.footerReuseIdentifier
        if registryMap.contains(where: { $0.key == id }) {
            return
        }

        if let nib = section.footerNib {
            register(nib,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                     withReuseIdentifier: id)
        }
        else {
            register(section.footerClass,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,               
                     withReuseIdentifier: id)
        }

    }

}
