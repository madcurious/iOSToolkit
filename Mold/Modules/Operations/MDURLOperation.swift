//
//  MQURLOperation.swift
//  Mold
//
//  Created by Matt Quiros on 02/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

public class MDURLOperation: MDOperation {
    
    public enum Method: String {
        case OPTIONS = "OPTIONS"
        case GET = "GET"
        case HEAD = "HEAD"
        case POST = "POST"
        case PUT = "PUT"
        case PATCH = "PATCH"
        case DELETE = "DELETE"
        case TRACE = "TRACE"
        case CONNECT = "CONNECT"
    }
    
    public enum ResponseEncoding {
        case JSON
    }
    
    public var responseEncoding = ResponseEncoding.JSON
    
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
    
    public func returnFromURLRequest(data data: NSData?, response: NSURLResponse?, error: NSError?) {
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
            var rawResult: Any?
            // Attempt to encode the data into JSON, the default format.
            if let data = data
                where self.responseEncoding == .JSON {
                rawResult = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            }
            
            let result = try self.buildResult(rawResult)
            self.runSuccessBlock(result)
            return
        } catch {
            self.runFailBlock(error)
        }
    }
    
}