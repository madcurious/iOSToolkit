//
//  MQDataModel.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 7/3/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

public protocol MQDataModel {
    
    /**
    Returns an array of the model's current values as form field objects. Whenever this function is
    called, a new array of `MQField` objects is created.
    */
    func editableFields() -> [MQField]
    
    /**
    Updates the data model based on the values of a given collection of form fields.
    */
    mutating func updateWithFieldCollection(fields: MQFieldCollection<Self>)
    
}