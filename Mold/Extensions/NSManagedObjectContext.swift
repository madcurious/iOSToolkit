//
//  NSManagedObjectContext.swift
//  Mold
//
//  Created by Matt Quiros on 15/10/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import CoreData

public extension NSManagedObjectContext {
    
    public func saveRecursively(_ completionBlock: ((Error?) -> ())?) {
        func saveAction() {
            do {
                try self.saveIfUpdated()
                if let parentContext = self.parent {
                    parentContext.saveRecursively(completionBlock)
                } else {
                    completionBlock?(nil)
                }
            } catch {
                completionBlock?(error)
            }
        }
        
        switch self.concurrencyType {
        case .confinementConcurrencyType:
            saveAction()
            
        default:
            self.perform(saveAction)
        }
    }
    
    private func saveIfUpdated() throws {
        guard self.hasChanges
            else {
                return
        }
        
        try self.save()
    }
    
}
