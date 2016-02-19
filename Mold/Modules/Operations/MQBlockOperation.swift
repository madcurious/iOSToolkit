//
//  MQBlockOperation.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

public class MQBlockOperation: MQOperation {
    
    var block: Void throws -> Any?
    
    public init(_ block: Void throws -> Any?) {
        self.block = block
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
            let result = try block()
            
            if self.cancelled {
                return
            }
            
            self.runSuccessBlock(result)
        } catch {
            self.runFailBlock(error)
        }
    }
    
}
