//
//  GetVerifyCodeResponse.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import ObjectMapper

class GetVerifyCodeResponse: Mappable{
    var code: Int?
    var verifyCodeData: GetVerifyCodeDataVO?
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        verifyCodeData <- map["data"]
        message <- map["message"]
    }
}

//{
//    "code": 0,
//    "data": {
//    "validity_period": 300,
//    "countdown": 60,
//    "method": "email",
//    "dev:verify_code": "384776"
//},
//    "message": "Tip.发送成功"
//}
