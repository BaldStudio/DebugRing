//
//  ViewController.swift
//  DebugRingDemo
//
//  Created by crzorz on 2021/12/02.
//  Copyright © 2021 BaldStudio. All rights reserved.
//

import UIKit
import DebugRing

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.global().async {
            var str = ""
            for _ in 0..<10000000000 {
                str += "1"
            }
        }
    }
}

