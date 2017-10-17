//
//  MDOperation.swift
//  Mold
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

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
    
    public var runSuccessBlockInMainThread = true
    
    
    /// Contains the tasks that must be executed when this operation succeeds.
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
            BRErrorDialog.showError(error, from: presentingViewController)
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
    
    public func runSuccessBlock(result: ResultType) {
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
