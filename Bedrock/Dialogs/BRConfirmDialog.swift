//
//  BRConfirmDialog.swift
//  Bedrock
//
//  Created by Matt Quiros on 5/8/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

open class BRConfirmDialog {
    
    open class func showInPresenter(_ presenter: UIViewController,
        title: String = "Confirm",
        message: String = "Are you sure?",
        confirmButtonTitle: String = "Yes",
        cancelButtonTitle: String = "Cancel",
        confirmAction someAction: (() -> ())?) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let confirmButtonAction = UIAlertAction(title: confirmButtonTitle,
                style: .default) { _ in
                    if let confirmAction = someAction {
                        confirmAction()
                    }
                    alertController.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(confirmButtonAction)
            
            let cancelAction = UIAlertAction(title: cancelButtonTitle,
                style: UIAlertActionStyle.cancel) { _ in
                    alertController.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(cancelAction)
            
            presenter.present(alertController, animated: true, completion: nil)
    }
    
}
