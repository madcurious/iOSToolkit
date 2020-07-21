//
//  LoadableView.swift
//  iOSToolkit
//
//  Created by Matt Quiros on 21/08/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

/// A container view that shows and hides its subviews depending on the state of an executable task
/// which this view is representing.
///
/// This class is intended to be subclassed, within which should be defined and added the subviews to be
/// shown or hidden during state changes. Subclasses, in turn, are intended to be subviews in a view hierarchy.
class LoadableView: UIView {
	
	/// The `LoadableView`'s state, which is intended to correspond with the states of an executable task.
	enum State {
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
	
	var state = State.initial {
		didSet {
			updateAppearance(forState: state)
		}
	}
	
	func updateAppearance(forState state: State) {
		
	}
	
}
