//
//  __MQAsynchronousOperation.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 7/23/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

/**
An `__MQOperation` subclass that runs asynchronously. It overrides the properties and
functions that are required to be overriden when implementing an asynchronous `NSOperation`.
*/
public class __MQAsynchronousOperation: __MQOperation {
    
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
    
    public override func start() {
        if self.cancelled {
            self.willChangeValueForKey("isFinished")
            self._finished = true
            self.didChangeValueForKey("isFinished")
            return
        }
        
        self.willChangeValueForKey("isExecuting")
        NSThread.detachNewThreadSelector(Selector("main"), toTarget: self, withObject: nil)
        self._executing = true
        self.didChangeValueForKey("isExecuting")
    }
    
    public override func main() {
        defer {
            if self.cancelled == false {
            self.runFinishBlock()
            }
            self.closeOperation()
        }
        
        self.runStartBlock()
        self.runReturnBlock()
        do {
            let result = try self.buildResult(nil)
            self.runSuccessBlockWithResult(result)
        } catch {
            self.runFailureBlockWithError(error)
        }
    }
    
    public func closeOperation() {
        self.willChangeValueForKey("isExecuting")
        self.willChangeValueForKey("isFinished")
        
        self._executing = false
        self._finished = true
        
        self.didChangeValueForKey("isExecuting")
        self.didChangeValueForKey("isFinished")
    }
    
}