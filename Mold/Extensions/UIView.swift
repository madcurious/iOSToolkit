//
//  UIView.swift
//  Mold
//
//  Created by Matt Quiros on 4/15/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public extension UIView {
    
    public class func disableAutoresizingMasksInViews(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    /**
    Adds multiple subviews in order. Later arguments are placed on top of the views
    preceding them.
    */
    public func addSubviews(_ views: UIView ...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    /**
     Add subviews and fill the superview. Subviews are placed on top of the preding subviews.
     */
    public func addSubviewsAndFill(_ views: UIView ...) {
        for view in views {
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
    
    public class func instantiateFromNib() -> Self {
        return self.instantiateFromNibInBundle(Bundle.main)
    }
    
    public class func clearBackgroundColors(_ views: UIView...) {
        for view in views {
            view.backgroundColor = UIColor.clear
        }
    }
    
    public class func clearBackgroundColors(_ views: [UIView]) {
        for view in views {
            view.backgroundColor = UIColor.clear
        }
    }
    
    public func clearAllBackgroundColors() {
        UIView.clearAllBackgroundColors(from: self)
    }
    
    public class func clearAllBackgroundColors(from view: UIView) {
        if #available(iOS 9.0, *),
            let stackView = view as? UIStackView {
            for arrangedSubview in stackView.arrangedSubviews {
                clearAllBackgroundColors(from: arrangedSubview)
            }
        } else {
            view.backgroundColor = .clear
            for subview in view.subviews {
                clearAllBackgroundColors(from: subview)
            }
        }
    }
    
    public class func nib() -> UINib {
        return UINib(nibName: md_getClassName(self), bundle: Bundle.main)
    }
    
    public func viewFromNib() -> UIView {
        return self.viewFromNib(named: md_getClassName(self))
    }
    
    public func viewFromNib(named: String) -> UIView {
        let bundle = Bundle(for: self.classForCoder)
        let view = bundle.loadNibNamed(named, owner: self, options: nil)!.last as! UIView
        return view
    }
    
}

// MARK: - Private functions
extension UIView {
    
    class func instantiateFromNibInBundle<T: UIView>(_ bundle: Bundle) -> T {
        let objects = bundle.loadNibNamed(md_getClassName(self), owner: self, options: nil)!
        let view = objects.last as! T
        return view
    }
    
}
