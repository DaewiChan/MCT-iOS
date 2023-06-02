//
//  RegisterPresenter.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import Foundation

protocol RegisterView: BaseView{
    func showRegisterSuccess(message: String)
    func showVerifyCode(data: GetVerifyCodeDataVO)
}

class RegisterPresenter: BasePresenter{
    private let apiService: UserAPIService
    private var view : RegisterView?
    
    init(loginService: UserAPIService) {
        self.apiService = loginService
    }
    
    func attachView(view: RegisterView) {
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
    
    func register(_ email: String,_ password: String,_ scode: String,_ phoneCode: String, _ phoneNo: String) {
        
        let req = RegisterByEmailRequest()
        req.email = email
        req.password = password
        req.s_code = scode
        req.phoneCode = phoneCode
        req.phoneNo = phoneNo
        
        let regReq = UserEndPoints.registerWithEmail(request: req)
        self.view?.startLoading()
        apiService.login(regReq)
            .subscribe(onNext: { [weak self] response in
                self?.view?.finishLoading()
                
                self?.view?.showRegisterSuccess(message: response.message ?? "")
                                                    
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
        req.scene = "reg"
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
