//
//  ProfileVC.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    private let presenter = ProfilePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        setupUI()
        loadData()
    }
    
    func setupUI() {
        logoutButton.roundButton()
    }
    
    func loadData() {
        presenter.getUserInfo()
    }
    
    @IBAction func pressLogout(_ sender: Any) {
        showLogout()
    }
    
    func showLogin() {
        let loginVC = UIStoryboard(name: "Account", bundle: nil).instantiateViewController(withIdentifier: "login") as! LoginVC
        loginVC.modalPresentationStyle = .fullScreen
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        appDel.window?.rootViewController = loginVC
    }
    
    func showLogout() {
        let dialog = LogoutDialogVC(nibName: "LogoutDialogVC", bundle: nil)

        dialog.delegate = self
        dialog.modalPresentationStyle = .overFullScreen
        dialog.modalTransitionStyle = .crossDissolve
        self.present(dialog, animated: true, completion:nil)
    }
}

extension ProfileVC: LogoutDialogDelegate{
    func pressLogout() {
        PrefHelper.shared.clearUserSession()
        showLogin()
    }
}

extension ProfileVC: ProfileView {
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func showErrorView(title: String, message: String) {
        
    }
    
    func showUserInfo(info: LoginUserData) {
        nameLabel.text = "\(info.firstName ?? "") \(info.lastName ?? "")"
        phoneNumberLabel.text = info.phoeNo
    }
    
    func showUserInfo(name: String, phoneNumber: String) {
        nameLabel.text = name
        phoneNumberLabel.text = phoneNumber
    }
}
