//
//  MDOperation.swift
//  Mold
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

open class MDOperation: Operation {
    
//    public var startBlock: (runsInMainThread: Bool, block: () -> ())?
//    public var returnBlock: (runsInMainThread: Bool, block: () -> ())?
//    public var successBlock: (runsInMainThread: Bool, block: (Any?) -> ())?
//    public var failureBlock: (runsInMainThread: Bool, block: (Error) -> ())?
    
    public var startBlock: MDOperationCallbackBlock?
    public var returnBlock: MDOperationCallbackBlock?
    public var successBlock: MDOperationSuccessBlock?
    public var failureBlock: MDOperationFailureBlock?
    
    public var delegate: MDOperationDelegate?
    
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
    
//    @discardableResult
//    public func setStartBlock(runsInMainThread: Bool = true, block: @escaping () -> ()) -> Self {
//        self.startBlock = (runsInMainThread: runsInMainThread, block: block)
//        return self
//    }
//    
//    @discardableResult
//    public func setReturnBlock(runsInMainThread: Bool = true, block: @escaping () -> ()) -> Self {
//        self.returnBlock = (runsInMainThread: runsInMainThread, block: block)
//        return self
//    }
//    
//    @discardableResult
//    public func setSuccessBlock(runsInMainThread: Bool = true, block: @escaping (Any?) -> ()) -> Self {
//        self.successBlock = (runsInMainThread: runsInMainThread, block: block)
//        return self
//    }
//    
//    
//    @discardableResult
//    public func setFailureBlock(runsInMainThread: Bool = true, block: @escaping (Error) -> ()) -> Self {
//        self.failureBlock = (runsInMainThread: runsInMainThread, block: block)
//        return self
//    }
    
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
    
    /**
     Convenience function for setting a `failBlock` that just shows an error dialog
     in a presenting view controller.
     */
    @discardableResult
    open func setFailureBlockToShowErrorInPresenter(_ viewController: UIViewController) -> Self {
//        self.setFailureBlock(runsInMainThread: true,
//                             block: {[unowned viewController] error in
//                                MDErrorDialog.showError(error, inPresenter: viewController)
//        })
        self.failureBlock = MDOperationFailureBlock(runsInMainThread: true,
                                                    block: {[unowned viewController] (error) in
                                                        MDErrorDialog.showError(error, inPresenter: viewController)
        })
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
        
        if startBlock.runsInMainThread {
            MDDispatcher.syncRunInMainThread(startBlock.block)
        } else {
            startBlock.block()
        }
    }
    
    open func runReturnBlock() {
        guard let returnBlock = self.returnBlock
            else {
                return
        }
        
        if returnBlock.runsInMainThread {
            MDDispatcher.syncRunInMainThread(returnBlock.block)
        } else {
            returnBlock.block()
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
        
        if successBlock.runsInMainThread {
            MDDispatcher.syncRunInMainThread {[unowned self] in
                successBlock.block(result)
                if let delegate = self.delegate {
                    delegate.operation(self, didRunSuccessBlockWithResult: result)
                }
            }
        } else {
            successBlock.block(result)
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
        
        if failureBlock.runsInMainThread {
            MDDispatcher.syncRunInMainThread({[unowned self] in
                failureBlock.block(error)
                if let delegate = self.delegate {
                    delegate.operation(self, didRunFailureBlockWithError: error)
                }
            })
        } else {
            failureBlock.block(error)
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
