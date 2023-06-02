//
//  LoginVC.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import UIKit
enum UserType: String{
    case userLogin = "user"
    case adminLogin = "admin"
}

class LoginVC: BaseVC {

    @IBOutlet weak var rbUserLogin: DRadioButton!
    @IBOutlet weak var rbAdminLogin: DRadioButton!
    
    @IBOutlet weak var tfEmail: DTextField!
    @IBOutlet weak var tfVerifyCode: DTextField!
    @IBOutlet weak var tfPassword: DTextField!
    @IBOutlet weak var btnGetCode: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblRegisterHere: UILabel!
    @IBOutlet weak var btnPasswordVisible: UIButton!
    @IBOutlet weak var lblVerifyCode: UILabel!
    @IBOutlet weak var svVerifyCode: UIStackView!
    
    private let loginPresenter = LoginPresenter(loginService: UserAPIService())
    
    var userType = UserType.userLogin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginPresenter.attachView(view: self)
        initUI()
        catchEvent()
    }
    
    func initUI() {
        rbAdminLogin.alternateButton = [ rbUserLogin ]
        rbUserLogin.alternateButton = [ rbAdminLogin ]
        
        tfEmail.placeholder = "Enter email"
        tfPassword.isSecureTextEntry = true
        tfPassword.placeholder = "Enter password"
        btnLogin.roundButton()
    }
    
    func catchEvent(){
        let tapRegister = UITapGestureRecognizer(target: self, action: #selector(pressRegister))
        tapRegister.numberOfTouchesRequired = 1
        lblRegisterHere.isUserInteractionEnabled = true
        lblRegisterHere.addGestureRecognizer(tapRegister)
    }
    
    @objc func pressRegister(){
        let registerVC = UIStoryboard(name: "Account", bundle: nil).instantiateViewController(withIdentifier: "register") as! RegisterVC
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC, animated: true)
    }
    
    @IBAction func togglePasswordVisible(_ sender: Any) {
        if tfPassword.isSecureTextEntry {
            tfPassword.isSecureTextEntry = false
            btnPasswordVisible.setImage(UIImage.init(named: "ic_password_visible"), for: .normal)
        }else {
            tfPassword.isSecureTextEntry = true
            btnPasswordVisible.setImage(UIImage.init(named: "ic_password_hidden"), for: .normal)
        }
    }
    
    @IBAction func pressGetCode(_ sender: Any) {
        if isVallidGetCode(){
            loginPresenter.getVerifyCode(tfEmail.text ?? "")
        }
    }
    
    @IBAction func pressLogin(_ sender: Any) {
        if userType == UserType.userLogin{
            if isVallidLogin(){
                loginPresenter.login(tfEmail.text ?? "", CommonUtil.shared.sha256(tfPassword.text ?? "") ?? "", tfVerifyCode.text ?? "")
            }
        }else{
          
            if isVallidLogin(){
                PrefHelper.shared.savePrefValueBool(PrefKey.IS_LOGIN, true)
                PrefHelper.shared.savePrefValueString(PrefKey.ADMIN_TOKEN, "b1f3f9224b37e0798a1019d71c31c8fdd371f790")
                PrefHelper.shared.savePrefValueString(PrefKey.USER_TYPE, "admin")
                
                showHome()
            }
         
        }
       
      //  showHome()
    }
    
    @IBAction func changeUserType(_ sender: Any) {
        let radioButton = sender as! DRadioButton
        let radioButtonTag = radioButton.tag
        switch radioButtonTag {
        case 1: showUserLoginForm()
        case 2: showAdminLoginForm()
        default:
            userType = UserType.userLogin
        }
    }
    
    private func isVallidGetCode() -> Bool {
        if (tfEmail.text ?? "").isEmpty {
            self.showAlertController("", withMessage: "Enter Email")
            return false
        }
        
        return true
    }
    
    private func isVallidLogin() -> Bool {
        if (tfEmail.text ?? "").isEmpty {
            self.showAlertController("", withMessage: "Enter Email")
            return false
        }else if (tfPassword.text ?? "").isEmpty{
            self.showAlertController("", withMessage: "Enter Password")
            return false
        }
        
        if userType == UserType.userLogin{
            if (tfVerifyCode.text ?? "").isEmpty{
                self.showAlertController("", withMessage: "You need to get Verify Code first!!")
                return false
            }
        }
        return true
    }
    
    private func showUserLoginForm(){
        userType = UserType.userLogin
        lblVerifyCode.isHidden = false
        svVerifyCode.isHidden = false
    }
    
    private func showAdminLoginForm(){
        userType = UserType.adminLogin
        lblVerifyCode.isHidden = true
        svVerifyCode.isHidden = true
    }
}

extension LoginVC: LoginView{
    func showHome() {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! MainVC
        mainVC.modalPresentationStyle = .fullScreen
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        appDel.window?.rootViewController = mainVC
    }
    
    func showVerifyCode(data: GetVerifyCodeDataVO) {
        if let verifyCode = data.devVerifyCode{
            tfVerifyCode.text = verifyCode
        }
    }
    
    func startLoading() {
        self.showProgressDialog("")
    }
    
    func finishLoading() {
        self.hideProgressDialog()
    }
    
    func showErrorView(title: String, message: String) {
        self.showAlertController("", withMessage: message){ isFinish in
            
        }
    }
    
    
}
