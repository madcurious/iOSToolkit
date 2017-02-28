//
//  MDOperationFailureBlock.swift
//  Mold
//
//  Created by Matt Quiros on 28/02/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

public struct MDOperationFailureBlock {
    
    var runsInMainThread: Bool
    var block: (Error) -> ()
    
}
