//
//  RegisterVC.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import UIKit
import DropDown

class RegisterVC: BaseVC {

    var phoneCodeLists: [String] = ["+65","+95"]
    
    @IBOutlet weak var vPhoneCode: UIView!
    @IBOutlet weak var lblPhoneCode: UILabel!
    @IBOutlet weak var tfPhoneNo: DTextField!
    @IBOutlet weak var tfEmail: DTextField!
    @IBOutlet weak var tfVerifyCode: DTextField!
    
    @IBOutlet weak var btnCode: UIButton!
    @IBOutlet weak var tfPassword: DTextField!
    @IBOutlet weak var tfConfirmPassword: DTextField!
    
    @IBOutlet weak var btnToogleVisiblePassword: UIButton!
    @IBOutlet weak var btnToogleVisibleConfirmPassword: UIButton!
    @IBOutlet weak var lblLoginHere: UILabel!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    private let presenter = RegisterPresenter(loginService: UserAPIService())
    
    let phoneCodeDD = DropDown()
    var selectPhoneCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.attachView(view: self)
       initUI()
        
    }
    
    func initUI(){
        tfPhoneNo.placeholder = "Enter Phone No"
        tfEmail.placeholder = "Enter Email"
        tfVerifyCode.placeholder = "Enter Code"
        tfPassword.placeholder = "Enter Password"
        tfConfirmPassword.placeholder = "Enter Confirm Password"
        
        catchEvent()
        setupPhoneCodeSpinner()
        
        self.lblPhoneCode.text = phoneCodeLists[0]
        self.selectPhoneCode = phoneCodeLists[0]
        
        tfPassword.isSecureTextEntry = true
        tfConfirmPassword.isSecureTextEntry = true
        btnRegister.roundButton()
        
    }
    
    func catchEvent(){
        let tapPhoneCode = UITapGestureRecognizer(target: self, action: #selector(showAdsTypeSpinner))
        tapPhoneCode.numberOfTouchesRequired = 1
        vPhoneCode.isUserInteractionEnabled = true
        vPhoneCode.addGestureRecognizer(tapPhoneCode)
        
        let tapLoginHere = UITapGestureRecognizer(target: self, action: #selector(showLoginForm))
        tapLoginHere.numberOfTouchesRequired = 1
        lblLoginHere.isUserInteractionEnabled = true
        lblLoginHere.addGestureRecognizer(tapLoginHere)
    }
  
    @objc func showLoginForm(){
        let loginVC = UIStoryboard(name: "Account", bundle: nil).instantiateViewController(withIdentifier: "login") as! LoginVC
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
    @objc func showAdsTypeSpinner(_ sender: AnyObject) {
        phoneCodeDD.show()
    }
    
    func setupPhoneCodeSpinner() {
        phoneCodeDD.anchorView = vPhoneCode
        
        phoneCodeDD.dataSource = phoneCodeLists
     
        phoneCodeDD.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblPhoneCode.text = item
            self.selectPhoneCode = phoneCodeLists[index]
        }
    }
    

    @IBAction func pressVerifyCode(_ sender: Any) {
        if isVallidGetCode(){
            presenter.getVerifyCode(tfEmail.text ?? "")
        }
    }
    
    @IBAction func pressRegister(_ sender: Any) {
        if isVallidRegister(){
            presenter.register(tfEmail.text ?? "", CommonUtil.shared.sha256(tfPassword.text ?? "") ?? "", tfVerifyCode.text ?? "", selectPhoneCode ?? "", tfPhoneNo.text ?? "")
        }
    }
    
    private func isVallidGetCode() -> Bool {
        if (tfEmail.text ?? "").isEmpty {
            self.showAlertController("", withMessage: "Enter Email")
            return false
        }
        
        return true
    }
    
    private func isVallidRegister() -> Bool {
        if selectPhoneCode == nil{
            self.showAlertController("", withMessage: "Select Phone Code")
            return false
        }else if (tfPhoneNo.text ?? "").isEmpty {
            self.showAlertController("", withMessage: "Enter Phone No")
            return false
        }
        else if (tfEmail.text ?? "").isEmpty {
            self.showAlertController("", withMessage: "Enter Email")
            return false
        }else if (tfVerifyCode.text ?? "").isEmpty{
            self.showAlertController("", withMessage: "You need to get Verify Code first!!")
            return false
        }else if (tfPassword.text ?? "").isEmpty{
            self.showAlertController("", withMessage: "Enter Password")
            return false
        }else if (tfConfirmPassword.text ?? "").isEmpty{
            self.showAlertController("", withMessage: "Enter Confirm Password")
            return false
        }
    
        return true
    }
}

extension RegisterVC: RegisterView{
    func showRegisterSuccess(message: String) {
        self.showLoginForm()
    }
    
    func showVerifyCode(data: GetVerifyCodeDataVO) {
        if let code = data.devVerifyCode{
            tfVerifyCode.text = code
        }
    }
    
    func startLoading() {
        self.showProgressDialog("")
    }
    
    func finishLoading() {
        self.hideProgressDialog()
    }
    
    func showErrorView(title: String, message: String) {
        self.showAlertController("", withMessage: message)
    }
    
    
}
