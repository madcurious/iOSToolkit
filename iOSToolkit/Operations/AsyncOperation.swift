//
//  AsyncOperation.swift
//  iOSToolkit
//
//  Created by Matthew Liwag Quiros on 25/06/2019.
//  Copyright © 2019 Matthew Quiros. All rights reserved.
//

import Foundation

/// Asynchronous operation that produces a result. The class is meant to be subclassed and not to be used as it is.
///
/// Unlike its synchronous parent class, the `start()` function of this class only dispatches the execution of the `main()`
/// function to a separate thread. The developer must invoke `finish()` somewhere in the asynchronous task performed by
/// the `main()` function. Failing to call `finish()` will never fire the KVO notifications that update the operation's execution state,
/// causing the operation never to terminate and, if added to an operation queue, never to be deallocated.
///
///     class NetworkRequestOperation: AsyncOperation<Data, NetworkRequestError> {
///       override func main() {
///         let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
///           defer {
///             self.finish() // properly updates the execution state
///           }
///           if let error = error {
///             // ...
///             return
///           }
///           guard let data = data
///           else {
///             // ...
///             return
///           }
///           // process data ...
///         }
///         dataTask.resume()
///       }
///
///     }
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
