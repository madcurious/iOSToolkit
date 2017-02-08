//
//  MDOperation.swift
//  Mold
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

open class MDOperation: Operation {
    
    open var startBlock: ((Void) -> Void)?
    open var returnBlock: ((Void) -> Void)?
    open var successBlock: ((Any?) -> Void)?
    open var failBlock: ((Error) -> Void)?
    open var finishBlock: ((Void) -> Void)?
    
    open var shouldRunCallbacksInMainThread = true
    
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
    open func onStart(_ startBlock: @escaping (Void) -> Void) -> Self {
        self.startBlock = startBlock
        return self
    }
    
    @discardableResult
    open func onReturn(_ returnBlock: @escaping (Void) -> Void) -> Self {
        self.returnBlock = returnBlock
        return self
    }
    
    @discardableResult
    open func onSuccess(_ successBlock: @escaping (Any?) -> Void) -> Self {
        self.successBlock = successBlock
        return self
    }
    
    @discardableResult
    open func onFail(_ failBlock: @escaping (Error) -> Void) -> Self {
        self.failBlock = failBlock
        return self
    }
    
    @discardableResult
    open func onFinish(_ finishBlock: @escaping (Void) -> Void) -> Self {
        self.finishBlock = finishBlock
        return self
    }
    
    public func chain(if condition: ((Any?) -> Bool)? = nil, configurator: @escaping ((Any?) -> MDOperation)) -> MDChainedOperation {
//        let chain = MDChainedOperation()
//        chain.isInitializedFromOperation = true
//        chain.chain(configurator: { _ in return self })
//        return chain
        if let thisOperation = self as? MDChainedOperation {
            thisOperation.chain(if: condition, configurator: configurator)
            return thisOperation
        } else {
            let chainedOperation = MDChainedOperation(head: self)
            chainedOperation.isInitializedFromOperation = true
            chainedOperation.chain(if: condition, configurator: configurator)
            return chainedOperation
        }
    }
    
    /**
     Convenience function for setting a `failBlock` that just shows an error dialog
     in a presenting view controller.
     */
    @discardableResult
    open func setFailBlockToShowErrorInPresenter(_ viewController: UIViewController) -> Self {
        self.failBlock = {[unowned viewController] error in
            MDErrorDialog.showError(error, inPresenter: viewController)
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
            self.runFailBlock(error)
        }
    }
    
    open func closeOperation() {
        if self.isCancelled == false {
            self.runFinishBlock()
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
        
        if self.shouldRunCallbacksInMainThread == true {
            MDDispatcher.syncRunInMainThread(startBlock)
        } else {
            startBlock()
        }
    }
    
    open func runReturnBlock() {
        guard let returnBlock = self.returnBlock
            else {
                return
        }
        
        if self.shouldRunCallbacksInMainThread == true {
            MDDispatcher.syncRunInMainThread(returnBlock)
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
        
        if self.shouldRunCallbacksInMainThread == true {
            MDDispatcher.syncRunInMainThread {
                successBlock(result)
            }
        } else {
            successBlock(result)
        }
    }
    
    open func runFailBlock(_ error: Error) {
        if self.shouldRunReturnBlockBeforeSuccessOrFail {
            self.runReturnBlock()
        }
        
        guard let failBlock = self.failBlock
            else {
                return
        }
        
        if self.shouldRunCallbacksInMainThread == true {
            MDDispatcher.syncRunInMainThread({
                failBlock(error)
            })
        } else {
            failBlock(error)
        }
    }
    
    open func runFinishBlock() {
        guard let finishBlock = self.finishBlock
            else {
                return
        }
        
        if self.shouldRunCallbacksInMainThread == true {
            MDDispatcher.syncRunInMainThread(finishBlock)
        } else {
            finishBlock()
        }
    }
    
}
