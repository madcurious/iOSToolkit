//
//  MDChainedOperation.swift
//  Mold
//
//  Created by Matt Quiros on 04/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

private struct Link {
    var condition: ((Any?) -> Bool)
    var configurator: ((Any?) -> MDOperation)?
}

/**
 Creates a chain of `MDOperation`s. Each link in the chain may be conditionally executed depending
 on the results of the previous operation.
 
 All operations in the chain share the chain's callback blocks except for the `successBlock`,
 which is provided by the individual operations in the chain. The chain itself is not meant to have a
 `successBlock` of its own. Instead, the last operation in the chain defines the success for the entire chain.
 
 There are two ways to create a chain:
    1. Call an initializer of this class and set the shared callback blocks yourself.
    2. Create an `MDOperation` which serves as the chain's head, then call that operation's `chain()` function.
       The chain takes the head's callback blocks (except for the `successBlock`) to be shared by the entire chain.
 
 Operations are chained on the fly, i.e., when the chain itself is executed and every operation in the link
 executes its own `successBlock`.
 
 */
public class MDChainedOperation: MDOperation {
    
    private var queue = OperationQueue()
    private var links = [Link]()
    private var currentIndex = 0
    
    /**
     Determines whether the `MDChainedOperation` was instantiated through a call to its own init,
     or through calling the `chain()` function from an `MDOperation`. If it is the latter, then the chain
     takes the very first operation's callback blocks (except for the `successBlock`) for the whole chian.
     */
    public var isInitializedFromOperation = false
    
    override init() {
        super.init()
        
        // We need to decide on the fly whether the returnBlock will be executed already
        // or another operation is to be appended into the chain.
        self.shouldRunReturnBlockBeforeSuccessOrFail = false
    }
    
    public func chain(if condition: @escaping ((Any?) -> Bool) = {_ in return true}, configure configurator: ((Any?) -> MDOperation)? = nil) -> MDChainedOperation {
        self.links.append(Link(condition: condition, configurator: configurator))
        return self
    }
    
    private func configureOperation(_ operation: MDOperation, operationIndex: Int) {
        // Don't let the operation execute its own returnBlock.
        // It actually won't be able to do so because we set its returnBlock to nil,
        // but it's better to be absolutely sure it won't happen.
        operation.shouldRunReturnBlockBeforeSuccessOrFail = false
        
        // If the chain was initialized from a head `MDOperation`, copy the head's callback blocks
        // (except the successBlock) for the use of the entire chain.
        if self.isInitializedFromOperation && operationIndex == 0 {
            self.startBlock = operation.startBlock
            operation.startBlock = nil
            
            self.returnBlock = operation.returnBlock
            operation.returnBlock = nil
            
            self.failBlock = operation.failBlock
            operation.failBlock = nil
            
            self.finishBlock = operation.finishBlock
            operation.finishBlock = nil
        }
        
        // If the operation fails, it should execute the chain's failBlock.
        operation.failBlock = {[unowned self] error in
            self.runReturnBlock()
            self.runFailBlock(error)
        }
        
        // If the operation succeeds, it should append the next operation,
        // or terminate the whole chain if there are no more succeeding links.
        let originalSuccessBlock = operation.successBlock
        operation.successBlock = {[unowned self] result in
            let nextIndex = operationIndex + 1
            if nextIndex < self.links.count,
                self.links[nextIndex].condition(result) == true,
                let nextOperation = self.links[nextIndex].configurator?(result) {
                
                originalSuccessBlock?(result)
                self.configureOperation(nextOperation, operationIndex: nextIndex)
                self.queue.addOperation(nextOperation)
            }
            
            else {
                self.runReturnBlock()
                originalSuccessBlock?(result)
            }
        }
    }
    
    public override func main() {
        defer {
            self.closeOperation()
        }
        
        self.runStartBlock()
        
        if self.isCancelled {
            return
        }
        
        guard let firstOperation = self.links.first?.configurator?(nil)
            else {
                return
        }
        
        self.configureOperation(firstOperation, operationIndex: 0)
        
        self.queue.addOperation(firstOperation)
        self.queue.waitUntilAllOperationsAreFinished()
    }
    
    /*
     
    var operations = [MDOperation]()
     
    open func append<T: MDOperation>(_ operation: T, validator: ((Any?) -> Bool)? = nil, configurator: ((T, Any?) -> Void)? = nil) {
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
    
    open override func main() {
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
     
 */
    
}
