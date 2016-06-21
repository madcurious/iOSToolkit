//
//  Functions.swift
//  Mold
//
//  Created by Matt Quiros on 5/22/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

/**
 Returns a string if the argument is a non-nil, non-empty string. Otherwise,
 returns `nil`.
 */
public func md_nonEmptyString(arg: Any?) -> String? {
    if let string = arg as? String {
        if string.trim().isEmpty == false {
            return string
        }
    }
    return nil
}

public func md_rootViewController() -> UIViewController {
    guard let root = UIApplication.sharedApplication().delegate?.window??.rootViewController else {
        fatalError("No root view controller.")
    }
    return root
}

public func md_prettyPrintJSONObject(object: AnyObject) {
    var JSONData: NSData
    if let data = object as? NSData {
        JSONData = data
    } else {
        do {
            JSONData = try NSJSONSerialization.dataWithJSONObject(object, options: .PrettyPrinted)
        } catch {
            print(error)
            return
        }
    }
    
    if let JSONString = NSString(data: JSONData, encoding: NSUTF8StringEncoding) {
        print(JSONString)
    } else {
        print("Can't print object as JSON: \(object)")
    }
}