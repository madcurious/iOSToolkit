//
//  MDOperation.swift
//  Mold
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

open class MDOperation: Operation {
    
    public var startBlock: (() -> ())?
    public var returnBlock: (() -> ())?
    public var successBlock: ((Any?) -> ())?
    public var failureBlock: ((Error) -> ())?
    
    public var delegate: MDOperationDelegate?
    
    public var presentsErrorDialogOnFailure = false
    
    /**
     Determines whether the operation, after determining success or fail, should execute the `returnBlock`
     before the `successBlock` or `failBlock` runs its logic. If you manually set this to `false` because
     you want to do something else in the success or fail block, you will have to run the `returnBlock` yourself in your code.
     */
    open var shouldRunReturnBlockBeforeSuccessOrFail = true
    
    // MARK: Internal state variables
    
    fileprivate var _executing = false
    fileprivate var _finished = false
    
    // MARK: NSOperation required overrides
    
    open override var isConcurrent: Bool {
        return true
    }
    
    open override var isAsynchronous: Bool {
        return true
    }
    
    open override var isExecuting: Bool {
        return self._executing
    }
    
    open override var isFinished: Bool {
        return self._finished
    }
    
    // MARK: Builders
    
    @discardableResult
    public func setStartBlock(to startBlock: @escaping () -> ()) -> Self {
        self.startBlock = startBlock
        return self
    }
    
    @discardableResult
    public func setReturnBlock(to returnBlock: @escaping () -> ()) -> Self {
        self.returnBlock = returnBlock
        return self
    }
    
    @discardableResult
    public func setSuccessBlock(to successBlock: @escaping (Any?) -> ()) -> Self {
        self.successBlock = successBlock
        return self
    }
    
    
    @discardableResult
    public func setFailureBlock(to failureBlock: @escaping (Error) -> ()) -> Self {
        self.failureBlock = failureBlock
        return self
    }
    
    public func chain(if condition: ((Any?) -> Bool)? = nil, operationBuilder: @escaping ((Any?) -> MDOperation)) -> MDChainedOperation {
        if let thisOperation = self as? MDChainedOperation {
            thisOperation.chain(if: condition, operationBuilder: operationBuilder)
            return thisOperation
        } else {
            let chainedOperation = MDChainedOperation(head: self)
            chainedOperation.isInitializedFromOperation = true
            chainedOperation.chain(if: condition, operationBuilder: operationBuilder)
            return chainedOperation
        }
    }
    
    public func chain(operation: MDOperation) -> MDChainedOperation {
        return self.chain(operationBuilder: { _ in return operation })
    }
    
    /**
     Convenience function for setting a `failBlock` that just shows an error dialog
     in a presenting view controller.
     */
    @discardableResult
    open func setFailureBlockToPresentErrorDialog(from presentingViewController: UIViewController) -> Self {
        self.presentsErrorDialogOnFailure = true
        self.failureBlock = {[unowned presentingViewController] (error) in
            MDErrorDialog.showError(error, from: presentingViewController)
        }
        return self
    }
    
    open func makeResult(fromSource source: Any?) throws -> Any? {
        return nil
    }
    
    // MARK: Functions
    
    open override func start() {
        if self.isCancelled {
            self.willChangeValue(forKey: "isFinished")
            self._finished = true
            self.didChangeValue(forKey: "isFinished")
            return
        }
        
        self.willChangeValue(forKey: "isExecuting")
        Thread.detachNewThreadSelector(#selector(main), toTarget: self, with: nil)
        self._executing = true
        self.didChangeValue(forKey: "isExecuting")
    }
    
    open override func main() {
        defer {
            self.closeOperation()
        }
        
        self.runStartBlock()
        
        if self.isCancelled {
            return
        }
        
        do {
            let result = try self.makeResult(fromSource: nil)
            if self.isCancelled {
                return
            }
            self.runSuccessBlock(result)
        } catch {
            self.runFailureBlock(error)
        }
    }
    
    open func closeOperation() {
        if self.isCancelled == false {
//            self.runFinishBlock()
        }
        
        self.willChangeValue(forKey: "isExecuting")
        self.willChangeValue(forKey: "isFinished")
        
        self._executing = false
        self._finished = true
        
        self.didChangeValue(forKey: "isExecuting")
        self.didChangeValue(forKey: "isFinished")
    }
    
    open func runStartBlock() {
        guard let startBlock = self.startBlock
            else {
                return
        }
        
        if self.delegate == nil ||
            self.delegate?.operationShouldRunStartBlockInMainThread(self) == true {
            MDDispatcher.asyncRunInMainThread(startBlock)
        } else {
            startBlock()
        }
    }
    
    open func runReturnBlock() {
        guard let returnBlock = self.returnBlock
            else {
                return
        }
        
        if self.delegate == nil ||
            self.delegate?.operationShouldRunReturnBlockInMainThread(self) == true {
            MDDispatcher.asyncRunInMainThread(returnBlock)
        } else {
            returnBlock()
        }
    }
    
    open func runSuccessBlock(_ result: Any?) {
        if self.shouldRunReturnBlockBeforeSuccessOrFail {
            self.runReturnBlock()
        }
        
        guard let successBlock = self.successBlock
            else {
                return
        }
        
        if self.delegate == nil ||
            self.delegate?.operationShouldRunSuccessBlockInMainThread(self) == true {
            MDDispatcher.asyncRunInMainThread {[unowned self] in
                successBlock(result)
                if let delegate = self.delegate {
                    delegate.operation(self, didRunSuccessBlockWithResult: result)
                }
            }
        } else {
            successBlock(result)
            if let delegate = self.delegate {
                delegate.operation(self, didRunSuccessBlockWithResult: result)
            }
        }
    }
    
    open func runFailureBlock(_ error: Error) {
        if self.shouldRunReturnBlockBeforeSuccessOrFail {
            self.runReturnBlock()
        }
        
        guard let failureBlock = self.failureBlock
            else {
                return
        }
        
        if self.presentsErrorDialogOnFailure == true ||
            self.delegate == nil ||
            self.delegate?.operationShouldRunFailureBlockInMainThread(self, withError: error) == true {
            MDDispatcher.asyncRunInMainThread({[unowned self] in
                failureBlock(error)
                if let delegate = self.delegate {
                    delegate.operation(self, didRunFailureBlockWithError: error)
                }
            })
        } else {
            failureBlock(error)
            if let delegate = self.delegate {
                delegate.operation(self, didRunFailureBlockWithError: error)
            }
        }
    }
    
//    open func runFinishBlock() {
//        guard let finishBlock = self.finishBlock
//            else {
//                return
//        }
//        
//        if finishBlock.runsInMainThread {
//            MDDispatcher.syncRunInMainThread(finishBlock.block)
//        } else {
//            finishBlock.block()
//        }
//    }
    
}
