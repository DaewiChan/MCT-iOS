//
//  LoginUserData.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import ObjectMapper

class LoginUserData: Mappable, Decodable {
    var id: String?
    var nickName: String?
    var imgUrl: String?
    var gender: Int?
    var status: Int?
    var type: String?
    var typeText: String?
    var lastName: String?
    var firstName: String?
    var phoneCode: String?
    var email: String?
    var phoeNo: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        nickName <- map["nickName"]
        imgUrl <- map["avatar"]
        gender <- map["gender"]
        status <- map["status"]
        type <- map["type"]
        typeText <- map["type_text"]
        lastName <- map["last_name"]
        firstName <- map["first_name"]
        phoneCode <- map["phone_code"]
        email <- map["mask_email"]
        phoeNo <- map["mask_phone"]
    }
}

