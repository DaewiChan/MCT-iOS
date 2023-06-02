//
//  APIClient.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient: NSObject{
    static let shared = APIClient()
    
    func requestGETURL(_ strURL: String,_ params: [String : AnyObject]?,headers: HTTPHeaders?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void) {
        print("GET API Link : \(strURL)")
        print("GET Parameter : \(params)")
        print("GET Header : \(headers)")
        AF.request(strURL, method: .get,parameters: params, encoding: URLEncoding.queryString, headers: headers)
            .validate(statusCode: 200 ..< 600)
            .responseJSON { response in
                print("GET API Response : \(response.request?.url?.absoluteString ?? "") :> \(response.result)")
            switch response.result {
                case .success:
                    if let json = response.data {
                        success(json)
                    }
                case let .failure(error):
                    failure(error)
            }
        }
    }
    
    func requestPOSTURL(_ strURL : String, params: [String : AnyObject]?, headers: HTTPHeaders?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void){
        print("POST API Link : \(strURL)")
        print("POST Parameter : \(params)")
        print("POST Header : \(headers)")
        AF.request(strURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200 ..< 600)
            .responseJSON { (response) -> Void in
                print("POST API Header : \(response.response?.allHeaderFields)")
                print("POST API Response : \(response.request?.url?.absoluteString ?? "") :> \(response.result)")
                
                 if let cookie = response.response?.allHeaderFields["Set-Cookie"] as? String {
                     let sessionIds : [String] = cookie.components(separatedBy: ";")
                     let sessionId = sessionIds[0]
                     print("Session ID: \(sessionId )")
//                     PrefHelper.shared.savePrefValueString(PrefKey.SESSION_ID, sessionId)
                 }
//            if let headerFields = response.response?.allHeaderFields as? [String: String], let URL = response.request?.url {
//                 let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: URL)
//                 let sessionIdCookie = cookies.first { cookie in
//                    cookie.name.elementsEqual("session_id")
//                 }
//                 let sessionId = sessionIdCookie?.value
//                 PrefHelper.shared.savePrefValueString(PrefKey.SESSION_ID, sessionId ?? "")
//                 print(cookies)
//            }
            switch response.result {
                case .success:
                    if let json = response.data {
                        success(json)
                    }
                case let .failure(error):
                    failure(error)
            }
        }
    }
    
    func requestRAWJsonURL(_ strURL : String, params: [String : AnyObject]?, headers: HTTPHeaders?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void){
        
        let jsonEncoding = JSONEncoding.default
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        
        AF.request(strURL, method: .post, parameters: params, encoding: jsonEncoding, headers: headers)
            .responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.data {
                    success(json)
                }
            case .failure(let error):
                // Handle failure
                failure(error)
            }
        }
    }
    
    func requestDELETEURL(_ strURL : String, params: [String : AnyObject]?, headers: HTTPHeaders?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void){
        print("POST API Link : \(strURL)")
        print("POST Parameter : \(params)")
        print("POST Header : \(headers)")
        AF.request(strURL, method: .delete, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200 ..< 600)
            .responseJSON { (response) -> Void in
                print("POST API Header : \(response.response?.allHeaderFields)")
                print("POST API Response : \(response.request?.url?.absoluteString ?? "") :> \(response.result)")
                
                 if let cookie = response.response?.allHeaderFields["Set-Cookie"] as? String {
                     let sessionIds : [String] = cookie.components(separatedBy: ";")
                     let sessionId = sessionIds[0]
                     print("Session ID: \(sessionId )")
                 }

            switch response.result {
                case .success:
                    if let json = response.data {
                        success(json)
                    }
                case let .failure(error):
                    failure(error)
            }
        }
    }
    
    func requestURL(_ method: HTTPMethod, _ strURL : String, params: [String : AnyObject]?, headers: HTTPHeaders?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void){
        AF.request(strURL, method: method, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) -> Void in
            switch response.result {
                case .success:
                    if let json = response.data {
                        success(json)
                    }
                case let .failure(error):
                    failure(error)
            }
        }
    }
    
    func requestNewLeave(_ strURL : String,_ imageData: Data?,_ parameters: [String: AnyObject]?,headers: HTTPHeaders?,success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void){
            
        print("Upload POST API Link : \(strURL)")
        print("Upload POST Parameter : \(parameters)")
        print("Upload POST Header : \(headers)")
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters!{
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)! , withName: key)
            }
            if imageData != nil {
//                let imageName = "IMG_\(DateTimeUtil.generateCurrentTimeStamp())"// TODO: change with image name
//                multipartFormData.append(imageData! , withName: "uploads", fileName: "\(imageName).jpeg", mimeType: "image/*")
            }
        }, to: strURL,method: .post,headers: headers)
        .validate(statusCode: 200..<600)
        .responseJSON(completionHandler: { response in
            switch response.result {
                case .success:
                    if let json = response.data {
                        success(json)
                    }
                case let .failure(error):
                    failure(error)
            }
        })
    }
    
    func requestWithFile(_ strURL : String,_ parameters: [String: AnyObject]?,headers: HTTPHeaders?,success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void){
                
        print("Upload POST API Link : \(strURL)")
        print("Upload POST Parameter : \(parameters)")
        print("Upload POST Header : \(headers)")
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters!{
                if let value = value as? String {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)! , withName: key)
                }else if let value = value as? Data {
                    multipartFormData.append(value, withName: key, fileName: "\(key).jpeg", mimeType: "image/*")
                }else if let value = value as? [Data] {
                    for (index, file) in value.enumerated() {
                        multipartFormData.append(file, withName: "\(key)[\(index+1)]", fileName: "\(key).jpeg", mimeType: "image/*")
                    }
                }
            }
//            if imageData != nil {
//                let imageName = "IMG_\(DateTimeUtil.generateCurrentTimeStamp())"// TODO: change with image name
//                multipartFormData.append(imageData! , withName: fileName, fileName: "\(imageName).jpeg", mimeType: "image/*")
//            }
        }, to: strURL,method: .post,headers: headers)
        .validate(statusCode: 200..<600)
        .responseJSON(completionHandler: { response in
            print("Upload API Response : \(response.request?.url?.absoluteString ?? "") :> \(response.result)")
            switch response.result {
                case .success:
                    if let json = response.data {
                        success(json)
                    }
                case let .failure(error):
                    failure(error)
            }
        })
    }
}
