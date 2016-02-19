//
//  MQBaseURLOperation.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 27/01/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

private let kDefaultSession: NSURLSession = {
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    // Requests timeout after 30 seconds.
    configuration.timeoutIntervalForRequest = 30
    
    // Set cookie policies.
    configuration.HTTPCookieAcceptPolicy = .Always
    configuration.HTTPCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
    configuration.HTTPShouldSetCookies = true
    
    // Set caching policies.
    configuration.URLCache = NSURLCache.sharedURLCache()
    configuration.requestCachePolicy = .UseProtocolCachePolicy
    
    return NSURLSession(configuration: configuration)
}()

public class MQBaseURLOperation: __MQURLOperation {
    
    public class var defaultSession: NSURLSession {
        return kDefaultSession
    }
    
    public override func handleResponse(someResponse: NSURLResponse?, _ someData: NSData?, _ someError: NSError?) {
        defer {
            if self.cancelled == false {
                self.runFinishBlock()
            }
            super.handleResponse(someResponse, someData, someError)
        }
        
        self.runReturnBlock()
        
        if let error = someError {
            self.runFailureBlockWithError(error)
            return
        }
        
        guard let data = someData else {
            self.runFailureBlockWithError(MQError("No data returned."))
            return
        }
        
        self.handleResponseData(data)
    }
    
    /**
     Override point for interpreting the `NSData` returned by the URL request. The default implementation attempts to
     parse it into JSON format to be handled in the `buildResult` function. If you override this method, you need to
     define the points at which the success and failure blocks will be called.
     */
    public func handleResponseData(data: NSData) {
        let JSON: [String : AnyObject]
        do {
            guard let theJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [.AllowFragments])
                as? [String : AnyObject] else {
                    self.runFailureBlockWithError(MQError("Failed to parse response into JSON format."))
                    return
            }
            JSON = theJSON
        } catch {
            self.runFailureBlockWithError(error)
            return
        }
        
//        print("JSON: \(NSString(data: data, encoding: NSUTF8StringEncoding)!)")
        
        do {
            let result = try self.buildResult(JSON)
            self.runSuccessBlockWithResult(result)
            return
        } catch {
            self.runFailureBlockWithError(error)
            return
        }
    }
    
}