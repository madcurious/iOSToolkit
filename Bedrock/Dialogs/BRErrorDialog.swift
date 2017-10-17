//
//  BRErrorDialog.swift
//  Bedrock
//
//  Created by Matt Quiros on 4/25/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public final class BRErrorDialog {
    
    public class func showError(_ error: Error, from presentingViewController: UIViewController, dialogTitle: String? = nil, cancelButtonTitle: String = "OK") {
        let message = error.localizedDescription
        
        let alertController = UIAlertController(title: dialogTitle, message: message, preferredStyle: .alert)
        let cancelButtonAction = UIAlertAction(title: cancelButtonTitle, style: .default) {_ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelButtonAction)
        
        BRDispatch.asyncRunInMain {
            presentingViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
}
