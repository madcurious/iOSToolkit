//
//  BRLoadableView.swift
//  Bedrock
//
//  Created by Matt Quiros on 21/08/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

public enum BRLoadableViewState: Equatable {
    
    case initial, loading, success, empty([String : AnyHashable]?), error(Error)
    
    public static func ==(lhs: BRLoadableViewState, rhs: BRLoadableViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial),
             (.loading, .loading),
             (.success, .success),
             (.empty(_), .empty(_)),
             (.error(_), .error(_)):
            return true
            
        default:
            return false
        }
    }
    
}

public protocol BRLoadableView {
    
    var state: BRLoadableViewState { get set }
    
}
