//
//  UIImage.swift
//  Mold
//
//  Created by Matt Quiros on 21/06/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public class func imageFromColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public class func imageFromView(view: UIView) -> UIImage? {
        if let context = UIGraphicsGetCurrentContext() {
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0)
            view.layer.renderInContext(context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
    
}