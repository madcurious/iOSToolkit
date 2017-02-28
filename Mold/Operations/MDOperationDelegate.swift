//
//  MDOperationDelegate.swift
//  Mold
//
//  Created by Matt Quiros on 22/02/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

public protocol MDOperationDelegate {
    
    func operationShouldRunStartBlockInMainThread(_ operation: MDOperation) -> Bool
    func operationShouldRunReturnBlockInMainThread(_ operation: MDOperation) -> Bool
    func operationShouldRunSuccessBlockInMainThread(_ operation: MDOperation) -> Bool
    func operationShouldRunFailureBlockInMainThread(_ operation: MDOperation, withError error: Error) -> Bool
    
    func operationWillRunStartBlock(_ operation: MDOperation)
    func operation(_ operation: MDOperation, didRunSuccessBlockWithResult result: Any?)
    func operation(_ operation: MDOperation, didRunFailureBlockWithError error: Error)
    
}

public extension MDOperationDelegate {
    
    func operationShouldRunStartBlockInMainThread(_ operation: MDOperation) -> Bool {
        return true
    }
    
    func operationShouldRunReturnBlockInMainThread(_ operation: MDOperation) -> Bool {
        return true
    }
    
    func operationShouldRunSuccessBlockInMainThread(_ operation: MDOperation) -> Bool {
        return true
    }
    
    func operationShouldRunFailureBlockInMainThread(_ operation: MDOperation, withError error: Error) -> Bool {
        return true
    }
    
    func operationWillRunStartBlock(_ operation: MDOperation) {}
    func operation(_ operation: MDOperation, didRunSuccessBlockWithResult result: Any?) {}
    func operation(_ operation: MDOperation, didRunFailureBlockWithError error: Error) {}
    
}
