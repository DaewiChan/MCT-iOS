//
//  ProfilePresenter.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import Foundation
import SwiftyJSON

protocol ProfileView: BaseView {
    func showUserInfo(info: LoginUserData)
    func showUserInfo(name: String,phoneNumber: String)
}

class ProfilePresenter: BasePresenter {
    
    private var view: ProfileView?
    
    func attachView(view: ProfileView) {
        self.view = view
    }
    
    func detachView() {
        view = nil
    }
    
    func getUserInfo() {
        let userName = "John"
        let phoneNumber = "+6509980000000"
        self.view?.showUserInfo(name: userName, phoneNumber: phoneNumber)
    }
}
