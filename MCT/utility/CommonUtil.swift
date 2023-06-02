//
//  CommonUtil.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import Foundation
import CommonCrypto

class CommonUtil{
    public static let shared = CommonUtil()
    private init() { }
    
    func sha256(_ input: String) -> String? {
        guard let inputData = input.data(using: .utf8) else {
            return nil
        }
        
        var hashData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = hashData.withUnsafeMutableBytes { hashBytes in
            inputData.withUnsafeBytes { dataBytes in
                CC_SHA256(dataBytes.baseAddress, CC_LONG(inputData.count), hashBytes.bindMemory(to: UInt8.self).baseAddress)
            }
        }
        
        let hashString = hashData.map { String(format: "%02hhx", $0) }.joined()
        return hashString
    }
}
