//
//  MDRetryView.swift
//  Mold
//
//  Created by Matt Quiros on 4/27/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public protocol MDRetryViewDelegate {
    
    func retryViewDidFireRetryAction(_ retryView: MDRetryView)
    
}

public protocol MDRetryView: class {
    
    var delegate: MDRetryViewDelegate? { get set }
    
}
