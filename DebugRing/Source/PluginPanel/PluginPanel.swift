//
//  PluginPanel.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class PluginPanel: CollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Debug Ring"
        
        setupNavigationItems()
        
        setupDataSource()
    }
    
    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "退出",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onPressQuitButton))
    }

    private func setupDataSource() {
        
        let group = PluginGroup()
        collectionView.append(section: group)
        
        let numberOfRow = 4
        let spacing = group.insets.left + group.insets.right + group.minimumInteritemSpacing * CGFloat((numberOfRow - 1))
        let width = floor((Screen.width - spacing) / CGFloat(numberOfRow))
        
        let plugins = DebugController.shared.pluginRegistrar.plugins
        for name in plugins {
            guard let pluginClass = NSClassFromString(name) as? DebugPlugin.Type
            else { continue }
            
            let plugin = pluginClass.init()
            
            let item = PluginItem()
            item.plugin = plugin
            item.cellSize = CGSize(width: width, height: width)
            group.append(item)
        }
    }
}

@objc
private extension PluginPanel {
    
    func onPressQuitButton() {
        DebugController.dismissViewController()
    }
}
