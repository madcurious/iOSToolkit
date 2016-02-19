//
//  MQNoResultsView.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 5/1/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public protocol MQNoResultsViewDelegate {
    
    func noResultsViewDidTapRetry(noResultsView: MQNoResultsView)
    
}

public class MQNoResultsView: UIView {
    
    public var text: String?
    public var delegate: MQNoResultsViewDelegate?
    
}
