//
//  MDErrorDialog.swift
//  Mold
//
//  Created by Matt Quiros on 4/25/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public final class MDErrorDialog {
    
    public class func showError(error: NSError, inPresenter presenter: UIViewController, dialogTitle: String? = nil, cancelButtonTitle: String = "OK") {
        let alertController = UIAlertController(title: dialogTitle, message: error.localizedDescription, preferredStyle: .Alert)
        let cancelButtonAction = UIAlertAction(title: cancelButtonTitle, style: .Default) {_ in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(cancelButtonAction)
        
        MDDispatcher.asyncRunInMainThread {
            presenter.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
}
