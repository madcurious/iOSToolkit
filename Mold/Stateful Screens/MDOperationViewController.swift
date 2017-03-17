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

//public func != (lhs: MDOperationViewController.State, rhs: MDFullOperationViewController.State) -> Bool {
//    return !(lhs == rhs)
//}

open class MDOperationViewController: MDStatefulViewController {
    
    open var operationQueue = OperationQueue()
    
    /**
     A flag used by `viewWillAppear:` to check if it will be the first time for
     the view controller to appear. If it is, the view controller will setup the
     task and start it.
     
     This initial run of the `request` is written inside `viewWillAppear:`
     instead of `viewDidLoad` so that a child class can just override `viewDidLoad`
     normally and not worry about when the parent class automatically starts the task.
     */
    var firstLoad = true
    
    open func makeOperations() -> [MDOperation]? {
        fatalError("Unimplemented function \(#function)")
    }
    
    /**
     Creates a new instance of the operation, overrides its callback blocks to show state views, and runs it.
     */
    open func runOperations() {
        self.operationQueue.cancelAllOperations()
        
        guard let operations = self.makeOperations()
            else {
                return
        }
        
        for i in 0 ..< operations.count {
            if i == 0 {
                operations[i].startBlock = MDOperationCallbackBlock(block: {[unowned self] in
                    self.updateView(forState: .loading)
                })
            }
            
            operations[i].failureBlock = MDOperationFailureBlock(block: {[unowned self] error in
                self.updateView(forState: .failed(error))
            })
            
            self.operationQueue.addOperation(operations[i])
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // We start the task if the view is appearing for the first time
        // so the you can override viewDidLoad normally.
        if self.firstLoad {
            self.runOperations()
            self.firstLoad = false
        }
    }
    
}
