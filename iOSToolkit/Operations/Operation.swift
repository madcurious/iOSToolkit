//
//  Operation.swift
//  iOSToolkit
//
//  Created by Matthew Liwag Quiros on 25/06/2019.
//  Copyright © 2019 Matt Quiros. All rights reserved.
//

import Foundation

/// A synchronous operation that produces a result.
class Operation<SuccessType, FailureType: Error>: Foundation.Operation, Failable {
	
	/// The result produced by the operation, which is modified
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
	
	typealias OperationCompletionBlock = (Bool, Result<SuccessType, FailureType>?) -> Void
	
	init(completionBlock: OperationCompletionBlock?) {
		super.init()
		
		// Gives the caller easy access to cancellation state and result.
		self.completionBlock = {
			completionBlock?(self.isCancelled, self.result)
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
