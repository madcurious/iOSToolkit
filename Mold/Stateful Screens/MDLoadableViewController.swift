//
//  MDLoadableViewController.swift
//  Mold
//
//  Created by Matt Quiros on 17/03/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

public func ==(lhs: MDLoadableViewController.State, rhs: MDLoadableViewController.State) -> Bool {
    switch (lhs, rhs) {
    case (.initial, .initial),
         (.loading, .loading),
         (.showing, .showing),
         (.failed(_), .failed(_)),
         (.empty, .empty):
        return true
        
    default:
        return false
    }
}

public func !=(lhs: MDLoadableViewController.State, rhs: MDLoadableViewController.State) -> Bool {
    return !(lhs == rhs)
}

open class MDLoadableViewController: UIViewController {
    
    public enum State {
        case initial
        case loading
        case showing
        case failed(Error)
        case empty
    }
    
    open var currentState = MDLoadableViewController.State.initial
    
    /**
     Override point for updating the view controller's view for the specified state.
     You MUST always call super.
     */
    open func updateView(forState state: MDLoadableViewController.State) {
        self.currentState = state
    }
    
}
