//
//  UIScreen.swift
//  Bedrock
//
//  Created by Matt Quiros on 06/06/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

public extension UIScreen {
  
  var nativeSize: CGSize {
    return CGSize(width: self.nativeBounds.size.width / self.nativeScale,
                  height: self.nativeBounds.size.height / self.nativeScale)
  }
  
}
