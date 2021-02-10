//
//  LoadableView.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 21/08/2017.
//  Copyright © 2017 Matthew Quiros. All rights reserved.
//

import UIKit

/// A view that shows and hides its subviews depending on the state of an executable task which this view is representing.
protocol LoadableView: UIView {
	
	var state: LoadableViewState { get set }
	
	func updateAppearance(forState state: LoadableViewState)
	
}
