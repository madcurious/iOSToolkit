//
//  Sequence.swift
//  Mold
//
//  Created by Matt Quiros on 07/06/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

public extension Sequence {
    
    /**
     Returns a dictionary where the key is the group, and the value is an array of member elements.
     */
    public func groupBy<T: Equatable>(_ groupKey: (Iterator.Element) -> T?) -> [T : [Iterator.Element]] {
        var dict: [T : [Iterator.Element]] = [:]
        for element in self {
            guard let key = groupKey(element)
                else {
                    continue
            }
            
            // If the key already exists in the dictionary, append the element to the list.
            if let _ = dict.index(forKey: key) {
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
