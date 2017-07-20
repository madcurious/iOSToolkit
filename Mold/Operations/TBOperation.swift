//
//  TBOperation.swift
//  Mold
//
//  Created by Matt Quiros on 19/07/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

open class TBOperation<SourceType, ResultType, ErrorType: Error>: Operation {
    
    public typealias TBOperationCompletionBlock = (TBOperation.Result) -> Void
    
    public enum Result {
        case none
        case success(ResultType)
        case error(ErrorType)
    }
    
    open var result = TBOperation.Result.none
    
    /// Checks whether the operation has any dependencies that are both of type `TBOperation`
    /// and whose `result` is `.error`. Returns `true` if a dependency has `.error` for a
    /// result, or if none of the dependencies are `TBOperation`s.
    public var hasFailedDependencies: Bool {
        return self.dependencies.contains(where: {
            if let operation = $0 as? TBOperation {
                switch operation.result {
                case .error(_):
                    return true
                default:
                    return false
                }
            }
            return false
        })
    }
    
    public init(completionBlock: TBOperationCompletionBlock?) {
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
    
    open func shouldExecute() -> Bool {
        return true
    }
    
    open override func start() {
        if self.hasFailedDependencies || self.shouldExecute() == false {
            self.cancel()
            return
        }
    }
    
    deinit {
        print("Deallocating \(self)")
    }
    
}
