//
//  UserEndPoint.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import Alamofire

enum UserEndPoints: Endpoint{
    case loginWithEmail(request: LoginByEmailRequest)
    case registerWithEmail(request: RegisterByEmailRequest)
    case adminLogin(username: String, password: String)
    case getVerifyCode(request: GetVerifyCodeRequest)
    
    var httpMethod: HTTPMethod{
        switch self{
        case .loginWithEmail, .registerWithEmail, .adminLogin, .getVerifyCode:
            return .post
        }
    }
    
    var path: String{
        switch self{
        case .loginWithEmail:
            return "user/passport/login_by_email"
        case .registerWithEmail:
            return "user/passport/reg_by_email"
        case .adminLogin:
            return "admin/passport/login"
        case .getVerifyCode:
            return "user/common/send_code"
        }
    }
    
    var headers: Alamofire.HTTPHeaders?{
        switch self {
        case .loginWithEmail:
            return ["Content-Type": "application/json",
                    "Accept": "application/json"]
        case .registerWithEmail:
            return ["Content-Type": "application/json",
                    "Accept": "application/json"]
        case .adminLogin:
            return ["Content-Type": "application/json",
                    "Accept": "application/json"]
        case .getVerifyCode:
            return ["Content-Type": "application/json",
                    "Accept": "application/json"]
        }
    }
    
    var parameters: [String : Any]?{
        switch self{
        case .loginWithEmail(let request):
            return [
                "email" : request.email ?? "",
                "password" : request.password ?? "",
                "s_code" : request.s_code ?? ""
            ]
            
        case .registerWithEmail(let request):
            return [
                "email" : request.email,
                "password" : request.password,
                "s_code" : request.s_code,
                "phone" : request.phoneNo,
                "phone_code" : request.phoneCode
            ]
            
        case .adminLogin(let username, let password):
            return [
                "username" : username,
                "password" : password
            ]
            
        case .getVerifyCode(let req):
            return [
                "email" : req.email,
                "scene" : req.scene,
                "method" : req.method
            ]
        }
    }
    
    
}
