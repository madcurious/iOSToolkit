//
//  MDStatefulViewController.swift
//  Mold
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

public class MDStatefulViewController: UIViewController {
    
    public enum View {
        case Starting, Loading, Retry, Primary, NoResults
    }
    
    public var operationQueue = NSOperationQueue()
    public var currentView = View.Loading
    
    var defaultStartingView = MDDefaultStartingView()
    var defaultLoadingView = MDLoadingView()
    var defaultRetryView = MDDefaultRetryView()
    var defaultNoResultView = MDDefaultNoResultsView()
    var defaultPrimaryView = UIView()
    
    public var startingView: MQStartingView {
        return self.defaultStartingView
    }
    
    public var loadingView: UIView {
        return self.defaultLoadingView
    }
    
    public var retryView: MDRetryView {
        return self.defaultRetryView
    }
    
    public var noResultsView: MDNoResultsView {
        return self.defaultNoResultView
    }
    
    public var primaryView: UIView {
        return self.defaultPrimaryView
    }
    
    /**
     A flag used by `viewWillAppear:` to check if it will be the first time for
     the view controller to appear. If it is, the view controller will setup the
     task and start it.
     
     This initial run of the `request` is written inside `viewWillAppear:`
     instead of `viewDidLoad` so that a child class can just override `viewDidLoad`
     normally and not worry about when the parent class automatically starts the task.
     */
    var firstLoad = true
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let view = UIView()
        self.view = view
        
        view.addSubviews(self.startingView,
            self.loadingView,
            self.primaryView,
            self.retryView,
            self.noResultsView
        )
    }
    
    /**
     Override point for setting custom Autolayout constraints for the different
     states' views.
     */
    public func setupViewConstraints() {
        self.startingView.fillSuperview()
        self.loadingView.fillSuperview()
        self.primaryView.fillSuperview()
        self.retryView.fillSuperview()
        self.noResultsView.fillSuperview()
    }
    
    public func buildOperation() -> MDOperation? {
        fatalError("Unimplemented function \(#function)")
    }
    
    /**
     Creates a new instance of the operation, overrides its callback blocks to show state views, and runs it.
     */
    public func runOperation() {
        guard let op = self.buildOperation()
            else {
                return
        }
        
        let originalStartBlock = op.startBlock
        op.startBlock = {[unowned self] in
            originalStartBlock?()
            self.showView(.Loading)
        }
        
        op.failBlock = self.buildFailBlock()
        
        self.operationQueue.addOperation(op)
    }
    
    /**
     Override point for customising the `failBlock` that automatically gets executed
     when the stateful view controller's operation fails.
     */
    public func buildFailBlock() -> (ErrorType -> Void) {
        return {[unowned self] error in
            self.retryView.error = error
            self.showView(.Retry)
        }
    }
    
    public func showView(view: MDStatefulViewController.View) {
        self.currentView = view
        
        self.startingView.hidden = view != .Starting
        self.loadingView.hidden = view != .Loading
        self.primaryView.hidden = view != .Primary
        self.retryView.hidden = view != .Retry
        self.noResultsView.hidden = view != .NoResults
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewConstraints()
        self.showView(.Starting)
        self.retryView.delegate = self
        self.noResultsView.delegate = self
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // We start the task if the view is appearing for the first time
        // so the you can override viewDidLoad normally.
        if self.firstLoad {
            self.runOperation()
            self.firstLoad = false
        }
    }
    
}

extension MDStatefulViewController: MDRetryViewDelegate {
    
    public func retryViewDidTapRetry(retryView: MDRetryView) {
        self.runOperation()
    }
    
}

extension MDStatefulViewController: MDNoResultsViewDelegate {
    
    public func noResultsViewDidTapRetry(noResultsView: MDNoResultsView) {
        self.runOperation()
    }
    
}
