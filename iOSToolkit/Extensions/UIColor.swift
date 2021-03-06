//
//  UIColor.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 4/16/15.
//  Copyright (c) 2015 Matthew Quiros. All rights reserved.
//

import UIKit

extension UIColor {
	
	/// Initializes a color from a hex code.
  convenience init(hex: Int) {
    let red = CGFloat((hex & 0xff0000) >> 16) / 255.0
    let green = CGFloat((hex & 0x00ff00) >> 8) / 255.0
    let blue = CGFloat(hex & 0x0000ff) / 255.0
    self.init(red: red, green: green, blue: blue, alpha: 1.0)
  }
	
	/// Generates a random color.
  class func randomColor() -> UIColor {
    return UIColor(hex: UIColor.randomHex())
  }
	
	/// Generates a random hex code.
  class func randomHex() -> Int {
    return Int(arc4random_uniform(0xffffff + 1))
  }
	
	/// Returns the hex code of a color.
  func hexValue() -> Int {
    var red = CGFloat(0)
    var green = CGFloat(0)
    var blue = CGFloat(0)
    var alpha = CGFloat(0)
    
    if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
      return (Int(red * 255) << 16) | (Int(green * 255) << 8) | Int(blue * 255)
    }
    
    return 0x000000
  }
  
}
