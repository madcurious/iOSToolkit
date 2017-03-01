//
//  MDOperation.swift
//  Mold
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

open class MDOperation: Operation {
    
    public var startBlock: MDOperationCallbackBlock?
    public var returnBlock: MDOperationCallbackBlock?
    public var successBlock: MDOperationSuccessBlock?
    public var failureBlock: MDOperationFailureBlock?
    
    public var result: Any?
    public var error: Error?
    
    /**
     Determines whether the operation should execute once it enters `main()`. The default value is `true`.
     
     You can override this variable as a computed property, for example, to determine whether
     an operation should execute depending on the result or error produced by the operations
     it is dependent on.
     */
    open var shouldExecute = true
    
    open override func main() {
        if self.shouldExecute == false {
            return
        }
        
        self.runStartBlock()
        
        if self.isCancelled {
            return
        }
        
        do {
            self.result = try self.makeResult(from: nil)
            
            if self.isCancelled {
                return
            }
            
            self.runSuccessBlock()
        } catch {
            self.error = error
            
            if self.isCancelled {
                return
            }
            
            self.runFailureBlock()
        }
    }
    
    open func makeResult(from source: Any?) throws -> Any? {
        return nil
    }
    
    /// Overrides the `failureBlock` to show an error dialog in a presenting view controller when an error occurs.
    @discardableResult
    open func presentErrorDialogOnFailure(from presentingViewController: UIViewController) -> Self {
        self.failureBlock = MDOperationFailureBlock(block: {[unowned presentingViewController] (error) in
            MDErrorDialog.showError(error, from: presentingViewController)
        })
        return self
    }

    
    public func runStartBlock() {
        guard let startBlock = self.startBlock
            else {
                return
        }
        
        if startBlock.runsInMainThread {
            MDDispatcher.asyncRunInMainThread {
                startBlock.block()
            }
        } else {
            startBlock.block()
        }
    }
    
    public func runReturnBlock() {
        guard let returnBlock = self.returnBlock,
            
            // To run the return block, all of its dependencies must have finished already.
            self.dependencies.filter({ $0.isFinished }).count == self.dependencies.count
            else {
                return
        }
        
        if returnBlock.runsInMainThread {
            MDDispatcher.asyncRunInMainThread {
                returnBlock.block()
            }
        } else {
            returnBlock.block()
        }
    }
    
    public func runSuccessBlock() {
        self.runReturnBlock()
        
        guard let successBlock = self.successBlock
            else {
                return
        }
        
        if successBlock.runsInMainThread {
            MDDispatcher.asyncRunInMainThread {[unowned self] in
                successBlock.block(self.result)
            }
        } else {
            successBlock.block(self.result)
        }
    }
    
    public func runFailureBlock() {
        self.runReturnBlock()
        
        guard let failureBlock = self.failureBlock
            else {
                return
        }
        
        assert(self.error != nil, "Attempted to execute 'self.failureBlock' but 'self.error' is not assigned.")
        
        if failureBlock.runsInMainThread {
            MDDispatcher.asyncRunInMainThread {[unowned self] in
                failureBlock.block(self.error!)
            }
        } else {
            failureBlock.block(self.error!)
        }
    }
    
}
