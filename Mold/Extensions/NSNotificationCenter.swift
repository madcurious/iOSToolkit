//
//  NSNotificationCenter.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 28/01/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

public extension NSNotificationCenter {
    
    public func postNotificationName(name: String, payload: AnyObject?) {
        if let payload = payload {
            self.postNotification(NSNotification(name: name, payload: payload))
        } else {
            self.postNotificationName(name, object: nil)
        }
    }
    
    public func postNotificationName(name: String) {
        self.postNotificationName(name, object: nil, userInfo: nil)
    }
    
}