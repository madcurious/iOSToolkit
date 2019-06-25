//
//  LoadPersistentContainerOperations.swift
//  Bedrock
//
//  Created by Matt Quiros on 19/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation
import CoreData

@available(iOS 10.0, *)
public class LoadPersistentContainerOperation: AsyncOperation<NSPersistentContainer, Error> {
	
	let documentName: String
	let inMemory: Bool
	
	public init(documentName: String, inMemory: Bool, completionBlock: OperationCompletionBlock?) {
		self.documentName = documentName
		self.inMemory = inMemory
		super.init(completionBlock: completionBlock)
	}
	
	public override func main() {
		let persistentContainer = NSPersistentContainer(name: documentName)
		if inMemory,
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
