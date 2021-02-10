//
//  NSPersistentContainer.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 09/11/2016.
//  Copyright © 2016 Matthew Quiros. All rights reserved.
//

import Foundation
import CoreData

@available(iOS 10.0, *)
extension NSPersistentContainer {
    
    func newChildViewContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.viewContext
        return context
    }
    
}
