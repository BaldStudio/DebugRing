//
//  PerfMonitorView.swift
//  DebugRing
//
//  Created by crzorz on 2022/6/9.
//

import UIKit

final class PerfMonitorView: UIView {
    private lazy var monitorHelper = PerfMonitorHelper()
    
    private lazy var fpsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        return label
    }()

    private lazy var cpuLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        return label
    }()

    private lazy var memLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            fpsLabel, cpuLabel, memLabel
        ])
        
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
             
    static let shared = PerfMonitorView()
    
    override init(frame: CGRect) {
        let frame = CGRect(x: 0, y: 200, width: 88, height: 56)
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        backgroundColor = UIColor(white: 0.3, alpha: 1)
        
        clipsToBounds = true
        isUserInteractionEnabled = true
        isHidden = true
        accessibilityIdentifier = "PerformanceMonitorView"
                
        setupGestures()
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestures() {
        
        let pan = UIPanGestureRecognizer(target: self,
                                         action: #selector(onPan(_:)))
        addGestureRecognizer(pan)
        
        let longPress = UILongPressGestureRecognizer(target: self,
                                                     action: #selector(onLongPress(_:)))
        longPress.minimumPressDuration = 2
        addGestureRecognizer(longPress)
    }
    
    private func setupSubviews() {
        
        addSubview(stackView)
        stackView.edgesEqual(to: self,
                             with: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))

    }
    
    func toggle() {
        
        if isHidden {
            isHidden = false
            monitorHelper.beginTracking { [weak self] in
                guard let self = self else { return }
                self.fpsLabel.text = String(format:"FPS: %@", $0[.fps]!)
                self.cpuLabel.text = String(format:"CPU: %@%%", $0[.cpu]!)
                self.memLabel.text = String(format:"MEM: %@MB", $0[.mem]!)
            }
        }
        else {
            isHidden = true
            monitorHelper.stopTracking()
        }
    }
}

@objc
private extension PerfMonitorView {
    
    func onPan(_ sender: UIPanGestureRecognizer) {
        let transPoint = sender.translation(in: superview)
        center = CGPoint(x: center.x + transPoint.x, y: center.y + transPoint.y)
        sender.setTranslation(.zero, in: superview)

        if sender.state == .ended {
            
            var location = center

            let offsetX = bounds.width * 0.5
            let offsetY = bounds.height * 0.5
            
            let superview = superview!
            let superviewWidth = superview.bounds.width
            let superviewHeight = superview.bounds.height
            let safeAreaInsets = superview.safeAreaInsets

            if location.x > superviewWidth * 0.5 {
                location.x = superviewWidth - offsetX
            }
            else {
                location.x = offsetX
            }
            
            let minimumY = safeAreaInsets.top + offsetY
            let maximumY = superviewHeight - offsetY - safeAreaInsets.bottom

            location.y = min(max(minimumY, location.y), maximumY)
            
            UIView.animate(withDuration: 0.5) {
                self.center = location
            }
        }
    }
            
    func onLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            impactFeedback(.heavy)
            toggle()
        }
    }
}
