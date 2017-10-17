//
//  UIColor.swift
//  Mold
//
//  Created by Matt Quiros on 4/16/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience init(hex: Int) {
        let red = CGFloat((hex & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00ff00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000ff) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    public class func randomColor() -> UIColor {
        return UIColor(hex: UIColor.randomHex())
    }
    
    public class func randomHex() -> Int {
        return Int(arc4random_uniform(0xffffff + 1))
    }
    
    public func hexValue() -> Int {
        var red = CGFloat(0)
        var green = CGFloat(0)
        var blue = CGFloat(0)
        var alpha = CGFloat(0)
        
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (Int(red * 255) << 16) | (Int(green * 255) << 8) | Int(blue * 255)
        }
        
        return 0x000000
    }
    
    public class func hex(_ hex: Int) -> UIColor {
        return UIColor(hex: hex)
    }
    
}
