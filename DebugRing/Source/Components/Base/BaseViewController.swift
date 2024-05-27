//
//  BaseViewController.swift
//  DebugRing
//
//  Created by changrunze on 2023/8/9.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

class BaseViewController: BsCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        setupDataSource()
    }
    
    func setupDataSource() {
        fatalError("This method must be overridden")
    }
}
