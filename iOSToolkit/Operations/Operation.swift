//
//  Operation.swift
//  iOSToolkit
//
//  Created by Matthew Liwag Quiros on 25/06/2019.
//  Copyright © 2019 Matthew Quiros. All rights reserved.
//

import Foundation

/// A synchronous operation that produces a result. If the operation is successful, the result holds a value of type `SuccessType`.
/// Otherwise, the result holds a value of type `FailureType`.
///
/// This class is meant to be extended and not to be used as-is. It is up to the developer to supply the types and to update the
/// `result` property accordingly as the operation progresses in its execution.
///
/// When the operation is finished, it is typical to want to access the value of `result`. There are several ways to do so.
///
/// First, you can access the result in the operation's completion block:
///
///		let operation = SomeCustomOperation() { (op) in
///		  guard op.isCancelled == false,
///		    let result = op.result
///		    else {
///		      return
///		  }
///		  DispatchQueue.main.async {
///		    switch result {
///		    case .success(let successResult):
///		      // ... do something
///		    case .failure(let error):
///		      // ... do something
///		    }
///		  }
///		}
///
///	Another way to access the result is after the fact of an operation's synchronous execution:
///
///		let operation = SomeCustomOperation(completionBlock: nil)
///		operationQueue.addOperations([operation], waitUntilFinished: true)
///		guard let result = operation.result
///		  else {
///		    return
///		}
///		switch result {
///		case .success(let successResult):
///		  // ... do something
///		case .failure(let error):
///		  // ... do something
///		}
///
class Operation<SuccessType, FailureType: Error>: Foundation.Operation, Failable {
	
	/// The type produced by this operation if it succeeds.
	typealias SuccessType = SuccessType
	
	/// The type produced by this operation if it fails.
	typealias FailureType = FailureType
	
	/// The type of the result produced by this operation.
	typealias ResultType = Result<SuccessType, FailureType>
	
	/// The result produced by the operation. You are expected to modify this value in your subclass as you go along your operation's
	/// execution.
	///
	/// The default value is `nil`. Note that both cancelled operations and ready operations (i.e. operations waiting for `start()` to be called)
	/// will both have `nil` results, so don't jump into the conclusion that an operation was cancelled just because the result is `nil`
	/// ---unless, of course, the operation subclass guarantees it so.
	var result: Result<SuccessType, FailureType>?
	
	var isFailed: Bool {
		if case .some(.failure(_)) = result {
			return true
		}
		return false
	}
	
	var hasFailedDependencies: Bool {
		return dependencies.contains(where: {
			if let failableOperation = $0 as? Failable,
				failableOperation.isFailed == true {
				return true
			}
			return false
		})
	}
	
	/// Determines whether the operation should execute after `start()` is called.
	/// The default behavior returns `true` if there are no `Failable` dependencies that failed.
	lazy var shouldExecute = { return self.hasFailedDependencies == false }
	
	typealias OperationCompletionBlock = (_ operation: Operation) -> Void
	
	init(completionBlock: OperationCompletionBlock?) {
		super.init()
		
		// Gives the caller easy access to cancellation state and result.
		self.completionBlock = {
			completionBlock?(self)
		}
	}
	
	override func start() {
		guard isCancelled == false &&
			shouldExecute() == true
			else {
				setFinished(true)
				return
		}
		setExecuting(true)
		main()
		finish()
	}
	
	/// Sets the `isExecuting` flag and makes the proper KVO calls.
	func setExecuting(_ executing: Bool) {
		willChangeValue(forKey: "isExecuting")
		internalExecuting = executing
		didChangeValue(forKey: "isExecuting")
	}
	
	/// Sets the `isFinished` flag and makes the proper KVO calls.
	func setFinished(_ finished: Bool) {
		willChangeValue(forKey: "isFinished")
		internalFinished = finished
		didChangeValue(forKey: "isFinished")
	}
	
	/// Convenience function for setting the execution state to `false`
	/// and the finished state to `true`.
	func finish() {
		setExecuting(false)
		setFinished(true)
	}
	
	// MARK: - State tracking
	
	// Internal flags to track operation state.
	private var internalExecuting = false
	private var internalFinished = false
	
	override var isExecuting: Bool {
		return internalExecuting
	}
	
	override var isFinished: Bool {
		return internalFinished
	}
	
}
