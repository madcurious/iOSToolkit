//
//  BRDefaultLoadableView.swift
//  Bedrock
//
//  Created by Matt Quiros on 19/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

public class BRDefaultLoadableView: UIView, BRLoadableView {
    
    @IBOutlet public weak var loadingView: UIActivityIndicatorView!
    @IBOutlet public weak var informationLabel: UILabel!
    @IBOutlet public weak var dataView: UIView!
    
    public var state = BRLoadableViewState.initial {
        didSet {
            updateView(forState: state)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    fileprivate func setup() {
        let viewFromNib = viewFromOwnedNib()
        addSubviewsAndFill(viewFromNib)
        updateView(forState: .initial)
        
        informationLabel.numberOfLines = 0
        informationLabel.lineBreakMode = .byWordWrapping
        informationLabel.textAlignment = .center
    }
    
    fileprivate func updateView(forState state: BRLoadableViewState) {
        switch state {
        case .initial:
            loadingView.stopAnimating()
            loadingView.isHidden = true
            dataView.isHidden = true
            informationLabel.isHidden = true
            
        case .loading:
            loadingView.startAnimating()
            loadingView.isHidden = false
            dataView.isHidden = true
            informationLabel.isHidden = true
            
        case .noData(let someInfo):
            loadingView.stopAnimating()
            loadingView.isHidden = true
            dataView.isHidden = true
            if let message = someInfo?["message"] as? String {
                informationLabel.text = message
            } else {
                informationLabel.text = "No data found."
            }
            informationLabel.isHidden = false
            
        case .data:
            loadingView.stopAnimating()
            loadingView.isHidden = true
            dataView.isHidden = false
            informationLabel.text = nil
            informationLabel.isHidden = true
            
        case .error(let error):
            loadingView.stopAnimating()
            loadingView.isHidden = true
            dataView.isHidden = true
            if let localizedError = error as? LocalizedError {
                informationLabel.text = localizedError.errorDescription
            } else {
                informationLabel.text = error.localizedDescription
            }
            informationLabel.isHidden = false
        }
    }
    
}
