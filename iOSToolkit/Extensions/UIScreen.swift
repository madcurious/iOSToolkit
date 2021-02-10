//
//  UIScreen.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 06/06/2017.
//  Copyright © 2017 Matthew Quiros. All rights reserved.
//

import UIKit

extension UIScreen {
	
	/// Returns the size of the screen in points and in portrait-up orientation.
  var nativeSize: CGSize {
    return CGSize(width: self.nativeBounds.size.width / self.nativeScale,
                  height: self.nativeBounds.size.height / self.nativeScale)
  }
  
}
