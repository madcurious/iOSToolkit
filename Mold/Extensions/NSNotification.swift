//
//  NSNotification.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 27/01/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

public extension NSNotification {
    
    public var payload: AnyObject? {
        return self.userInfo?[MQNSNotificationPayloadKey]
    }
    
    public convenience init(name: String, payload: AnyObject) {
        self.init(name: name, object: nil, userInfo: [MQNSNotificationPayloadKey : payload])
    }
    
}