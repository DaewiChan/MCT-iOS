//
//  LoginPresenter.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import Foundation

protocol LoginView: BaseView{
    func showHome()
    func showVerifyCode(data: GetVerifyCodeDataVO)
}

class LoginPresenter: BasePresenter{
    private let apiService: UserAPIService
    private var view : LoginView?
    
    init(loginService: UserAPIService) {
        self.apiService = loginService
    }
    
    func attachView(view: LoginView) {
        self.view = view
    }
    
    func detachView() {
        view = nil
    }
    
    func showError(_ message: String) {
        if (message.lowercased().contains("expired")) {
            self.view?.showSessionTimeout?(title: "", message: message)
        }else{
            self.view?.showErrorView(title: "", message: message)
        }
    }
    
    func login(_ email: String,_ password: String,_ scode: String) {
        
        let req = LoginByEmailRequest()
        req.email = email
        req.password = password
        req.s_code = scode
        
        let loginReq = UserEndPoints.loginWithEmail(request: req)
        self.view?.startLoading()
        apiService.login(loginReq)
            .subscribe(onNext: { [weak self] response in
                self?.view?.finishLoading()
                
                PrefHelper.shared.savePrefValueBool(PrefKey.IS_LOGIN, true)
                PrefHelper.shared.savePrefValueString(PrefKey.USER_TOKEN, response.loginData?.token ?? "")
                PrefHelper.shared.savePrefValueString(PrefKey.USER_TYPE, "user")
                self?.view?.showHome()
                                                    
            }, onError: { (err) in
                 self.view?.finishLoading()
                let errMsg = JSONUtil.parseError(err.localizedDescription)
                self.view?.showErrorView(title: "", message: errMsg)
            }
        )
        .disposed(by: disposeBag)
   }
    
    func getVerifyCode(_ email: String) {
        
        let req = GetVerifyCodeRequest()
        req.email = email
        req.scene = "login"
        req.method = "email"
        
        let verifyReq = UserEndPoints.getVerifyCode(request: req)
        self.view?.startLoading()
        apiService.getVerifyCode(verifyReq)
            .subscribe(onNext: { [weak self] response in
                self?.view?.finishLoading()
                
                if let verifyData = response.verifyCodeData{
                    self?.view?.showVerifyCode(data: verifyData)
                }
               
            }, onError: { (err) in
                 self.view?.finishLoading()
                let errMsg = JSONUtil.parseError(err.localizedDescription)
                self.view?.showErrorView(title: "", message: errMsg)
            }
        )
        .disposed(by: disposeBag)
   }
}
