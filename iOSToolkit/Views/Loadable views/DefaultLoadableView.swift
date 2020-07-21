//
//  DefaultLoadableView.swift
//  iOSToolkit
//
//  Created by Matt Quiros on 19/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

/**
Default subclass of `LoadableView`.

The view shows the following subviews according to the following states:

* `.initial` - nothing
* `.loading` - the `loadingView`, which is a `UIActivityIndicatorView`
* `.empty(_)` - a label (i.e. the `informationView` with the `informationLabel` only and no `retryButton`)
* `.error(_)` - a label and a retry button (i.e. the `informationView` with both the `informationlabel` and the `retryButton`)
* `.success` - the `successView`
*/
class DefaultLoadableView: LoadableView {
	
	@IBOutlet weak var loadingView: UIActivityIndicatorView!
	@IBOutlet weak var informationView: UIStackView!
	@IBOutlet weak var informationLabel: UILabel!
	@IBOutlet weak var retryButton: UIButton!
	@IBOutlet weak var successView: UIView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupStructure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupStructure()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupStructure()
	}
	
	fileprivate func setupStructure() {
		let viewFromNib = viewFromOwnedNib()
		addSubviewAndFill(viewFromNib)
		updateAppearance(forState: .initial)
		
		informationLabel.numberOfLines = 0
		informationLabel.lineBreakMode = .byWordWrapping
		informationLabel.textAlignment = .center
		
		retryButton.setTitle("Retry", for: .normal)
	}
	
	override func updateAppearance(forState state: LoadableView.State) {
		switch state {
		case .initial:
			loadingView.stopAnimating()
			loadingView.isHidden = true
			successView.isHidden = true
			informationView.isHidden = true
			
		case .loading:
			loadingView.startAnimating()
			loadingView.isHidden = false
			successView.isHidden = true
			informationView.isHidden = true
			
		case .empty:
			loadingView.stopAnimating()
			loadingView.isHidden = true
			successView.isHidden = true
			informationLabel.text = "No data found."
			informationView.isHidden = false
			
		case .success:
			loadingView.stopAnimating()
			loadingView.isHidden = true
			successView.isHidden = false
			informationLabel.text = nil
			informationView.isHidden = true
			
		case .failure:
			loadingView.stopAnimating()
			loadingView.isHidden = true
			successView.isHidden = true
			informationLabel.text = "Error found."
			informationView.isHidden = false
		}
	}
	
}
