//
//  MDRetryView.swift
//  Mold
//
//  Created by Matt Quiros on 4/27/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

open class MDRetryView: UIView, MDOperationRerunnerView {
    
    open var error: Error?
    open var delegate: MDOperationRerunnerViewDelegate?
    
}
