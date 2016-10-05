//
//  MDErrorDialog.swift
//  Mold
//
//  Created by Matt Quiros on 4/25/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public final class MDErrorDialog {
    
    public class func showError(_ error: Error, inPresenter presenter: UIViewController, dialogTitle: String? = nil, cancelButtonTitle: String = "OK") {
        let message: String = {
            if let error = error as? MDErrorType {
                return error.object().message
            }
            return (error as NSError).localizedDescription
        }()
        
        let alertController = UIAlertController(title: dialogTitle, message: message, preferredStyle: .alert)
        let cancelButtonAction = UIAlertAction(title: cancelButtonTitle, style: .default) {_ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelButtonAction)
        
        MDDispatcher.asyncRunInMainThread {
            presenter.present(alertController, animated: true, completion: nil)
        }
    }
    
}
