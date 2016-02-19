//
//  MQStatefulViewController.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 01/02/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

public class MQStatefulViewController: UIViewController {
    
    public enum View {
        case Starting, Loading, Retry, Primary, NoResults
    }
    public var operationQueue = NSOperationQueue()
    
    public var startingView: MQStartingView = MQDefaultStartingView()
    public var loadingView: UIView = MQLoadingView()
    public var retryView: MQRetryView = MQDefaultRetryView()
    public var primaryView = UIView()
    public var noResultsView: MQNoResultsView = MQDefaultNoResultsView()
    
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
    
    public func buildOperation() -> MQOperation? {
        fatalError("Unimplemented function \(__FUNCTION__)")
    }
    
    public func runTask() {
        guard let task = self.buildOperation()
            else {
                return
        }
        
        task.startBlock = {[unowned self] in
            self.showView(.Starting)
        }
        
        task.failBlock = {[unowned self] error in
            self.retryView.error = error
            self.showView(.Retry)
        }
        
        self.operationQueue.addOperation(task)
    }
    
    public func showView(view: MQStatefulViewController.View) {
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
            self.runTask()
            self.firstLoad = false
        }
    }
    
}

extension MQStatefulViewController: MQRetryViewDelegate {
    
    public func retryViewDidTapRetry(retryView: MQRetryView) {
        self.runTask()
    }
    
}

extension MQStatefulViewController: MQNoResultsViewDelegate {
    
    public func noResultsViewDidTapRetry(noResultsView: MQNoResultsView) {
        self.runTask()
    }
    
}
