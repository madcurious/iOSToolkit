//
//  MQConfirmDialog.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 5/8/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public class MQConfirmDialog {
    
    public class func showInPresenter(presenter: UIViewController,
        title: String = "Confirm",
        message: String = "Are you sure?",
        confirmButtonTitle: String = "Yes",
        cancelButtonTitle: String = "Cancel",
        confirmAction someAction: (() -> ())?) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            let confirmButtonAction = UIAlertAction(title: confirmButtonTitle,
                style: .Default) { _ in
                    if let confirmAction = someAction {
                        confirmAction()
                    }
                    alertController.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(confirmButtonAction)
            
            let cancelAction = UIAlertAction(title: cancelButtonTitle,
                style: UIAlertActionStyle.Cancel) { _ in
                    alertController.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(cancelAction)
            
            presenter.presentViewController(alertController, animated: true, completion: nil)
    }
    
}