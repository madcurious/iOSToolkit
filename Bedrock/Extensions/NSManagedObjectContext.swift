//
//  NSManagedObjectContext.swift
//  Bedrock
//
//  Created by Matt Quiros on 15/10/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
	
	/// Saves this context and all other contexts in its ancestry.
	func saveToStore() throws {
		guard self.hasChanges
			else {
				return
		}
		
		try self.save()
		
		if let parent = self.parent {
			try parent.saveToStore()
		}
	}
	
}
