//
//  MQFileManager.swift
//  Mold
//
//  Created by Matt Quiros on 4/16/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public enum MDFileManagerError: MDErrorType {
    
    case cantArchiveValue(Any)
    case cantBuildPathToFile(String, inFolder: FileManager.SearchPathDirectory)
    
    public func object() -> MDError {
        switch self {
        case .cantArchiveValue(let value):
            return MDError("Archiving the value \"\(value)\" failed.")
            
        case .cantBuildPathToFile(let file, inFolder: let folder):
            return MDError("Can't build a path to file \(file) in \(folder)")
        }
    }
    
}

open class MDFileManager {
    
    /**
     Returns the URL of a file in /Document.
     */
    open class func URLForFileName(_ fileName: String) -> URL? {
        return self.URLForFileName(fileName, inFolder: .documentDirectory)
    }
    
    /**
     Returns the URL for a file in a given system directory.
     */
    open class func URLForFileName(_ fileName: String, inFolder folder: FileManager.SearchPathDirectory) -> URL? {
        if let systemDirectory = self.URLForSystemFolder(folder) {
            return systemDirectory.appendingPathComponent(fileName)
        }
        return nil
    }
    
    /**
     Returns the URL for a system folder in the app's sandbox.
     */
    open class func URLForSystemFolder(_ folder: FileManager.SearchPathDirectory) -> URL? {
        let fileManager = FileManager.default
        let URLs = fileManager.urls(for: folder, in: .userDomainMask)
        
        if let lastObject: AnyObject = URLs.last as AnyObject? {
            if let  directoryURL = lastObject as? URL {
                return directoryURL
            }
        }
        return nil
    }
    
    /**
     Convenience method for checking whether a file exists in /Document.
     */
    open class func findsFileWithName(_ fileName: String) -> Bool {
        return self.findsFileWithName(fileName, inFolder: .documentDirectory)
    }
    
    open class func findsFileWithName(_ fileName: String, inFolder folder: FileManager.SearchPathDirectory) -> Bool {
        if let filePath = self.URLForFileName(fileName, inFolder: folder) {
            return FileManager.default.fileExists(atPath: filePath.path)
        }
        return false
    }
    
    open class func findsFileInURL(_ fileURL: URL) -> Bool {
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    open class func writeValue<T: MDArchivableValueType>(_ value: T, toFile fileName: String, inFolder folder: FileManager.SearchPathDirectory = .documentDirectory) throws {
        guard let fileURL = self.URLForFileName(fileName, inFolder: folder)
            else {
                throw MDFileManagerError.cantBuildPathToFile(fileName, inFolder: folder)
        }
        
        let dictionary = value.toDictionary()
        if NSKeyedArchiver.archiveRootObject(dictionary, toFile: fileURL.path) == false {
            throw MDFileManagerError.cantArchiveValue(value)
        }
    }
    
    open class func writeValue(_ value: AnyObject, toFile fileName: String, inFolder folder: FileManager.SearchPathDirectory = .documentDirectory) throws {
        guard let fileURL = self.URLForFileName(fileName, inFolder: folder)
            else {
                throw MDFileManagerError.cantBuildPathToFile(fileName, inFolder: folder)
        }
        
        if NSKeyedArchiver.archiveRootObject(value, toFile: fileURL.path) == false {
            throw MDFileManagerError.cantArchiveValue(value)
        }
    }
    
    open class func valueAtFile<T: MDArchivableValueType>(_ fileName: String, inFolder folder: FileManager.SearchPathDirectory = .documentDirectory) -> T? {
        if let fileURL = self.URLForFileName(fileName, inFolder: folder),
            let dictionary = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path) as? [String : AnyObject] {
            return T(fromDictionary: dictionary)
        }
        return nil
    }
    
    open class func valueAtFile<T>(_ fileName: String, inFolder folder: FileManager.SearchPathDirectory = .documentDirectory) -> T? {
        if let fileURL = self.URLForFileName(fileName, inFolder: folder),
            let object = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path) as? T {
            return object
        }
        return nil
    }
    
    open class func deleteValueAtFile(_ fileName: String, inFolder folder: FileManager.SearchPathDirectory = .documentDirectory) throws {
        guard let fileURL = self.URLForFileName(fileName, inFolder: folder) else {
            return
        }
        
        if self.findsFileInURL(fileURL) {
            try FileManager.default.removeItem(at: fileURL)
        }
    }
    
}
