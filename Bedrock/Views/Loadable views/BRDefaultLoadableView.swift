//
//  BRDefaultLoadableView.swift
//  Bedrock
//
//  Created by Matt Quiros on 19/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

class BRDefaultLoadableView: UIView, LoadableView {
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var informationView: UIStackView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var dataView: UIView!
    
    var state = LoadableViewState.initial {
        didSet {
            updateView(forState: state)
        }
    }
    
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
        updateView(forState: .initial)
        
        informationLabel.numberOfLines = 0
        informationLabel.lineBreakMode = .byWordWrapping
        informationLabel.textAlignment = .center
        
        retryButton.setTitle("Retry", for: .normal)
    }
    
    fileprivate func updateView(forState state: LoadableViewState) {
        switch state {
        case .initial:
            loadingView.stopAnimating()
            loadingView.isHidden = true
            dataView.isHidden = true
            informationView.isHidden = true
            
        case .loading:
            loadingView.startAnimating()
            loadingView.isHidden = false
            dataView.isHidden = true
            informationView.isHidden = true
            
        case .empty(let someInfo):
            loadingView.stopAnimating()
            loadingView.isHidden = true
            dataView.isHidden = true
            if let message = someInfo?["message"] as? String {
                informationLabel.text = message
            } else {
                informationLabel.text = "No data found."
            }
            informationView.isHidden = false
            
        case .success:
            loadingView.stopAnimating()
            loadingView.isHidden = true
            dataView.isHidden = false
            informationLabel.text = nil
            informationView.isHidden = true
            
        case .error(let error):
            loadingView.stopAnimating()
            loadingView.isHidden = true
            dataView.isHidden = true
            if let localizedError = error as? LocalizedError {
                informationLabel.text = localizedError.localizedDescription
            } else {
                informationLabel.text = error.localizedDescription
            }
            informationView.isHidden = false
        }
    }
    
}
