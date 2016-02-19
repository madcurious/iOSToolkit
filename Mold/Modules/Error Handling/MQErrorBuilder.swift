//
//  MQErrorBuilder.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 01/11/2015.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

public protocol MQErrorBuilder {
    
    func errorObjectForError(error: ErrorType) -> NSError
    
}