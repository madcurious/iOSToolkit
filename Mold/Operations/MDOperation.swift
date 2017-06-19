//
//  MDOperation.swift
//  Mold
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

/**
 An `NSOperation` subclass that has callback blocks which may be invoked at different
 points of the operation's execution. An `MDOperation` is defined to be synchronous. For
 an asynchronous version, see `MDAsynchronousOperation`.
 */
open class MDOperation<ResultType>: Operation {
    
    public var result: ResultType?
    public var error: Error?
    
    public var runStartBlockInMainThread = true
    public var startBlock: (() -> ())?
    
    public var runReturnBlockInMainThread = true
    public var returnBlock: (() -> ())?
    
    public var runSuccessBlockInMainThread = true
    
    /**
     Contains the tasks that must be executed when this operation succeeds.
     
     If you want to start another operation when this operation succeeds, **DO NOT** create and start
     the next operation from within this operation's `successBlock`. Instead, instantiate the next operation
     externally and make it dependent on this operation. If the next operation is an `MDOperation`, then
     it will check for any dependencies where `finishedSuccessfully` is `false` and it will
     automatically not proceed with execution.
     */
    public var successBlock: ((ResultType) -> ())?
    
    public var runFailureBlockInMainThread = true
    public var failureBlock: ((Error) -> ())?
    
    /// Determines whether the operation finished by executing the `successBlock`.
    /// If an error occurs at any point in the operation and `runFailureBlock` is called, this property
    /// is automatically set to `false`.
    open var finishedSuccessfully = true
    
    /// Determines whether this operation has any dependencies which is an
    /// `MDOperation` and whose `finishedSuccessfully` is `false`. Returns `false` if all
    /// dependencies finished sucessfully, or if none of the dependencies are `MDOperation`s.
    var hasFailedDependencies: Bool {
        return self.dependencies.contains(where: { $0 is MDOperation &&
            ($0 as! MDOperation).finishedSuccessfully == false })
    }
    
    /**
     Determines whether the operation should execute once it enters `main()`. This function is meant
     to be overridden so that you may decide whether to proceed with the operation based on a condition.
     The default behavior returns `true`. If you return `false`, none of the callback blocks will be
     executed.
     */
    open func shouldExecute() -> Bool {
        return true
    }
    
    open override func main() {
        if self.hasFailedDependencies || self.shouldExecute() == false {
            return
        }
        
        self.runStartBlock()
        
        if self.isCancelled {
            return
        }
        
        do {
            let result = try self.makeResult(from: nil)
            self.result = result
            if self.isCancelled {
                return
            }
            self.runSuccessBlock(result: result)
        } catch {
            self.error = error
            if self.isCancelled {
                return
            }
            self.runFailureBlock(error: error)
        }
    }
    
    open func makeResult(from source: Any?) throws -> ResultType {
        fatalError("Unimplemented: \(#function)")
    }
    
    // MARK: Builders
    
    /// Overrides the `failureBlock` to show an error dialog in a presenting view controller when an error occurs.
    @discardableResult
    open func presentErrorDialogOnFailure(from presentingViewController: UIViewController) -> Self {
        self.failureBlock = {[unowned presentingViewController] (error) in
            MDErrorDialog.showError(error, from: presentingViewController)
        }
        return self
    }
    
    // MARK: Block runners
    
    public func runStartBlock() {
        guard let startBlock = self.startBlock
            else {
                return
        }
        
        if self.runStartBlockInMainThread == true {
            MDDispatcher.asyncRunInMainThread {
                startBlock()
            }
        } else {
            startBlock()
        }
    }
    
    public func runReturnBlock() {
        guard let returnBlock = self.returnBlock,
            
            // To run the return block, all of its dependencies must have finished already.
            self.dependencies.filter({ $0.isFinished }).count == self.dependencies.count
            else {
                return
        }
        
        if self.runReturnBlockInMainThread == true {
            MDDispatcher.asyncRunInMainThread {
                returnBlock()
            }
        } else {
            returnBlock()
        }
    }
    
    public func runSuccessBlock(result: ResultType) {
        self.runReturnBlock()
        
        guard let successBlock = self.successBlock
            else {
                return
        }
        
        if self.runSuccessBlockInMainThread == true {
            MDDispatcher.syncRunInMainThread {
                successBlock(result)
            }
        } else {
            successBlock(result)
        }
    }
    
    public func runFailureBlock(error: Error) {
        self.finishedSuccessfully = false
        self.runReturnBlock()
        
        guard let failureBlock = self.failureBlock
            else {
                return
        }
        
        if self.runFailureBlockInMainThread == true {
            MDDispatcher.asyncRunInMainThread {
                failureBlock(error)
            }
        } else {
            failureBlock(error)
        }
    }
    
}
