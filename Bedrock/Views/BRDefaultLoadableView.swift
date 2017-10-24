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
    @IBOutlet weak var informationView: UIStackView!
    @IBOutlet public weak var informationLabel: UILabel!
    @IBOutlet public weak var retryButton: UIButton!
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
        
        retryButton.setTitle("Retry", for: .normal)
    }
    
    fileprivate func updateView(forState state: BRLoadableViewState) {
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
