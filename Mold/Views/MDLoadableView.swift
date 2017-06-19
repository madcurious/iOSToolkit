//
//  MDLoadableView.swift
//  Mold
//
//  Created by Matt Quiros on 18/06/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

public func ==(lhs: MDLoadableView.State, rhs: MDLoadableView.State) -> Bool {
    switch (lhs, rhs) {
    case (.initial, .initial),
         (.loading, .loading),
         (.data, .data),
         (.error(_), .error(_)),
         (.noData(_), .noData(_)):
        return true
        
    default:
        return false
    }
}

public func !=(lhs: MDLoadableView.State, rhs: MDLoadableView.State) -> Bool {
    return !(lhs == rhs)
}

open class MDLoadableView: UIView {
    
    public enum State: Equatable {
        case initial
        case loading
        case data
        case error(Error)
        
        /// The loading task succeeded but there was no data found.
        /// You may optionally pass any data with the state, such as a
        /// custom `String` message or an attributed string.
        case noData(Any?)
    }
    
    open var state = MDLoadableView.State.initial
    
}
