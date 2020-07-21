//
//  UIScreen.swift
//  iOSToolkit
//
//  Created by Matt Quiros on 06/06/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

extension UIScreen {
	
	/// Returns the size of the screen in points and in portrait-up orientation.
  var nativeSize: CGSize {
    return CGSize(width: self.nativeBounds.size.width / self.nativeScale,
                  height: self.nativeBounds.size.height / self.nativeScale)
  }
  
}
