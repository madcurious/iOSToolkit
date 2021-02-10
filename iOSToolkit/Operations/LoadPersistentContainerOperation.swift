//
//  LoadPersistentContainerOperations.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 19/10/2017.
//  Copyright © 2017 Matthew Quiros. All rights reserved.
//

import Foundation
import CoreData

@available(iOS 10.0, *)
class LoadPersistentContainerOperation: AsyncOperation<NSPersistentContainer, Error> {
	
	enum PersistenceType {
		case inMemory
		case onDisk
	}
	
	let documentName: String
	let persistenceType: PersistenceType
	
	init(documentName: String, persistenceType: PersistenceType, completionBlock: OperationCompletionBlock?) {
		self.documentName = documentName
		self.persistenceType = persistenceType
		super.init(completionBlock: completionBlock)
	}
	
	override func main() {
		let persistentContainer = NSPersistentContainer(name: documentName)
		if persistenceType == .inMemory,
			let description = persistentContainer.persistentStoreDescriptions.first {
			description.type = NSInMemoryStoreType
		}
		
		persistentContainer.loadPersistentStores() { [unowned self] (_, error) in
			defer {
				self.finish()
			}
			
			if self.isCancelled {
				return
			}
			
			if let error = error {
				self.result = .failure(error)
			} else {
				self.result = .success(persistentContainer)
			}
		}
	}
	
}
