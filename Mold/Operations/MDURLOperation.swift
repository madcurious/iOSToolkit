//
//  MQURLOperation.swift
//  Mold
//
//  Created by Matt Quiros on 02/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

open class MDURLOperation: MDAsynchronousOperation {
    
    public enum Method: String {
        case options = "OPTIONS"
        case get = "GET"
        case head = "HEAD"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
        case trace = "TRACE"
        case connect = "CONNECT"
    }
    
    public enum ResponseEncoding {
        case json, string
    }
    
    public enum ParameterEncoding {
        case json
    }
    
    public enum TaskType {
        case data, download, upload
    }
    
    open var method: Method
    open var url: URL
    
    open class var baseURL: URL {
        fatalError("Used \(#function) but not overriden")
    }
    
    open var responseEncoding = ResponseEncoding.json
    open var parameterEncoding = ParameterEncoding.json
    open var taskType = TaskType.data
    open var requiresAuthentication = true
    open var shouldParseResponse = true
    
    public init?(method: MDURLOperation.Method, URLString: String) {
        guard let URL = URL(string: URLString)
            else {
                return nil
        }
        self.method = method
        self.url = URL
    }
    
    public init(method: MDURLOperation.Method, URL: URL) {
        self.method = method
        self.url = URL
    }
    
    open func makeRequest() -> URLRequest? {
        var request = URLRequest(url: self.url)
        request.httpMethod = self.method.rawValue
        return request
    }
    
    open func makeSession() -> URLSession? {
        fatalError("Must override")
    }
    
    open func makePayload() -> Any? {
        return nil
    }
    
    open override func main() {
        self.runStartBlock()
        
        if self.isCancelled {
            self.finish()
            return
        }
        
        // Build the URL request.
        guard var request = self.makeRequest()
            else {
                self.finish()
                return
        }
        
        // Append the payload to the request, if any.
        if let payload = self.makePayload() {
            do {
                switch self.parameterEncoding {
                case .json:
                    #if DEBUG
                        md_prettyPrintJSON(payload)
                    #endif
                    let payloadData = try JSONSerialization.data(withJSONObject: payload, options: [])
                    request.httpBody = payloadData
                }
            } catch {
                self.runFailureBlock(error: error)
                self.finish()
                return
            }
        }
        
        guard let session = self.makeSession()
            else {
                self.finish()
                return
        }
        
        // Create the task and fire it.
        var task: URLSessionTask!
        switch self.taskType {
        case .data:
            task = session.dataTask(with: request, completionHandler: {[unowned self] (someData, someResponse, someError) in
                self.returnFromURLRequest(request, response: someResponse, data: someData, error: someError)
                })
            
        default: ()
        }
        
        task.resume()
    }
    
    /**
     Invoked when the URL request completes and returns. The default implementation defines what to do
     with the returned data and at which points the callback blocks will be called.
     
     **IMPORTANT**: If you override this function, do not forget to:
     * Listen for cancellations of the operation, especially if you're in a loop.
     * Call `closeOperation()` before exiting your custom implementation, regardless of whether you've generated a
     result or thrown an error.
     */
    open func returnFromURLRequest(_ request: URLRequest, response: URLResponse?, data: Data?, error: Error?) {
        defer {
            self.finish()
        }
        
        if self.isCancelled {
            return
        }
        
        if let error = error {
            self.runFailureBlock(error: error)
            return
        }
        
        do {
            var rawResult: Any?
            // Attempt to encode the data into JSON, the default format.
            if self.responseEncoding == .json {
                rawResult = try MDURLOperation.convertDataToJSON(data)
            }
            
            if self.isCancelled {
                return
            }
            
            let result = try self.makeResult(from: rawResult)
            
            if self.isCancelled {
                return
            }
            
            self.runSuccessBlock(result: result)
            return
        } catch {
            // DEBUG
            #if DEBUG
                if let data = data {
                    let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                    print(dataString)
                }
            #endif
            
            if self.isCancelled {
                return
            }
            
            self.runFailureBlock(error: error)
        }
    }
    
    open class func convertDataToJSON(_ data: Data?) throws -> [String : AnyObject]? {
        if let data = data {
            return try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String : AnyObject]
        }
        return nil
    }
    
}
