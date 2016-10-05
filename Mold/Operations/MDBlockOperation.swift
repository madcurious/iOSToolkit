//
//  MDBlockOperation.swift
//  Mold
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

open class MDBlockOperation: MDOperation {
    
    var block: (Void) throws -> Any?
    
    public init(_ block: @escaping (Void) throws -> Any?) {
        self.block = block
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
            let result = try block()
            
            if self.isCancelled {
                return
            }
            
            self.runSuccessBlock(result)
        } catch {
            self.runFailBlock(error)
        }
    }
    
}
