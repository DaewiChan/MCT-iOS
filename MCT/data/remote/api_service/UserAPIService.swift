//
//  UserAPIService.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import RxSwift

class UserAPIService {
    
    static let shared = UserAPIService()
    
    // MARK: User
    func login(_ loginEndPoint: UserEndPoints) -> Observable<LoginResponse> {
        return UserAPIManager.shared.login(loginEndPoint)
    }
    
    func getVerifyCode(_ loginEndPoint: UserEndPoints) -> Observable<GetVerifyCodeResponse> {
        return UserAPIManager.shared.getVerifyCode(loginEndPoint)
    }
}
