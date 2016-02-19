//
//  MQError.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 4/19/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public let kMQGenericErrorCode: Int = -1

public class MQError: NSError {
    
    public var message: String
    
    public override var localizedDescription: String {
        return self.message
    }
    
    public init(_ message: String) {
        self.message = message
        
        // Set the error's domain property.
        let domain = NSBundle.mainBundle().bundleIdentifier ?? ""
        super.init(domain: domain, code: kMQGenericErrorCode, userInfo: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
