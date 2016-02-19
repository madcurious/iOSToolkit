//
//  UIView.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 4/15/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public extension UIView {
    
    public class func disableAutoresizingMasksInViews(views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    /**
    Adds multiple subviews in order. Later arguments are placed on top of the views
    preceding them.
    */
    public func addSubviews(views: UIView ...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    public func addSubviewsAndFill(views: UIView ...) {
        for view in views {
            self.addSubviewAndFill(view)
        }
    }
    
    public func addSubviewAndFill(view: UIView) {
        self.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["view" : view]
        let rules = ["H:|-0-[view]-0-|",
            "V:|-0-[view]-0-|"]
        self.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormatArray(rules,
                metrics: nil,
                views: views))
    }
    
    public func fillSuperview() {
        if let superview = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            let views = ["view" : self]
            let rules = ["H:|-0-[view]-0-|",
                "V:|-0-[view]-0-|"]
            superview.addConstraints(
                NSLayoutConstraint.constraintsWithVisualFormatArray(rules,
                    metrics: nil,
                    views: views))
        }
    }
    
    public class func instantiateFromNib<T: UIView>() -> T {
        return self.instantiateFromNibInBundle(NSBundle.mainBundle())
    }
    
    public class func clearBackgroundColors(views: UIView...) {
        for view in views {
            view.backgroundColor = UIColor.clearColor()
        }
    }
    
    class func instantiateFromNibInBundle<T: UIView>(bundle: NSBundle) -> T {
        if let objects = bundle.loadNibNamed(self.className(), owner: self, options: nil) {
            if let view = objects.last as? T {
                return view
            }
            fatalError("\(__FUNCTION__): Cannot cast view object to \(T.classForCoder())")
        }
        fatalError("\(__FUNCTION__): No nib named \'\(self.className())\'")
    }
    
    public class func nib() -> UINib {
        return UINib(nibName: self.className(), bundle: NSBundle.mainBundle())
    }
    
    class func nibInBundle(bundle: NSBundle) -> UINib {
        return UINib(nibName: self.className(), bundle: bundle)
    }
    
    /**
    Returns the name of this class based on a (poor?) assumption that it is the last
    token in the fully qualified class name assigned by Swift.
    */
    class func className() -> String {
        let description = self.classForCoder().description()
        if let className = description.componentsSeparatedByString(".").last {
            return className
        }
        fatalError("\(__FUNCTION__): This method no longer works for getting the Swift class name.")
    }
    
}