//
//  MQErrorDialog.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 4/25/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public final class MQErrorDialog {
    
    public class func showError(error: NSError, inPresenter presenter: UIViewController) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        let okButtonAction = UIAlertAction(title: "OK", style: .Default) {_ in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(okButtonAction)
        
        MQDispatcher.asyncRunInMainThread {
            presenter.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
}
