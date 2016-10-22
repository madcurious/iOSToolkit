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
public func md_nonEmptyString(_ arg: Any?) -> String? {
    if let string = arg as? String {
        if string.trim().isEmpty == false {
            return string
        }
    }
    return nil
}

public func md_rootViewController() -> UIViewController {
    guard let root = UIApplication.shared.delegate?.window??.rootViewController else {
        fatalError("No root view controller.")
    }
    return root
}

public func md_prettyPrintJSONObject(_ object: AnyObject) {
    var JSONData: Data
    if let data = object as? Data {
        JSONData = data
    } else {
        do {
            JSONData = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        } catch {
            print(error)
            return
        }
    }
    
    if let JSONString = NSString(data: JSONData, encoding: String.Encoding.utf8.rawValue) {
        print(JSONString)
    } else {
        print("Can't print object as JSON: \(object)")
    }
}


private let kDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateStyle = .full
    df.timeStyle = .full
    df.timeZone = TimeZone.autoupdatingCurrent
    return df
}()

public func md_stringForDate(_ date: Date?) -> String {
    guard let date = date
        else {
            return "nil"
    }
    return kDateFormatter.string(from: date)
}

/**
 Returns the name of `object`'s class based on a (poor?) assumption that it is the last
 token in the fully qualified class name assigned by Swift.
 */
public func md_getClassName(_ object: AnyObject) -> String {
    let description = object.classForCoder.description()
    let className = description.components(separatedBy: ".").last!
    return className
}
