//
//  MDStatefulViewController.swift
//  Mold
//
//  Created by Matt Quiros on 17/03/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

open class MDStatefulViewController: UIViewController {
    
    public enum State {
        case initial
        case loading
        case displaying
        case failed(Error)
        case empty
    }
    
    open var currentState = MDStatefulViewController.State.initial
    
    /**
     Override point for updating the view controller's view for the specified state.
     You MUST always call super.
     */
    open func updateView(forState state: MDStatefulViewController.State) {
        self.currentState = state
    }
    
}
