//
//  MDError.swift
//  Mold
//
//  Created by Matt Quiros on 4/19/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public let kMDGenericErrorCode: Int = -1

open class MDError: NSError {
    
    open var message: String
    
    open override var localizedDescription: String {
        return self.message
    }
    
    public init(_ message: String) {
        self.message = message
        
        // Set the error's domain property.
        let domain = Bundle.main.bundleIdentifier ?? ""
        super.init(domain: domain, code: kMDGenericErrorCode, userInfo: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
