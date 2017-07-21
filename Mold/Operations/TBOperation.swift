//
//  TBOperation.swift
//  Mold
//
//  Created by Matt Quiros on 19/07/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

/// A necessary protocol to which all `TBOperation`s must internally conform so that
/// the `hasFailedDependencies` computed property can be implemented.
protocol TBOperationProtocol {
    
    /// Must be set to true if the operation's `result` property is set to `.error`.
    var failed: Bool { get set }
    
}

open class TBOperation<SourceType, ResultType, ErrorType: Error>: Operation, TBOperationProtocol {
    
    public typealias TBOperationCompletionBlock = (TBOperation.Result) -> Void
    
    public indirect enum Result {
        case none
        case success(ResultType)
        case error(ErrorType)
    }
    
    var failed = false
    
    var _executing = false
    var _finished = false
    
    open override var isExecuting: Bool {
        return self._executing
    }
    
    open override var isFinished: Bool {
        return self._finished
    }
    
    open var result = TBOperation.Result.none {
        didSet {
            switch result {
            case .error(_):
                self.failed = true
            default:
                self.failed = false
            }
        }
    }
    
    /**
     Checks whether the operation has any dependencies that inherit from `TBOperation` and whose `result` is `.error`.
     
     Returns `true` if at least one of the dependencies is a `TBOperation` and the `result` is `.error`.
     Returns `false` if none of the dependencies is a `TBOperation`, or none of the `TBOperation` dependencies
     have `.error` for a result.
     */
    public var hasFailedDependencies: Bool {
        let hasFailedDependencies = self.dependencies.contains(where: {
            if let operation = $0 as? TBOperationProtocol,
                operation.failed == true {
                return true
            }
            return false
        })
        return hasFailedDependencies
    }
    
    public init(completionBlock: TBOperationCompletionBlock?) {
        super.init()
        print("\(#function) \(md_getClassName(self))")
        
        guard let completionBlock = completionBlock
            else {
                return
        }
        self.completionBlock = {[weak self] in
            guard let weakSelf = self
                else {
                    return
            }
            print("completionBlock: \(md_getClassName(weakSelf))")
            completionBlock(weakSelf.result)
        }
    }
    
    open func shouldExecute() -> Bool {
        return true
    }
    
    open override func start() {
        print("\(#function) \(md_getClassName(self))")
        if self.hasFailedDependencies || self.shouldExecute() == false {
            print("pre-cancel isReady: \(self.isReady)")
            print("pre-cancel isExecuting: \(self.isExecuting)")
            print("pre-cancel isFinished: \(self.isFinished)")
            self.cancel()
            self.finish()
            print("post-cancel isReady: \(self.isReady)")
            print("post-cancel isExecuting: \(self.isExecuting)")
            print("post-cancel isFinished: \(self.isFinished)")
            return
        }
        
        self.willChangeValue(forKey: "isExecuting")
        self._executing = true
        self.didChangeValue(forKey: "isExecuting")
        
        self.main()
        
        self.finish()
    }
    
    public func finish() {
        print("\(#function) \(md_getClassName(self))")
        self.willChangeValue(forKey: "isExecuting")
        self._executing = false
        self.didChangeValue(forKey: "isExecuting")
        
        self.willChangeValue(forKey: "isFinished")
        self._finished = true
        self.didChangeValue(forKey: "isFinished")
    }
    
    deinit {
        print("\(#function) \(md_getClassName(self))")
    }
    
}
