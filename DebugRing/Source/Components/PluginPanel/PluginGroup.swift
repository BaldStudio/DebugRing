//
//  PluginGroup.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import BsUIKit

final class PluginGroup: BsCollectionViewSection {
    
    private let numberOfRow = 4
    private(set) var itemSize: CGSize = .zero
    
    override init() {
        super.init()
        
        insets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        minimumLineSpacing = 8
        minimumInteritemSpacing = 8
        
        let spacing = insets.left + insets.right + minimumInteritemSpacing * CGFloat((numberOfRow - 1))
        let width = floor((Screen.width - spacing) / CGFloat(numberOfRow))
        itemSize = CGSize(width: width, height: width)

    }

}
