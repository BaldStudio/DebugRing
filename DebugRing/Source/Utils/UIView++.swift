//
//  UIView++.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

extension UIView {
    
    func edgesEqual(to v: UIView, with insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: v.topAnchor,
                                 constant: insets.top),
            leftAnchor.constraint(equalTo: v.leftAnchor,
                                  constant: insets.left),
            bottomAnchor.constraint(equalTo: v.bottomAnchor,
                                    constant: insets.bottom),
            rightAnchor.constraint(equalTo: v.rightAnchor,
                                   constant: insets.right)
        ])
    }

    func edgesEqualToSuperview(with insets: UIEdgeInsets = .zero) {
        edgesEqual(to: superview!, with: .zero)
    }
}
