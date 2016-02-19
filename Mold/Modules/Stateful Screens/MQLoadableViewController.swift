//
//  MQLoadableViewController.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 7/25/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

/**
A view controller that loads and displays information based on the results of an
executable task. An `_MQLoadableViewController` has five subviews, only one of which
are displayed at any given moment:

* `startingView` - The initial state of the view controller, when there is no
information yet. For example, in a blogging app, the `startingView` can tell the
user, "No posts yet! Press the add button to write your first entry."

* `loadingView` - Indicates that the executable task is running in the background.
The `loadingView`, by default, is assigned an instance of `MQLoadingView` in
`setupLoadingView()`. It contains a `UIActivityIndicatorView` and a `UILabel` that says
"Loading." However, you can override this function, not invoke this class's implementation,
and assign your own custom view, which is why the property is of type `UIView`.

* `retryView` - Displayed when the executable task produces an error. The standard
`retryView`, an instance of `MQRetryView`, contains a label that displays the error
message, and a Retry button.

* `primaryView` - The view that is displayed when there are results. An `_MQLoadableViewController`
subclass should override the `setupPrimaryView()` function and set this property.

* `noResultsView` - The view that is displayed when the executable task succeeds,
but finds no results. The standard `noResultsView`, an instance of `MQNoResultsView`,
contains a `UILabel` that says there were no results found.

*/
public class MQLoadableViewController: UIViewController {
    
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
    `request` and start it.
    
    This initial run of the `request` is written inside `viewWillAppear:`
    instead of `viewDidLoad` so that a child class can just override `viewDidLoad`
    normally and not worry about when the parent class automatically starts the `request`.
    */
    var isComingFromViewDidLoad = true
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let mainView = UIView()
        self.view = mainView
        
        // Call this class or the subclass' methods for setting up
        // the subviews.
        self.setupStartingView()
        self.setupLoadingView()
        self.setupRetryView()
        self.setupPrimaryView()
        self.setupNoResultsView()
        
        mainView.addSubviews(self.startingView, self.loadingView, self.primaryView, self.retryView, self.noResultsView)
    }
    
    /**
    Override this function and assign a value to `self.startingView`
    if you want a custom `startingView`.
    */
    public func setupStartingView() {}
    
    /**
    Override this function and assign a value to `self.loadingView`
    if you want a custom `loadingView`.
    */
    public func setupLoadingView() {}
    
    /**
    Override this function and assign a value to `self.retryView`
    if you want a custom `retryView`.
    */
    public func setupRetryView() {}
    
    /**
    Override this function and assign a value to `self.primaryView`
    if you want a custom `primaryView`.
    */
    public func setupPrimaryView() {}
    
    /**
    Override this function and assign a value to `self.noResultsView`
    if you want a custom `noResultsView`.
    */
    public func setupNoResultsView() {}
    
    public func setupViewConstraints() {
        self.startingView.fillSuperview()
        self.loadingView.fillSuperview()
        self.primaryView.fillSuperview()
        self.retryView.fillSuperview()
        self.noResultsView.fillSuperview()
    }
    
    /**
    Override point for creating the `__MQOperation` that the view controller will run and
    display the results of. If there are any pieces of information not yet available to create an
    operation, you can return `nil` so that the view controller is stuck in the `startingView`.
    
    **IMPORTANT** You *must* define the behavior of the `successBlock` from within this function
    as it is up to you how to handle the results. You may show the `primaryView` if the operation succeeds
    and there are items in the data source, or the `noResultsView` if there are none. Alternatively,
    you may also just show the `primaryView` even if the data source is empty.
    */
    public func createOperation() -> __MQOperation? {
        fatalError("Unimplemented function \(__FUNCTION__)")
    }
    
    /**
    Generates a new operation from `createOperation()`, overrides its `startBlock` to show the
    `loadingView` and the `failureBlock` to show the `retryView`, and runs the operation.
    */
    public func runOperation() {
        guard let operation = self.createOperation() else {
            return
        }
        
        operation.startBlock = {[unowned self] in
            self.showView(.Loading)
        }
        
        operation.failureBlock = {[unowned self] error in
            self.retryView.error = error
            self.showView(.Retry)
        }
        
        self.operationQueue.addOperation(operation)
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
        if self.isComingFromViewDidLoad {
            self.runOperation()
            self.isComingFromViewDidLoad = false
        }
    }
    
    public func showView(view: MQLoadableViewController.View) {
        self.startingView.hidden = view != .Starting
        self.loadingView.hidden = view != .Loading
        self.primaryView.hidden = view != .Primary
        self.retryView.hidden = view != .Retry
        self.noResultsView.hidden = view != .NoResults
    }
    
}

extension MQLoadableViewController: MQRetryViewDelegate {
    
    public func retryViewDidTapRetry(retryView: MQRetryView) {
        self.runOperation()
    }
    
}

extension MQLoadableViewController: MQNoResultsViewDelegate {
    
    public func noResultsViewDidTapRetry(noResultsView: MQNoResultsView) {
        self.runOperation()
    }
    
}
