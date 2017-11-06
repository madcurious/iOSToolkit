//
//  BRTest.swift
//  Bedrock
//
//  Created by Matt Quiros on 28/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

public final class BRTest {
    
    public enum FailureType {
        case error(Error)
        case `nil`
        case noResult
    }
    
    public class func fail(_ functionName: String, type: FailureType) -> String {
        var message = functionName + " - "
        switch type {
        case .error(let error):
            message.append("Error occurred: \(error)")
        case .nil:
            message.append("Unexpected nil objects")
        case .noResult:
            message.append("No result")
        }
        return message
    }
    
}
