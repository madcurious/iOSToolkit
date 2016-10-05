//
//  MDErrorType.swift
//  Mold
//
//  Created by Matt Quiros on 09/11/2015.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

public protocol MDErrorType: Error {
    
    func object() -> MDError
    
}
