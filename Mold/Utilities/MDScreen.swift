//
//  MDScreen.swift
//  Mold
//
//  Created by Matt Quiros on 17/06/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

public enum MDScreen {
    
    case iPhone4, iPhone5, iPhone6, iPhone6p
    
    /**
     Returns the device type given the current screen size.
     */
    public static func currentScreen() -> MDScreen {
        let nativeSize = UIScreen.main.nativeBounds.size
        let nativeScale = UIScreen.main.nativeScale
        let size = CGSize(width: nativeSize.width / nativeScale, height: nativeSize.height / nativeScale)
        switch (size.width, size.height) {
        case (320, 480):
            return .iPhone4
            
        case (320, 568):
            return .iPhone5
            
        case (375, 667):
            return .iPhone6
            
        case (414, 736):
            return .iPhone6p
            
        default:
            fatalError()
        }
    }
    
    /**
     Returns whether the current screen is any of the supplied devices.
     */
    public static func currentScreenIs(_ possibleScreens: MDScreen ...) -> Bool {
        for screen in possibleScreens {
            if MDScreen.currentScreen() == screen {
                return true
            }
        }
        return false
    }
    
}
