//
//  String+Util.swift
//  TSToolKit_Swift
//
//  Created by three stone 王 on 2018/11/13.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import Foundation

// MARK: 字符串长度 length
extension String {
    
    func length() -> Int {
        
        return lengthOfBytes(using: .utf8)
    }
}
// MARK: validPhone
extension String {
    
    static func validPhone(phone: String) -> Bool {
        
        guard !phone.isEmpty else {
            
            return false
        }
        
        guard phone.length() == 11 ,phone.hasPrefix("1") else {
            
            return false
        }
        return true
    }
}
