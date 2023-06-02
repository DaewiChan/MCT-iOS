//
//  LoginByEmailRequest.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
class LoginByEmailRequest: Codable{
    var email: String?
    var password: String?
    var s_code: String?
}
