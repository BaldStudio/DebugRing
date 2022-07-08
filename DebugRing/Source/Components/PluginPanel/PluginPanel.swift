//
//  PluginPanel.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class PluginPanel: CollectionViewController {
    
    var pluginRegistrar: PluginRegistrar {
        DebugController.shared.pluginRegistrar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Debug Ring"
        
        setupNavigationItems()
        
        setupDataSource()
    }
    
    private func setupNavigationItems() {
        showRightBarItem(title: "退出",
                         action: #selector(onPressQuitButton))
    }

    private func setupDataSource() {
        
        let spinner = SpinnerViewController()
        spinner.show(in: self)
        
        DispatchQueue.global().async {
            let group = PluginGroup()
            self.collectionView.append(section: group)
            
            let plugins = self.pluginRegistrar.plugins
            for name in plugins {
                guard let pluginClass = NSClassFromString(name) as? DebugPlugin.Type
                else {
                    logger.warning("跳过无法识别的插件：\(name)")
                    continue
                }
                            
                let item = PluginItem()
                item.plugin = pluginClass.init()
                item.cellSize = group.itemSize
                group.append(item)
            }

            logger.info("已加载插件: \(self.pluginRegistrar)")

            DispatchQueue.main.async {
                self.collectionView.reloadData()
                spinner.hide()
            }
        }
    }
}

@objc
private extension PluginPanel {
    
    func onPressQuitButton() {
        DebugController.dismissViewController()
    }
}
