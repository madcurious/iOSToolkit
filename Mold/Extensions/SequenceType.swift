//
//  SequenceType.swift
//  Mold
//
//  Created by Matt Quiros on 07/06/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

public extension SequenceType {
    
    /**
     Returns a dictionary where the key is the group, and the value is an array of member elements.
     */
    @warn_unused_result public func groupBy<T: Equatable>(@noescape groupKey: Generator.Element -> T?) -> [T : [Generator.Element]] {
        var dict: [T : [Generator.Element]] = [:]
        for element in self {
            guard let key = groupKey(element)
                else {
                    continue
            }
            
            // If the key already exists in the dictionary, append the element to the list.
            if let _ = dict.indexForKey(key) {
                dict[key]?.append(element)
            }
            
                // Otherwise create a new key-value pair.
            else {
                dict[key] = [element]
            }
        }
        return dict
    }
    
}