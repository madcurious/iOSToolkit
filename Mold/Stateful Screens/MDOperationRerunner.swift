//
//  MDOperationRerunner.swift
//  Mold
//
//  Created by Matt Quiros on 04/10/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

public protocol MDOperationRerunnerView {
    
    var delegate: MDOperationRerunnerViewDelegate? { get set }
    
}

public protocol MDOperationRerunnerViewDelegate {
    
    func rerunnerViewDidFireRerunAction()
    
}
