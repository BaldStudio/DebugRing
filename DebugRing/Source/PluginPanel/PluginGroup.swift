//
//  PluginGroup.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class PluginGroup: BsCollectionViewSection {
    
    override init() {
        super.init()
        
        insets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        minimumLineSpacing = 8
        minimumInteritemSpacing = 8
        
    }
}
