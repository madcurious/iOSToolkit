//
//  BRLoadableView.swift
//  Mold
//
//  Created by Matt Quiros on 21/08/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation

public enum BRLoadableViewState: Equatable {
    
    case initial, loading, data, noData(Any?), error(Error)
    
    public static func ==(lhs: BRLoadableViewState, rhs: BRLoadableViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial),
             (.loading, .loading),
             (.data, .data),
             (.noData(_), .noData(_)),
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
