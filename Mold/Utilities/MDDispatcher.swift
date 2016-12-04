//
//  MDDispatcher.swift
//  Mold
//
//  Created by Matt Quiros on 4/23/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

open class MDDispatcher {
    
    /**
    Executes the specified block in the main thread and waits until it returns.
    The function guarantees that no deadlocks will occur. If the current thread is the main
    thread, it executes there. If it isn't, the block is dispatched to the main thread.
    */
    open class func syncRunInMainThread(_ block: () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.sync {
                block()
            }
        }
    }
    
    open class func asyncRunInMainThread(_ block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
    
    open class func asyncRunInBackgroundThread(_ block: @escaping () -> Void) {
        DispatchQueue.global().async {
            block()
        }
    }
    
}
