//
//  NSLayoutConstraint.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 4/17/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public extension NSLayoutConstraint {
    
    public class func constraintsWithVisualFormatArray(array: [String], metrics: [String: AnyObject]?, views: [String: AnyObject]) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        for rule in array {
            constraints.appendContentsOf(self.constraintsWithVisualFormat(rule,
                options: .DirectionLeadingToTrailing,
                metrics: metrics,
                views: views) )
        }
        
        return constraints
    }
    
}