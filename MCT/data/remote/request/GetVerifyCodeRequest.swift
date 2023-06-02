//
//  GetVerifyCodeRequest.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import Foundation

class GetVerifyCodeRequest: Codable{
    var email: String?
    var scene: String?
    var method: String?
}
