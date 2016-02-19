//
//  MQButton.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 6/8/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

/**
A custom button implementation where you can just set the background color
which is automatically darkened when pressed. If you want a label or an image
in the button, you can use `MQLabelButton` or `MQImageButton` instead, respectively.
*/
public class MQButton: UIControl {
    
    /**
    The view that is used to darken the entire button when pressed.
    */
    public var overlayView: UIView = {
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.blackColor()
        overlayView.alpha = 0.3
        overlayView.userInteractionEnabled = false
        return overlayView
    }()
    
    /**
    The custom view for the button. If you want to put a label or an image
    in the button, subclass `MQButton` and make your label or image a filling
    subview of `customView`.
    */
    public var customView: UIView = {
        let customView = UIView()
        customView.backgroundColor = UIColor.clearColor()
        customView.userInteractionEnabled = false
        return customView
    }()
    
    public init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.clearColor()
        self.addSubviewsAndFill(self.customView, self.overlayView)
        
        // Initially, the darkView shouldn't be showing.
        self.overlayView.hidden = true
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        self.overlayView.hidden = false
        return true
    }
    
    public override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        self.overlayView.hidden = true
    }
    
    public override func cancelTrackingWithEvent(event: UIEvent?) {
        self.overlayView.hidden = true
    }
    
}