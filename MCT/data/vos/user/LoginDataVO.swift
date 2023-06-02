//
//  LoginDataVO.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import ObjectMapper

class LoginDataVO: Mappable{
    var token: String?
    var userData: LoginUserData?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        userData <- map["user"]
    }
}
