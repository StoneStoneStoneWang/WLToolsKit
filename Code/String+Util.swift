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
    
    public func length() -> Int {
        
        return lengthOfBytes(using: .utf8)
    }
}
// MARK: validPhone
extension String {
    
    public static func validPhone(phone: String) -> Bool {
        
        guard !phone.isEmpty else {
            
            return false
        }
        
        guard phone.length() == 11 ,phone.hasPrefix("1") else {
            
            return false
        }
        return true
    }
}

// MARK: validEmail
extension String {
    
    public static func validEmail(email: String) -> Bool {
        
        guard !email.isEmpty else {
            
            return false
        }
        
        return email.validEmail()
    }
    
    private func validEmail() -> Bool {
        // 正则表达式
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with:self)
    }
}

// MARK: validateCarNo
extension String {
    
    public static func validateCarNo(carNo: String) -> Bool {
        
        guard !carNo.isEmpty else {
            
            return false
        }
        return carNo.validateCarNo()
    }
    
    private func validateCarNo() -> Bool {
        
        // 正则表达式
        let carRegex: String = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
        
        let carPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", carRegex)
        
        return carPredicate.evaluate(with:self)
    }
}
// MARK: firstLetter
extension String {
    
    public func firstLetter() -> String {
        
        guard !isEmpty else {
            
            fatalError("TSToolKit_Swift 字符串不能为空")
        }
        
        return String(self[..<index(after: startIndex)])
    }
}

// MARK: pinyin

extension String {
    
    public func transformToPinYin() -> String {
        
        guard !isEmpty else {
            
            fatalError("TSToolKit_Swift 字符串不能为空")
        }
        
        let mutableString = NSMutableString(string: self)
        
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        
        let string = String(mutableString)
        
        return string.replacingOccurrences(of: " ", with: "")
    }
}
