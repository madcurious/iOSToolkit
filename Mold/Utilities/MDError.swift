//
//  MDError.swift
//  Mold
//
//  Created by Matt Quiros on 21/06/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

public struct MDError: LocalizedError {
    
    let message: String
    
    public var errorDescription: String? {
        return self.message
    }
    
    public init(_ message: String) {
        self.message = message
    }
    
}
