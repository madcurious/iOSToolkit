//
//  MQNSNotificationObject.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 8/3/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

/**
Acts as a wrapper to any value that you wish to send together with your `NSNotification`.
This is useful for sending Swift value types, especially since notification objects need
to be an `NSObject`.
*/
public class MQNSNotificationObject: NSObject {
    
    /**
    The value that you want to associate with an `NSNotification`.
    */
    public var value: Any
    
    public init(value: Any) {
        self.value = value
    }
    
}