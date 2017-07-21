//
//  TBAsynchronousOperation.swift
//  Mold
//
//  Created by Matt Quiros on 19/07/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

open class TBAsynchronousOperation<SourceType, ResultType, ErrorType: Error>: TBOperation<SourceType, ResultType, ErrorType> {
    
//    fileprivate var _executing = false
//    fileprivate var _finished = false
    
    open override var isConcurrent: Bool {
        return true
    }
    
    open override var isAsynchronous: Bool {
        return true
    }
    
//    open override var isExecuting: Bool {
//        return self._executing
//    }
//
//    open override var isFinished: Bool {
//        return self._finished
//    }
    
    open override func start() {
        print("\(#function) \(md_getClassName(self))")
        guard self.isCancelled == false &&
            self.hasFailedDependencies == false &&
            self.shouldExecute()
            else {
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
    
//    public func finish() {
//        print("\(#function) \(md_getClassName(self))")
//        self.willChangeValue(forKey: "isExecuting")
//        self._executing = false
//        self.didChangeValue(forKey: "isExecuting")
//        
//        self.willChangeValue(forKey: "isFinished")
//        self._finished = true
//        self.didChangeValue(forKey: "isFinished")
//    }
    
}
