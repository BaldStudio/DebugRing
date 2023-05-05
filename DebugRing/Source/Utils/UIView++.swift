//
//  UIView++.swift
//  DebugRing
//
//  Created by crzorz on 2023/5/5.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import UIKit

extension UIView {
    
    func edgesEqual(to v: UIView, with insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: v.leftAnchor,
                                       constant: insets.left),
            rightAnchor.constraint(equalTo: v.rightAnchor,
                                        constant: insets.right),
            topAnchor.constraint(equalTo: v.topAnchor,
                                      constant: insets.top),
            bottomAnchor.constraint(equalTo: v.bottomAnchor,
                                         constant: insets.bottom),
        ])
    }
    
    func edgesEqualToSuperview(with insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { fatalError() }
        edgesEqual(to: superview, with: insets)
    }
    
}

