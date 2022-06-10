//
//  DebugRingView.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

final class DebugRingView: UIView {
    
    override init(frame: CGRect) {
        let frame = CGRect(x: 0, y: 200, width: 64, height: 64)
        super.init(frame: frame)
        
        layer.borderColor = UIColor(white: 0.3, alpha: 1).cgColor
        layer.borderWidth = 4
        layer.cornerRadius = frame.width * 0.5
        backgroundColor = .clear
        
        clipsToBounds = true
        isUserInteractionEnabled = true
        
        accessibilityIdentifier = "DebugRingView"
        
        willChangeRingColor()
        
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Gestures

private extension DebugRingView {
    
    func setupGestures() {
        
        let pan = UIPanGestureRecognizer(target: self,
                                         action: #selector(onPan(_:)))
        addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(onTap(_:)))
        addGestureRecognizer(tap)

        let longPress = UILongPressGestureRecognizer(target: self,
                                                     action: #selector(onLongPress(_:)))
        longPress.minimumPressDuration = 2
        addGestureRecognizer(longPress)
    }
}

@objc
private extension DebugRingView {
    
    func onPan(_ sender: UIPanGestureRecognizer) {
        let transPoint = sender.translation(in: superview)
        center = CGPoint(x: center.x + transPoint.x, y: center.y + transPoint.y)
        sender.setTranslation(.zero, in: superview)

        if sender.state == .began {
            cancelChangeRingColor()
        }
        else if sender.state == .ended {
            willChangeRingColor()
            
            var location = center

            let offsetX = bounds.width * 0.5
            let offsetY = bounds.height * 0.5
            
            let superViewBounds = superview!.bounds
            
            if location.x > superViewBounds.width * 0.5 {
                location.x = superViewBounds.width - offsetX
            } else {
                location.x = offsetX
            }

            let minimumY = safeAreaTop + offsetY
            let maximumY = superViewBounds.height - offsetY - safeAreaBottom

            if location.y < minimumY {
                location.y = minimumY
            } else if location.y > maximumY {
                location.y = maximumY
            }

            UIView.animate(withDuration: 0.5) {
                self.center = location
            }
        }
    }
    
    func onTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            impactFeedback(.medium)
            cancelChangeRingColor()
            willChangeRingColor()
            
            DebugController.present(PluginPanel())
        }
    }
        
    @objc
    func onLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            impactFeedback(.heavy)
            DebugController.toggle()
        }
    }

}

//MARK: - Change Color

private extension DebugRingView {
    
    func willChangeRingColor() {
        perform(#selector(changeRingColor), with: nil, afterDelay: 2)
    }

    func cancelChangeRingColor() {
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(changeRingColor),
                                               object: nil)
        alpha = 1.0
    }

    @objc
    func changeRingColor() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0.5
        }
    }

}
