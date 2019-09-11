//
//  BRError.swift
//  Bedrock
//
//  Created by Matt Quiros on 21/06/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

struct BRError: LocalizedError {
    
    let message: String
    
    var errorDescription: String? {
        return self.message
    }
    
    init(_ message: String) {
        self.message = message
    }
    
}
