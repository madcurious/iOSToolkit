//
//  TBOperation.swift
//  Mold
//
//  Created by Matt Quiros on 19/07/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

open class TBOperation<SourceType, ResultType, ErrorType: Error>: Operation {
    
    public typealias TBOperationCompletionBlock = ((ResultType?, ErrorType?) -> Void)
    
    open var result: ResultType?
    open var error: ErrorType?
    
    public var hasFailedDependencies: Bool {
        return self.dependencies.contains(where: {
            if let operation = $0 as? TBOperation,
                operation.error != nil {
                return true
            }
            return false
        })
    }
    
//    var __completionBlock: TBOperationCompletionBlock?
    
    public init(completionBlock: TBOperationCompletionBlock?) {
//        __completionBlock = completionBlock
        super.init()
        if let completionBlock = completionBlock {
            self.completionBlock = {[weak self] in
                guard let weakSelf = self
                    else {
                        return
                }
                completionBlock(weakSelf.result, weakSelf.error)
            }
        }
//        self.completionBlock = {[weak self] in
//            guard let weakSelf = self,
//                let completionBlock = self?.__completionBlock
//                else {
//                    return
//            }
//            completionBlock(weakSelf.result, weakSelf.error)
//        }
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
    
}
