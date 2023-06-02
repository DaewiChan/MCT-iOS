//
//  RegisterByEmailRequest.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation

class RegisterByEmailRequest: Codable{
    var email: String?
    var s_code: String?
    var password: String?
    var phoneCode: String?
    var phoneNo: String?
}
