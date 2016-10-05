//
//  MDArchivableValueType.swift
//  Mold
//
//  Created by Matt Quiros on 7/13/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

public protocol MDArchivableValueType {
    
    /**
    Called by `MDFileManager` to inflate an `MDDataModel` from a file. You shouldn't have to
    call this initializer directly or override its implementation. If the `data` argument can't
    be converted to a Swift dictionary, a fatal error is produced and you should check
    what's wrong with the file.
    */
    init(fromData data: Data)
    
    /**
     Defines how a dictionary maps to the value type and its properties. Called from within
     `init(archiveData:)` when the data is successfully converted to a dictionary.
    */
    init(fromDictionary dict: [String : AnyObject])
    
    /**
    Returns a dictionary representation of this data model so that in can be written to a file.
    You must implement this method to define the key-value pairing in the dictionary.
    */
    func toDictionary() -> [String : AnyObject]
    
}

public extension MDArchivableValueType {
    
    init(fromData data: Data) {
        guard let dictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String : AnyObject] else {
            fatalError("Cannot convert to NSData.")
        }
        self.init(fromDictionary: dictionary)
    }
    
}
