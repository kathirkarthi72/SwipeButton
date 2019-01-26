//
//  DrawView.swift
//  DrawButton
//
//  Created by ktrkathir on 26/01/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import UIKit

/// DrawSwitchView
@IBDesignable class SwipeButtonView: UIView {
    
    /// Radius of background view
    @IBInspectable var radius: CGFloat = 10.0
    
    /// Background hint view
    @IBInspectable var hint: String = ""
    
    /// drag image
    @IBInspectable var image: UIImage?
    
    /// state
    private var isSuccess: Bool = false
    
    /// Completion handler
    private var completionHandler: ((_ isSuccess: Bool) -> ())?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        
        setUp()
    }
    
    public var hintLabel: UILabel = UILabel()
    
    public var swipeImageView: UIImageView = UIImageView()
    
    private func setUp() {
        
        hintLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.addSubview(hintLabel)
        hintLabel.textColor = UIColor.white
        hintLabel.textAlignment = .center
        hintLabel.text = hint
        
        swipeImageView.image = image
        swipeImageView.frame = CGRect(x: 5, y: 5, width: frame.height - 10, height: frame.height - 10)
        swipeImageView.backgroundColor = UIColor.white
        swipeImageView.layer.cornerRadius = (frame.height - 10) / 2
        swipeImageView.layer.borderColor = UIColor.clear.cgColor
        swipeImageView.layer.borderWidth = 5
        self.addSubview(swipeImageView)
        swipeImageView.isUserInteractionEnabled = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if let touch = touches.first, swipeImageView == touch.view {
            let touchedPosition = touch.location(in: self)
            
            let alpha = (1.0 -  touchedPosition.x / frame.width)
            swipeImageView.alpha = alpha
            
            if touchedPosition.x > (frame.height/2) {
                swipeImageView.center = CGPoint(x: touchedPosition.x, y: swipeImageView.frame.midY)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let touch = touches.first, swipeImageView == touch.view {
            // let touchedPosition = touch.location(in: self)
            setToDefault()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if let touch = touches.first, swipeImageView == touch.view {
            setToDefault()
        }
    }
    
    /// Set to default
    private func setToDefault() {
        
        if self.frame.midX > swipeImageView.center.x { // Move to initial
            UIView.animate(withDuration: 0.25, animations: {
                self.swipeImageView.frame.origin = CGPoint(x: 5, y: 5)
                self.swipeImageView.alpha = 1.0
            }) { (isFinished) in
                if isFinished {
                    self.isSuccess = false
                    
                    if let complete = self.completionHandler {
                        complete(self.isSuccess)
                    }
                }
            }
        } else if self.frame.midX < swipeImageView.center.x { // Move to final
            let xPosi = self.frame.width - (self.swipeImageView.frame.width + 5)
            
            UIView.animate(withDuration: 0.25, animations: {
                self.swipeImageView.frame.origin = CGPoint(x: xPosi, y: 5)
                self.swipeImageView.alpha = 0.1
            }) { (isFinished) in
                if isFinished {
                    self.isSuccess = true
                    
                    if let complete = self.completionHandler {
                        complete(self.isSuccess)
                    }
                }
            }
        }
    }
    
    /// Handle action
    ///
    /// - Parameter completed: with completion
    public func handleAction(_ completed: @escaping((_ isSuccess: Bool) -> ()) ) {
        completionHandler = completed
    }
    
    /// Update hint value
    ///
    /// - Parameter text: by string
    public func updateHint(text: String) {
        hintLabel.text = text
    }
    
}
