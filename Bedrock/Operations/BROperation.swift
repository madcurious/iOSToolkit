//
//  BROperation.swift
//  Bedrock
//
//  Created by Matt Quiros on 19/07/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

/// A necessary protocol to which all `BROperation`s must internally conform so that
/// the `hasFailedDependencies` computed property can be implemented.
protocol BROperationProtocol {
    
    var isFailed: Bool { get }
    
}

open class BROperation<ResultType, ErrorType>: Operation, BROperationProtocol {
    
    public indirect enum Result {
        case success(ResultType)
        case error(ErrorType)
    }
    
    public typealias BROperationCompletionBlock = (BROperation.Result?) -> Void
    
    var isFailed: Bool {
        if case .some(.error(_)) = result {
            return true
        }
        return false
    }
    
    var internalExecuting = false
    var internalFinished = false
    
    open override var isExecuting: Bool {
        return internalExecuting
    }
    
    open override var isFinished: Bool {
        return internalFinished
    }
    
    open var result: BROperation.Result?
    
    /**
     Checks whether the operation has any dependencies that are `BROperation`s and which failed.
     */
    public var hasFailedDependencies: Bool {
        let hasFailedDependencies = dependencies.contains(where: {
            if let operation = $0 as? BROperationProtocol,
                operation.isFailed == true {
                return true
            }
            return false
        })
        return hasFailedDependencies
    }
    
    public var shouldExecute = { return true }
    
    public init(completionBlock: BROperationCompletionBlock?) {
        super.init()

        guard let completionBlock = completionBlock
            else {
                return
        }

        self.completionBlock = {[weak self] in
            guard let weakSelf = self
                else {
                    return
            }
            completionBlock(weakSelf.result)
        }
    }
    
    open override func start() {
        if hasFailedDependencies || shouldExecute() == false {
            setFinished(true)
            return
        }
        
        setExecuting(true)
        main()
        
        finish()
    }
    
    /**
     Sets the internal executing flag and makes the proper KVO calls.
     */
    public func setExecuting(_ executing: Bool) {
        willChangeValue(forKey: "isExecuting")
        internalExecuting = executing
        didChangeValue(forKey: "isExecuting")
    }
    
    /**
     Sets the internal finished flag and makes the proper KVO calls.
     */
    public func setFinished(_ finished: Bool) {
        willChangeValue(forKey: "isFinished")
        internalFinished = finished
        didChangeValue(forKey: "isFinished")
    }
    
    /**
     Sets `isExecuting` to `false` and `isFinished` to `true`.
     */
    public func finish() {
        setExecuting(false)
        setFinished(true)
    }
    
}
