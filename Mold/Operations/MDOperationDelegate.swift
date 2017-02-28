//
//  MDOperationDelegate.swift
//  Mold
//
//  Created by Matt Quiros on 22/02/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

public protocol MDOperationDelegate {
    
    func operationWillRunStartBlock(_ operation: MDOperation)
    func operation(_ operation: MDOperation, didRunSuccessBlockWithResult result: Any?)
    func operation(_ operation: MDOperation, didRunFailureBlockWithError error: Error)
    
}

public extension MDOperationDelegate {
    
    func operationWillRunStartBlock(_ operation: MDOperation) {}
    func operation(_ operation: MDOperation, didRunSuccessBlockWithResult result: Any?) {}
    func operation(_ operation: MDOperation, didRunFailureBlockWithError error: Error) {}
    
}
