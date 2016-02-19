//
//  MQAlertDialog.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 8/3/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

public class MQAlertDialog {
    
    public class func showInPresenter(presenter: UIViewController,
        title: String? = nil,
        message: String = "Message",
        cancelButtonTitle: String = "OK") {
            let alertController = UIAlertController(title: title,
                message: message,
                preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: cancelButtonTitle,
                style: .Cancel) { _ in
                    presenter.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(cancelAction)
            
            presenter.presentViewController(alertController, animated: true, completion: nil)
    }
    
}