//
//  MDDataModel.swift
//  Mold
//
//  Created by Matt Quiros on 7/3/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

public protocol MDDataModel {
    
    /**
    Returns an array of the model's current values as form field objects. Whenever this function is
    called, a new array of `MDField` objects is created.
    */
    func editableFields() -> [MDField]
    
    /**
    Updates the data model based on the values of a given collection of form fields.
    */
    mutating func updateWithFieldCollection(fields: MDFieldCollection<Self>)
    
}