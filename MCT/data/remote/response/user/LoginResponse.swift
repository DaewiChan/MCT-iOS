//
//  LoginResponse.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import ObjectMapper

class LoginResponse: Mappable{
    var code: Int?
    var loginData: LoginDataVO?
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        loginData <- map["data"]
        message <- map["message"]
    }
}
