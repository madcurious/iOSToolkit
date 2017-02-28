//
//  MDOperationCallbackBlock.swift
//  Mold
//
//  Created by Matt Quiros on 28/02/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

public struct MDOperationCallbackBlock {
    
    var runsInMainThread: Bool
    var block: () -> ()
    
}
