//
//  FailableOperation.swift
//  Bedrock
//
//  Created by Matthew Liwag Quiros on 25/06/2019.
//  Copyright © 2019 Matt Quiros. All rights reserved.
//

import Foundation

protocol FailableOperation {
	
	/// Determines whether the operation failed or not. Non-failure
	/// does not necessarily mean success. It could also mean the absence of a
	/// result because the operation has not started yet, or the operation
	/// was cancelled.
	var isFailed: Bool { get }
	
}
