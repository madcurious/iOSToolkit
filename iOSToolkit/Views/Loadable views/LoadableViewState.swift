//
//  LoadableViewState.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 7/24/20.
//  Copyright © 2020 Matthew Quiros. All rights reserved.
//

import Foundation

/// The `LoadableView`'s state, which is intended to correspond with the states of an executable task.
enum LoadableViewState {
	
	/// The view state before a task is executed.
	case initial
	
	/// The view state while a task is executing.
	case loading
	
	/// The view state after a task finishes executing and successfully returns a result.
	case success
	
	/// The view state after a task finishes executing and returns an empty or a null result.
	case empty
	
	/// The view state after a task finishes executing and returns an error.
	case failure
	
}
