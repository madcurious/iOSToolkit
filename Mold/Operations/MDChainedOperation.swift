//
//  MDChainedOperation.swift
//  Mold
//
//  Created by Matt Quiros on 04/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

private class Link {
    
    var condition: ((Any?) -> Bool)
    var operationBuilder: ((Any?) -> MDOperation)
    var next: Link?
    
    init(condition: ((Any?) -> Bool)? = nil, operationBuilder: @escaping ((Any?) -> MDOperation)) {
        if let condition = condition {
            self.condition = condition
        } else {
            self.condition = { _ in return true }
        }
        self.operationBuilder = operationBuilder
    }
    
    convenience init(operation: MDOperation) {
        self.init(operationBuilder: { _ in return operation })
    }
    
}

/**
 Creates a chain of `MDOperation`s. Each link in the chain may be conditionally executed depending
 on the results of the previous operation.
 
 There are two ways to create a chain:
    1. Call an initializer of this class and set the shared callback blocks yourself.
    2. Create an `MDOperation` which serves as the chain's head, then call that operation's `chain()` function.
 
 Operations in the chain can have their own callback blocks separate from the callback blocks of the chain itself.
 They will be executed sequentially:
    * The chain runs its `startBlock`.
    * The head operation runs its `startBlock`, `returnBlock`, 
 
 **IMPORTANT:** This class is not meant to be subclassed.
 */
final public class MDChainedOperation: MDOperation {
    
    fileprivate var queue = OperationQueue()
    private var head: Link
    private var tail: Link
    fileprivate var currentLink: Link?
    
    /**
     Determines whether the `MDChainedOperation` was instantiated through a call to its own init,
     or through calling the `chain()` function from an `MDOperation`. If it is the latter, then the chain
     takes the very first operation's callback blocks (except for the `successBlock`) for the whole chian.
     */
    public var isInitializedFromOperation = false
    
    public init(head: MDOperation) {
        self.head = Link(operation: head)
        self.tail = self.head
        super.init()
        
        // We need to decide on the fly whether the returnBlock will be executed already
        // or another operation is to be appended into the chain.
        self.shouldRunReturnBlockBeforeSuccessOrFail = false
    }
    
    @discardableResult
    public override func chain(if condition: ((Any?) -> Bool)? = nil, operationBuilder: @escaping ((Any?) -> MDOperation)) -> MDChainedOperation {
        let newLink = Link(condition: condition, operationBuilder: operationBuilder)
        self.tail.next = newLink
        return self
    }
    
    /// Extracts the operation from a link if, given the result from a previous operation,
    /// the chaining condition evaluates to true. Returns nil if the chain should terminate.
    fileprivate func makeOperation(from link: Link, with result: Any?) -> MDOperation? {
        self.currentLink = link
        
        guard link.condition(result) == true
            else {
                return nil
        }
        
        let operation = link.operationBuilder(result)
        operation.delegate = self
        return operation
    }
 
    public override func main() {
        defer {
            self.closeOperation()
        }
        
        self.runStartBlock()
        
        if self.isCancelled {
            return
        }
        
        guard let firstOperation = self.makeOperation(from: self.head, with: nil)
            else {
                return
        }
        
        self.queue.addOperation(firstOperation)
        self.queue.waitUntilAllOperationsAreFinished()
    }
    
}

extension MDChainedOperation: MDOperationDelegate {
    
    public func operation(_ operation: MDOperation, didRunSuccessBlockWithResult result: Any?) {
        guard let nextLink = self.currentLink?.next,
            let nextOperation = self.makeOperation(from: nextLink, with: result)
            else {
                self.runSuccessBlock(result)
                return
        }
        
        self.queue.addOperation(nextOperation)
    }
    
    public func operation(_ operation: MDOperation, didRunFailureBlockWithError error: Error) {
        self.runFailureBlock(error)
    }
    
}
