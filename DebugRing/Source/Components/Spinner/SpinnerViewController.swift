//
//  SpinnerViewController.swift
//  DebugRing
//
//  Created by crzorz on 2022/7/6.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class SpinnerViewController: UIViewController {
    let spinner = UIActivityIndicatorView(style: .large)

    deinit {
        logger.debug("\(self.classForCoder) -> deinit 🔥")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        spinner.startAnimating()
    }
}

extension SpinnerViewController {
    
    func show(in parent: UIViewController) {
        parent.addChild(self)
        view.frame = parent.view.frame
        parent.view.addSubview(view)
        didMove(toParent: parent)
    }
    
    func hide() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
