//
//  MDOperationViewController.swift
//  Mold
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

public func ==(lhs: MDOperationViewController.State, rhs: MDOperationViewController.State) -> Bool {
    switch (lhs, rhs) {
        case (.initial, .initial),
             (.loading, .loading),
             (.displaying, .displaying),
             (.failed(_), .failed (_)),
             (.empty, .empty):
        return true
        
    default:
        return false
    }
}

public func != (lhs: MDOperationViewController.State, rhs: MDFullOperationViewController.State) -> Bool {
    return !(lhs == rhs)
}

open class MDOperationViewController: UIViewController {
    
    public enum State {
        case initial
        case loading
        case displaying
        case failed(Error)
        case empty
    }
    
    open var operationQueue = OperationQueue()
    open var currentState = State.initial
    
    /**
     A flag used by `viewWillAppear:` to check if it will be the first time for
     the view controller to appear. If it is, the view controller will setup the
     task and start it.
     
     This initial run of the `request` is written inside `viewWillAppear:`
     instead of `viewDidLoad` so that a child class can just override `viewDidLoad`
     normally and not worry about when the parent class automatically starts the task.
     */
    var firstLoad = true
    
    open func makeOperation() -> MDOperation? {
        fatalError("Unimplemented function \(#function)")
    }
    
    /**
     Creates a new instance of the operation, overrides its callback blocks to show state views, and runs it.
     */
    open func runOperation() {
        self.operationQueue.cancelAllOperations()
        
        guard let op = self.makeOperation()
            else {
                return
        }
        op.delegate = self
        
//        let originalStartBlock = op.startBlock
//        op.startBlock = {[unowned self] in
//            originalStartBlock?()
//            self.updateView(forState: .loading)
//        }
        
//        op.failBlock = {[unowned self] error in
//            self.updateView(forState: .failed(error))
//        }
        
        self.operationQueue.addOperation(op)
    }
    
    /**
     Override point for updating the view controller's view for the specified state.
     You MUST always call super.
     */
    open func updateView(forState state: MDOperationViewController.State) {
        self.currentState = state
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // We start the task if the view is appearing for the first time
        // so the you can override viewDidLoad normally.
        if self.firstLoad {
            self.runOperation()
            self.firstLoad = false
        }
    }
    
}

extension MDOperationViewController: MDOperationDelegate {
    
    public func operationWillRunStartBlock(_ operation: MDOperation) {
        MDDispatcher.asyncRunInMainThread {[unowned self] in
            self.updateView(forState: .loading)
        }
    }
    
    public func operation(_ operation: MDOperation, didRunFailureBlockWithError error: Error) {
        MDDispatcher.asyncRunInMainThread {[unowned self] in
            self.updateView(forState: .failed(error))
        }
    }
    
}
