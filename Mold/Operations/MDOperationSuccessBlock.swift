//
//  MDOperationSuccessBlock.swift
//  Mold
//
//  Created by Matt Quiros on 01/03/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

public struct MDOperationSuccessBlock {
    
    var runsInMainThread: Bool
    var block: (Any?) -> ()
    
    public init(runsInMainThread: Bool = true, block: @escaping (Any?) -> ()) {
        self.runsInMainThread = runsInMainThread
        self.block = block
    }
    
}
