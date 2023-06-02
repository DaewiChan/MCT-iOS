//
//  PrefHelper.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import Foundation

struct PrefKey {

    static let IS_LOGIN = "K_IS_LOGIN"
    static let USER_TOKEN = "K_ACCESS_TOKEN"
    static let ADMIN_TOKEN = "K_ADMIN_TOKEN"
    static let USER_TYPE = "K_USER_TYPE"
    static let USER_INFO = "K_USER_INFO"
}


class PrefHelper: NSObject {
    static let shared = PrefHelper()
    
    func savePrefValueBool(_ key: String,_ value: Bool){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getPrefValueBool(_ key: String) -> Bool {
        if let prefValue = UserDefaults.standard.object(forKey: key) as? Bool{
            return prefValue
        }else{
            return false
        }
    }
    
    func savePrefValueString(_ key: String,_ value: String)  {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getPrefValueString(_ key: String) -> String {
        if let prefValue = UserDefaults.standard.object(forKey: key) as? String{
            return prefValue
        }else{
            return ""
        }
    }
    
    func  savePrefValueInt(_ key: String,_ value: Int)  {
        UserDefaults.standard.set(value, forKey: key )
    }
    
    func getPrefValueInt(_ key: String) -> Int {
        if let prefValue = UserDefaults.standard.object(forKey: key) as? Int{
            return prefValue
        }else{
            return -1
        }
    }
    
    func clearUserSession() {
        savePrefValueBool(PrefKey.IS_LOGIN, false)
        savePrefValueString(PrefKey.USER_TOKEN, "")
        savePrefValueString(PrefKey.ADMIN_TOKEN, "")
        savePrefValueString(PrefKey.USER_TYPE, "")
    }
    
}
