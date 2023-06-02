//
//  UserApiManager.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import Alamofire
import RxSwift

class UserAPIManager {
    
    static let shared = UserAPIManager()
    let mApiClient = APIClient.shared
    
    // MARK: User
    func login(_ loginEndPoint: UserEndPoints) -> Observable<LoginResponse> {
        return Observable.create { observer -> Disposable in
            self.mApiClient.requestRAWJsonURL(loginEndPoint.url, params: loginEndPoint.parameters as? [String : AnyObject] ?? [:], headers: loginEndPoint.headers, success: { (response) in
                let responseJSON = JSON(response)
                let resp = Mapper<LoginResponse>().map(JSONString: responseJSON.rawString()!)
                observer.onNext(resp!)
            }) { (error) in
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func getVerifyCode(_ loginEndPoint: UserEndPoints) -> Observable<GetVerifyCodeResponse> {
        return Observable.create { observer -> Disposable in
            self.mApiClient.requestRAWJsonURL(loginEndPoint.url, params: loginEndPoint.parameters as? [String : AnyObject] ?? [:], headers: loginEndPoint.headers, success: { (response) in
                let responseJSON = JSON(response)
                let resp = Mapper<GetVerifyCodeResponse>().map(JSONString: responseJSON.rawString()!)
                observer.onNext(resp!)
            }) { (error) in
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
