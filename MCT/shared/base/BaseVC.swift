//
//  BaseVC.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import Foundation
import UIKit
import JGProgressHUD
import MessageUI

class BaseVC: UIViewController{
    var progressDialog = JGProgressHUD()
    
    override func viewDidLoad() {
        
    }
    
    // MARK: Progress Dialog
    
    func showProgressDialog(_ message: String) {
        if !progressDialog.isVisible {
            progressDialog = JGProgressHUD(style: .dark)
            progressDialog.textLabel.text = message
            progressDialog.show(in: self.view)
        }
    }
    
    func hideProgressDialog() {
        progressDialog.dismiss()
    }
}

extension UIViewController {
    func showAlertController(_ title: String, withMessage message: String,onFinish SuccessCallback: ((_ isFinish: Bool) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            SuccessCallback!(true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertController(_ title: String, withMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "OK", style: .default)
        //yesAction.setValue(UIColor(hexString: ThemeColor.colorPrimary), forKey: "titleTextColor")
        alertController.addAction(yesAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
