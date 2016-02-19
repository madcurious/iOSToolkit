//
//  MQChainedOperation.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 04/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

/**
 Notes:
 * The chain's `returnBlock` and `failBlock` overrides those of the operations in the chain.
 * The head operation's `successBlock` isn't overriden to automatically run the chain's `returnBlock`.
 */
public class MQChainedOperation: MQOperation {
    
    var queue = NSOperationQueue()
    var operations = [MQOperation]()
    
    public func append<T: MQOperation>(operation: T, validator: (Any? -> Bool)? = nil, configurator: ((T, Any?) -> Void)? = nil) {
        defer {
            self.operations.append(operation)
        }
        
        operation.startBlock = nil
        operation.returnBlock = self.returnBlock
        operation.failBlock = {[unowned self] error in
            self.runReturnBlock()
            self.runFailBlock(error)
        }
        
        if self.operations.isEmpty {
            // If this is the first operation in the chain, exit.
            // Don't override the head's success block.
            return
        }
        
        guard let tail = self.operations.last
            else {
                return
        }
        
        let tailSuccessBlock = tail.successBlock
        tail.successBlock = {[unowned self] result in
            guard validator?(result) == true || validator == nil
                else {
                    // If the validator is non-nil and returns false, then the chain should prematurely end.
                    // Run the returnBlock already and then the current operation's success logic.
                    tail.runReturnBlock()
                    tailSuccessBlock?(result)
                    return
            }
            
            tailSuccessBlock?(result)
            configurator?(operation, result)
            self.queue.addOperation(operation)
        }
    }
    
    public override func main() {
        defer {
            self.closeOperation()
        }
        
        guard let head = self.operations.first,
            let tail = self.operations.last
            else {
                return
        }
        
        // Set up the tail's successBlock to run the returnBlock before its
        // own success logic. This hasn't been set in the append() function.
        let tailSuccessBlock = tail.successBlock
        tail.successBlock = { result in
            tail.runReturnBlock()
            tailSuccessBlock?(result)
        }
        
        self.runStartBlock()
        self.queue.addOperation(head)
        self.queue.waitUntilAllOperationsAreFinished()
    }
    
}