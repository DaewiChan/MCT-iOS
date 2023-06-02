//
//  LogoutDialogVC.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import UIKit
protocol LogoutDialogDelegate{
    func pressLogout()
}

class LogoutDialogVC: UIViewController {

    var delegate: LogoutDialogDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pressYes(_ sender: Any) {
        delegate?.pressLogout()
        self.dismiss(animated: true)
    }
    
    @IBAction func pressCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
