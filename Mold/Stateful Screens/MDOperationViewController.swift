//
//  MDOperationViewController.swift
//  Mold
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

open class MDOperationViewController: UIViewController {
    
    public enum View {
        case starting, loading, retry, primary, noResults
    }
    
    open var operationQueue = OperationQueue()
    
    // Default views are lazy-initialized so that they aren't initialized
    // if a child class overrides the actual properties.
    lazy var defaultStartingView = UIView()
    lazy var defaultLoadingView = UIView()
    lazy var defaultRetryView = UIView()
    lazy var defaultNoResultView = UIView()
    lazy var defaultPrimaryView = UIView()
    
    open var startingView: UIView {
        return self.defaultStartingView
    }
    
    open var loadingView: UIView {
        return self.defaultLoadingView
    }
    
    open var retryView: UIView {
        return self.defaultRetryView
    }
    
    open var noResultsView: UIView {
        return self.defaultNoResultView
    }
    
    open var primaryView: UIView {
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
    
    open override func loadView() {
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
    open func setupViewConstraints() {
        self.startingView.fillSuperview()
        self.loadingView.fillSuperview()
        self.primaryView.fillSuperview()
        self.retryView.fillSuperview()
        self.noResultsView.fillSuperview()
    }
    
    open func buildOperation() -> MDOperation? {
        fatalError("Unimplemented function \(#function)")
    }
    
    /**
     Creates a new instance of the operation, overrides its callback blocks to show state views, and runs it.
     */
    open func runOperation() {
        guard let op = self.buildOperation()
            else {
                return
        }
        
        let originalStartBlock = op.startBlock
        op.startBlock = {[unowned self] in
            originalStartBlock?()
            self.showView(.loading)
        }
        
        op.failBlock = self.buildFailBlock()
        
        self.operationQueue.addOperation(op)
    }
    
    /**
     Override point for customising the `failBlock` that automatically gets executed
     when the stateful view controller's operation fails.
     */
    open func buildFailBlock() -> ((Error) -> Void) {
        return {[unowned self] error in
            if let retryView = self.retryView as? MDRetryView {
                retryView.error = error
            }
            
            self.showView(.retry)
        }
    }
    
    open func showView(_ view: MDOperationViewController.View) {
        self.startingView.isHidden = view != .starting
        self.loadingView.isHidden = view != .loading
        self.primaryView.isHidden = view != .primary
        self.retryView.isHidden = view != .retry
        self.noResultsView.isHidden = view != .noResults
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewConstraints()
        self.showView(.starting)
        
        if var rerunningRetryView = self.retryView as? MDOperationRerunnerView {
            rerunningRetryView.delegate = self
        }
        
        if var rerunningNoResultsView = self.noResultsView as? MDOperationRerunnerView {
            rerunningNoResultsView.delegate = self
        }
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

extension MDOperationViewController: MDOperationRerunnerViewDelegate {
    
    open func rerunnerViewDidFireRerunAction() {
        self.runOperation()
    }
    
}
