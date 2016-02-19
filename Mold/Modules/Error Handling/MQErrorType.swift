//
//  MQErrorType.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 09/11/2015.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

public protocol MQErrorType: ErrorType {
    
    func object() -> MQError
    
}