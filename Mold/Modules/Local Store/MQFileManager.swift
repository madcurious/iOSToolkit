//
//  MQFileManager.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 4/16/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public enum MQFileManagerError: MQErrorType {
    
    case CantArchiveValue(Any)
    case CantBuildPathToFile(String, inFolder: NSSearchPathDirectory)
    
    public func object() -> MQError {
        switch self {
        case .CantArchiveValue(let value):
            return MQError("Archiving the value \"\(value)\" failed.")
            
        case .CantBuildPathToFile(let file, inFolder: let folder):
            return MQError("Can't build a path to file \(file) in \(folder)")
        }
    }
    
}

public class MQFileManager {
    
    /**
    Returns the URL of a file in /Document.
    */
    public class func URLForFileName(fileName: String) -> NSURL? {
        return self.URLForFileName(fileName, inFolder: .DocumentDirectory)
    }
    
    /**
    Returns the URL for a file in a given system directory.
    */
    public class func URLForFileName(fileName: String, inFolder folder: NSSearchPathDirectory) -> NSURL? {
        if let systemDirectory = self.URLForSystemFolder(folder) {
            return systemDirectory.URLByAppendingPathComponent(fileName)
        }
        return nil
    }
    
    /**
    Returns the URL for a system folder in the app's sandbox.
    */
    public class func URLForSystemFolder(folder: NSSearchPathDirectory) -> NSURL? {
        let fileManager = NSFileManager.defaultManager()
        let URLs = fileManager.URLsForDirectory(folder, inDomains: .UserDomainMask)
        
        if let lastObject: AnyObject = URLs.last {
            if let  directoryURL = lastObject as? NSURL {
                return directoryURL
            }
        }
        return nil
    }
    
    /**
    Convenience method for checking whether a file exists in /Document.
    */
    public class func findsFileWithName(fileName: String) -> Bool {
        return self.findsFileWithName(fileName, inFolder: .DocumentDirectory)
    }
    
    public class func findsFileWithName(fileName: String, inFolder folder: NSSearchPathDirectory) -> Bool {
        if let filePath = self.URLForFileName(fileName, inFolder: folder) {
            return NSFileManager.defaultManager().fileExistsAtPath(filePath.path!)
        }
        return false
    }
    
    public class func findsFileInURL(fileURL: NSURL) -> Bool {
        return NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!)
    }
    
    public class func writeValue<T: MQArchivableValueType>(value: T, toFile fileName: String, inFolder folder: NSSearchPathDirectory = .DocumentDirectory) throws {
        guard let fileURL = self.URLForFileName(fileName, inFolder: folder),
            let path = fileURL.path else {
                throw MQFileManagerError.CantBuildPathToFile(fileName, inFolder: folder)
        }
        
        let dictionary = value.toDictionary()
        if NSKeyedArchiver.archiveRootObject(dictionary, toFile: path) == false {
            throw MQFileManagerError.CantArchiveValue(value)
        }
    }
    
    public class func writeValue(value: AnyObject, toFile fileName: String, inFolder folder: NSSearchPathDirectory = .DocumentDirectory) throws {
        guard let fileURL = self.URLForFileName(fileName, inFolder: folder),
            let path = fileURL.path else {
                throw MQFileManagerError.CantBuildPathToFile(fileName, inFolder: folder)
        }
        
        if NSKeyedArchiver.archiveRootObject(value, toFile: path) == false {
            throw MQFileManagerError.CantArchiveValue(value)
        }
    }
    
    public class func valueAtFile<T: MQArchivableValueType>(fileName: String, inFolder folder: NSSearchPathDirectory = .DocumentDirectory) -> T? {
        if let fileURL = self.URLForFileName(fileName, inFolder: folder),
            let path = fileURL.path,
            let dictionary = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [String : AnyObject] {
                return T(fromDictionary: dictionary)
        }
        return nil
    }
    
    public class func valueAtFile<T>(fileName: String, inFolder folder: NSSearchPathDirectory = .DocumentDirectory) -> T? {
        if let fileURL = self.URLForFileName(fileName, inFolder: folder),
            let path = fileURL.path,
            let object = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? T {
                return object
        }
        return nil
    }
    
    public class func deleteValueAtFile(fileName: String, inFolder folder: NSSearchPathDirectory = .DocumentDirectory) throws {
        guard let fileURL = self.URLForFileName(fileName, inFolder: folder) else {
            return
        }
        
        if self.findsFileInURL(fileURL) {
            try NSFileManager.defaultManager().removeItemAtURL(fileURL)
        }
    }
    
}

// FIXME: Swift 2.0
/*public extension MQFileManager {

    public class func writeValue<T: MQArchivableValueType>(value: T, toFile fileName: String, inFolder folder: NSSearchPathDirectory = .DocumentDirectory) throws {
        guard let fileURL = self.URLForFileName(fileName, inFolder: folder),
            let path = fileURL.path else {
                throw MQError("Cannot build a file URL to file name '\(fileName)' in '\(folder)'.")
        }
        
        let dictionary = value.archiveDictionary()
        if NSKeyedArchiver.archiveRootObject(dictionary, toFile: path) == false {
            throw MQError("Archiving value \(value) failed.")
        }
    }
    
    public class func writeValue(value: AnyObject, toFile fileName: String, inFolder folder: NSSearchPathDirectory = .DocumentDirectory) throws {
        guard let fileURL = self.URLForFileName(fileName, inFolder: folder),
            let path = fileURL.path else {
                throw MQError("Cannot build a file URL to file name '\(fileName)' in '\(folder)'.")
        }
        
        if NSKeyedArchiver.archiveRootObject(value, toFile: path) == false {
            throw MQError("Cannot write value \(value) to file.")
        }
    }
    
    public class func valueAtFile<T: MQArchivableValueType>(fileName: String, inFolder folder: NSSearchPathDirectory = .DocumentDirectory) -> T? {
        guard let fileURL = self.URLForFileName(fileName, inFolder: folder),
            let path = fileURL.path,
            let dictionary = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [String : AnyObject] else {
                return nil
        }
        
        return T(archiveDictionary: dictionary)
    }
    
    public class func valueAtFile<T>(fileName: String, inFolder folder: NSSearchPathDirectory = .DocumentDirectory) -> T? {
        guard let fileURL = self.URLForFileName(fileName, inFolder: folder),
            let path = fileURL.path,
            let object = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? T else {
                return nil
        }
        
        return object
    }
    
    public class func deleteValueAtFile(fileName: String, inFolder folder: NSSearchPathDirectory = .DocumentDirectory) throws {
        guard let fileURL = self.URLForFileName(fileName, inFolder: folder) else {
                return
        }
        
        if self.findsFileInURL(fileURL) {
            try NSFileManager.defaultManager().removeItemAtURL(fileURL)
        }
    }
    
}
*/