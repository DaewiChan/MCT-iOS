//
//  GetVerifyCodeDataVO.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import ObjectMapper

class GetVerifyCodeDataVO: Mappable{
    var validityPreiod: Int?
    var countdown: Int?
    var method: String?
    var devVerifyCode: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        validityPreiod <- map["validity_period"]
        countdown <- map["countdown"]
        method <- map["method"]
        devVerifyCode <- map["dev:verify_code"]
    }
}

//    "data": {
//    "validity_period": 300,
//    "countdown": 60,
//    "method": "email",
//    "dev:verify_code": "384776"
//},
