//
//  MDOperation.swift
//  Mold
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

public class MDOperation: NSOperation {
    
    public var startBlock: (Void -> Void)?
    public var returnBlock: (Void -> Void)?
    public var successBlock: (Any? -> Void)?
//    public var failBlock: (NSError -> Void)?
    public var failBlock: (ErrorType -> Void)?
    public var finishBlock: (Void -> Void)?
    
    public var shouldRunCallbacksInMainThread = true
    
    /**
     Determines whether the operation, after determining success or fail, should execute the `returnBlock` 
     before the `successBlock` or `failBlock` runs its logic. If you manually set this to `false` because
     you want to do something else in the success of fail block, you will have to run the `returnBlock` yourself in your code.
     */
    public var shouldRunReturnBlockBeforeSuccessOrFail = true
    
    // MARK: Internal state variables
    
    private var _executing = false
    private var _finished = false
    
    // MARK: NSOperation required overrides
    
    public override var concurrent: Bool {
        return true
    }
    
    public override var asynchronous: Bool {
        return true
    }
    
    public override var executing: Bool {
        return self._executing
    }
    
    public override var finished: Bool {
        return self._finished
    }
    
    // MARK: Builders
    
    public func onStart(startBlock: Void -> Void) -> Self {
        self.startBlock = startBlock
        return self
    }
    
    public func onReturn(returnBlock: Void -> Void) -> Self {
        self.returnBlock = returnBlock
        return self
    }
    
    public func onSuccess(successBlock: Any? -> Void) -> Self {
        self.successBlock = successBlock
        return self
    }
    
//    public func onFail(failBlock: NSError -> Void) -> Self {
//        self.failBlock = failBlock
//        return self
//    }
    
    public func onFail(failBlock: ErrorType -> Void) -> Self {
        self.failBlock = failBlock
        return self
    }
    
    public func onFinish(finishBlock: Void -> Void) -> Self {
        self.finishBlock = finishBlock
        return self
    }
    
    public func buildResult(object: Any?) throws -> Any? {
        return nil
    }
    
    // MARK: Functions
    
    public override func start() {
        if self.cancelled {
            self.willChangeValueForKey("isFinished")
            self._finished = true
            self.didChangeValueForKey("isFinished")
            return
        }
        
        self.willChangeValueForKey("isExecuting")
        NSThread.detachNewThreadSelector(#selector(main), toTarget: self, withObject: nil)
        self._executing = true
        self.didChangeValueForKey("isExecuting")
    }
    
    public override func main() {
        defer {
            self.closeOperation()
        }
        
        self.runStartBlock()
        
        if self.cancelled {
            return
        }
        
        do {
            let result = try self.buildResult(nil)
            if self.cancelled {
                return
            }
            self.runSuccessBlock(result)
        } catch {
            self.runFailBlock(error)
        }
    }
    
    public func closeOperation() {
        if self.cancelled == false {
            self.runFinishBlock()
        }
        
        self.willChangeValueForKey("isExecuting")
        self.willChangeValueForKey("isFinished")
        
        self._executing = false
        self._finished = true
        
        self.didChangeValueForKey("isExecuting")
        self.didChangeValueForKey("isFinished")
    }
    
    public func runStartBlock() {
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
    
    public func runReturnBlock() {
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
    
    public func runSuccessBlock(result: Any?) {
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
    
//    public func runFailBlock(error: NSError) {
//        if self.shouldRunReturnBlockBeforeSuccessOrFail {
//            self.runReturnBlock()
//        }
//        
//        guard let failBlock = self.failBlock
//            else {
//                return
//        }
//        
//        if self.shouldRunCallbacksInMainThread == true {
//            MDDispatcher.syncRunInMainThread {
//                failBlock(error)
//            }
//        } else {
//            failBlock(error)
//        }
//    }
//    
//    public func runFailBlock(error: ErrorType) {
//        if let error = error as? MDErrorType {
//            self.runFailBlock(error.object())
//        } else {
//            self.runFailBlock(error as NSError)
//        }
//    }
    
    public func runFailBlock(error: ErrorType) {
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
    
    public func runFinishBlock() {
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