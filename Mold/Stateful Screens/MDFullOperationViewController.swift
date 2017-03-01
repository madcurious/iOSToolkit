////
////  MDFullOperationViewController.swift
////  Mold
////
////  Created by Matt Quiros on 08/11/2016.
////  Copyright © 2016 Matt Quiros. All rights reserved.
////
//
//import UIKit
//
///**
// A stateful view controller whose entire view automatically changes depending on the state.
// If only a part of the screen's view updates depending on the state of the operation,
// subclass `MDOperationViewController` instead.
// */
//open class MDFullOperationViewController: MDOperationViewController {
//    
//    // Default views are lazy-initialized so that they aren't initialized
//    // if a child class overrides the actual properties.
//    lazy var defaultInitialView = UIView()
//    lazy var defaultLoadingView = UIView()
//    lazy var defaultErrorView = MDErrorView(frame: CGRect.zero)
//    lazy var defaultEmptyView = UIView()
//    lazy var defaultDisplayView = UIView()
//    
//    open var initialView: UIView {
//        return self.defaultInitialView
//    }
//    
//    open var loadingView: UIView {
//        return self.defaultLoadingView
//    }
//    
//    open var errorView: MDErrorView {
//        return self.defaultErrorView
//    }
//    
//    open var emptyView: UIView {
//        return self.defaultEmptyView
//    }
//    
//    open var displayView: UIView {
//        return self.defaultDisplayView
//    }
//    
//    open override func loadView() {
//        let view = UIView()
//        self.view = view
//        
//        view.addSubviews(self.initialView,
//                         self.loadingView,
//                         self.displayView,
//                         self.errorView,
//                         self.emptyView
//        )
//    }
//    
//    /**
//     Override point for setting custom Autolayout constraints for the different
//     states' views.
//     */
//    open func setupViewConstraints() {
//        self.initialView.fillSuperview()
//        self.loadingView.fillSuperview()
//        self.displayView.fillSuperview()
//        self.errorView.fillSuperview()
//        self.emptyView.fillSuperview()
//    }
//    
//    
//    override open func updateView(forState state: MDOperationViewController.State) {
//        super.updateView(forState: state)
//        
//        self.initialView.isHidden = state != .initial
//        self.loadingView.isHidden = state != .loading
//        self.displayView.isHidden = state != .displaying
//        self.emptyView.isHidden = state != .empty
//        
//        if case .failed(let error) = state {
//            self.errorView.error = error
//            self.errorView.isHidden = false
//        } else {
//            self.errorView.isHidden = true
//        }
//    }
//    
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.setupViewConstraints()
//        self.updateView(forState: .initial)
//        
//        if let errorView = self.errorView as? MDRetryView {
//            errorView.delegate = self
//        }
//        
//        if let emptyView = self.emptyView as? MDRetryView {
//            emptyView.delegate = self
//        }
//    }
//    
//}
//
//extension MDOperationViewController: MDRetryViewDelegate {
//    
//    public func retryViewDidFireRetryAction(_ retryView: MDRetryView) {
//        self.runOperation()
//    }
//    
//}
