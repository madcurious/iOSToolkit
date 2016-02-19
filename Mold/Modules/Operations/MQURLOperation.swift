//
//  MQURLOperation.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 02/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

public class MQURLOperation: MQOperation {
    
    public override func main() {
        self.runStartBlock()
        
        if self.cancelled {
            self.closeOperation()
            return
        }
        
        do {
            try self.runURLRequest()
        } catch {
            self.runFailBlock(error)
        }
    }
    
    /**
     Override point for setting up and starting the URL request. When the URL request returns, you may
     call `returnFromURLRequest` in the callback block and pass the error and data from the request.
     
     If you want to customise the return behavior, you have to define when the callback blocks will be called.
     You must also call `closeOperation` yourself, otherwise the operation won't properly close.
     */
    public func runURLRequest() throws {
    }
    
    public func returnFromURLRequest(error: NSError?, _ object: Any?) {
        defer {
            self.closeOperation()
        }
        
        if self.cancelled {
            return
        }
        
        if let error = error {
            self.runFailBlock(error)
            return
        }
        
        do {
            let result = try self.buildResult(object)
            self.runSuccessBlock(result)
            return
        } catch {
            self.runFailBlock(error)
        }
    }
    
}