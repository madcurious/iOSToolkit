//
//  MDOperationFailureBlock.swift
//  Mold
//
//  Created by Matt Quiros on 01/03/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

public struct MDOperationFailureBlock {
    
    var runsInMainThread: Bool
    var block: (Error) -> ()
    
    public init(runsInMainThread: Bool = true, block: @escaping (Error) -> ()) {
        self.runsInMainThread = runsInMainThread
        self.block = block
    }
    
}
