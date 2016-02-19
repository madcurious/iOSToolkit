//
//  MDNoResultsView.swift
//  Mold
//
//  Created by Matt Quiros on 5/1/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public protocol MDNoResultsViewDelegate {
    
    func noResultsViewDidTapRetry(noResultsView: MDNoResultsView)
    
}

public class MDNoResultsView: UIView {
    
    public var text: String?
    public var delegate: MDNoResultsViewDelegate?
    
}
