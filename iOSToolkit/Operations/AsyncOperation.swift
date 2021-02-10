//
//  AsyncOperation.swift
//  iOSToolkit
//
//  Created by Matthew Liwag Quiros on 25/06/2019.
//  Copyright © 2019 Matthew Quiros. All rights reserved.
//

import Foundation

/// Asynchronous operation that produces a result. The `start()` function of this class only dispatches the execution
/// of the `main()` function to a separate thread. As stated in the Apple docs, in asynchronous operations,
/// it is the developer's duty to define the termination points of the operation and to update its KVC flags accordingly.
class AsyncOperation<SuccessType, FailureType: Error>: Operation<SuccessType, FailureType> {
	
	override var isConcurrent: Bool {
		return true
	}
	
	override var isAsynchronous: Bool {
		return true
	}
	
	override func start() {
		guard isCancelled == false &&
			shouldExecute() == true
			else {
				setFinished(true)
				return
		}
		setExecuting(true)
		Thread.detachNewThreadSelector(#selector(main), toTarget: self, with: nil)
	}
	
}
