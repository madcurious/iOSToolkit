//
//  FailableOperation.swift
//  iOSToolkit
//
//  Created by Matthew Liwag Quiros on 25/06/2019.
//  Copyright © 2019 Matthew Quiros. All rights reserved.
//

import Foundation

/// A protocol for any task that can fail. Provides an `isFailed` flag.
/// Note that non-failure does not necessarily mean success--it can also mean
/// the absence of a result due to task cancellation.
protocol Failable {
	
	var isFailed: Bool { get }
	
}
