//
//  UIImage.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 21/06/2016.
//  Copyright © 2016 Matthew Quiros. All rights reserved.
//

import UIKit

extension UIImage {
	
	/// Creates a 1x1 image of a color, intended for tiling.
  class func imageFromColor(_ color: UIColor) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
	
	/// Takes a screenshot of a view.
  class func imageFromView(_ view: UIView) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
    guard let context = UIGraphicsGetCurrentContext()
      else {
        return nil
    }
    
    view.layer.render(in: context)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
	
	/// Creates a `UIImage` from a template asset (i.e. a PDF file).
  class func template(named name: String) -> UIImage? {
    return UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
  }
  
}
