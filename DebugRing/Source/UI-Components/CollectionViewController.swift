//
//  CollectionViewController.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate {
        
    deinit {
        logger.debug("\(self.classForCoder) -> deinit 🔥")
    }
    
    var collectionView: BsCollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = BsCollectionView(delegate: self)
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        collectionView.edgesEqualToSuperview()
    }
    

}
