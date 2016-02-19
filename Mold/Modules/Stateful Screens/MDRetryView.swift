//
//  MDRetryView.swift
//  Mold
//
//  Created by Matt Quiros on 4/27/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public protocol MDRetryViewDelegate {
    
    func retryViewDidTapRetry(retryView: MDRetryView)
    
}

public class MDRetryView: UIView {
    
    public var error: NSError?
    public var delegate: MDRetryViewDelegate?
    
}
