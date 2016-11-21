//
//  NSPersistentContainer.swift
//  Mold
//
//  Created by Matt Quiros on 09/11/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation
import CoreData

@available(iOS 10.0, *)
public extension NSPersistentContainer {
    
    func newChildViewContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.viewContext
        return context
    }
    
}
