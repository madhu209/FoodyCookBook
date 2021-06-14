//
//  AlertManager.swift
// FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 02/07/20.
//  Copyright © 2020 Madhusudhan Reddy. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

internal final class AlertManager {
    
    static let shared = AlertManager()
    private var presenter: UIViewController?

    @objc func displayValidationAlert(title: String = "Alert", message: String, buttonTitle: String = "Dismiss", controller: UIViewController) {
        
        presenter = controller
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: buttonTitle, style: .default) { (alertButtonAction) in
            self.presenter?.dismiss(animated: true, completion: nil)
        }
        alertViewController.addAction(cancelAction)
        presenter?.present(alertViewController, animated: true, completion: nil)
        
    }
        
    @objc func displaySuccessAlert(title: String = "Alert", message: String, buttonTitle: String = "Ok", controller: UIViewController = (appDelegate.window?.rootViewController)!, completionHandler: @escaping (_ data: Any) -> Void) {
        
        controller.view.endEditing(true)

        presenter = controller
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: buttonTitle, style: .cancel) { (action) in
            
            DispatchQueue.main.async {
                completionHandler("we finished!")
            }
            
        }
        alertViewController.addAction(cancelAction)
        presenter?.present(alertViewController, animated: true, completion: nil)
        
    }
    
    @objc func confirmationAlert(title: String = "Alert", message: String, buttonTitle: String = "Ok", controller: UIViewController, completionHandler: @escaping (_ data: Any) -> Void) {
        
        controller.view.endEditing(true)

        presenter = controller
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: buttonTitle == "Yes" ? "No" : "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let cancelAction = UIAlertAction(title: buttonTitle == "Yes" ? "No" : "Cancel", style: .cancel) { (_) in
            
            if title == "Location Disabled" {
                exit(0)
            }
            
        }
        alertViewController.addAction(cancelAction)
        
        let cinformAction = UIAlertAction(title: buttonTitle, style: .default) { (action) in
            
            DispatchQueue.main.async {
                completionHandler("we finished!")
            }
            
        }
        alertViewController.addAction(cinformAction)
        
        presenter?.present(alertViewController, animated: true, completion: nil)
        
    }
    
    @objc func alertWithOutAction(title: String = "Warning", message: String, buttonTitle: String = "Ok", controller: UIViewController) {
        
        controller.view.endEditing(true)

        presenter = controller
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cinformAction = UIAlertAction(title: buttonTitle, style: .default) { (action) in

            DispatchQueue.main.async {
                
            }

        }
        alertViewController.addAction(cinformAction)
        
        presenter?.present(alertViewController, animated: true, completion: nil)
        
    }
    
    /// Displaying PopUp for showing the Error Message
    /// - Parameters:
    ///   - message: Error Message
    ///   - controller: In Which Controller Displaying
    @objc func displayErrorMessage(message: String, controller: UIViewController = (appDelegate.window?.rootViewController)!) {
        
        controller.view.endEditing(true)
        
        // create a new style
        var style = ToastStyle()

        // this is just one of many style options
        style.messageColor = .white

        // present the toast with the new style
        controller.view.makeToast(message, duration: 3.0, position: .center, style: style)

        // or perhaps you want to use this style for all toasts going forward?
        // just set the shared style and there's no need to provide the style again
        ToastManager.shared.style = style

        // toggle "tap to dismiss" functionality
        ToastManager.shared.isTapToDismissEnabled = true

        // toggle queueing behavior
        ToastManager.shared.isQueueEnabled = true
        
    }
    
    
    @objc func shareToOthersThroughSocials(shareMessage: String, controller: UIViewController = (appDelegate.window?.rootViewController)!) {
        
        // text to share
        let text = shareMessage

        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = controller.view // so that iPads won't crash

        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        // present the view controller
        controller.present(activityViewController, animated: true, completion: nil)
        
    }
    
    func alertWithTextField(title: String, message: String = "", controller: UIViewController = (appDelegate.window?.rootViewController)!, completionHandler: @escaping (_ data: Any) -> Void) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        ac.addAction(cancelAction)
        
        ac.addTextField { (textField) in
            textField.placeholder = "Enter Comment"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let textField = ac.textFields![0]
            textField.placeholder = "Enter Comment"
            // do something interesting with "answer" here
            
            DispatchQueue.main.async {
                completionHandler(textField.text!)
            }
            
        }

        ac.addAction(submitAction)

        controller.present(ac, animated: true)
    }
    
}
