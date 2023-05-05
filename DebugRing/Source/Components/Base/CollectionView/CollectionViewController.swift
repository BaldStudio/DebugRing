//
//  CollectionViewController.swift
//  DebugRing
//
//  Created by crzorz on 2022/8/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate {
            
    lazy var collectionView: CollectionView = {
        let view = CollectionView(frame: .zero,
                                  collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.edgesEqualToSuperview()
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
    }
    
}
