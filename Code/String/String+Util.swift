//
//  String+Util.swift
//  TSToolKit_Swift
//
//  Created by three stone 王 on 2018/11/13.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import Foundation
import UIKit

// MARK: 去除空格和换行之后是否为空

extension NSString {
    @objc (wl_isEmpty)
    public var wl_isEmpty: Bool { return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    
    @objc (validPhoneWithPhone:)
    public static func validPhone(phone: String) -> Bool {
        
        guard !phone.isEmpty else {  return false }
        
        guard phone.length == 11 ,phone.hasPrefix("1") else { return false }
        
        return true
    }
    @objc (validEmailWithEmail:)
    public static func validEmail(email: String) -> Bool {
        
        guard !email.isEmpty else { return false }
        
        return email.validEmail()
    }
    
    private func validEmail() -> Bool {
        // 正则表达式
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with:self)
    }
    @objc (firstLetter)
    public func firstLetter() -> String { return (self as String).firstLetter() }
    
    @objc (transformToPinyin)
    public func transformToPinyin() -> String { return (self as String).transformToPinYin() }
    
    @objc (caculateHeightWithSize:andFontSize:andLineSpace:)
    public func caculateHeight(_ size: CGSize,fontSize: CGFloat ,lineSpace: CGFloat = 1) -> CGFloat {
        
        let style = NSMutableParagraphStyle()
        
        style.lineSpacing = lineSpace
        
        let h = boundingRect(with: size, options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.height
        
        return h
    }
    @objc (caculateWidthWithSize:andFontSize:andLineSpace:)
    public func caculateWidth(_ size: CGSize,fontSize: CGFloat ,lineSpace: CGFloat = 1) -> CGFloat {
        
        let style = NSMutableParagraphStyle()
        
        style.lineSpacing = lineSpace
        
        let h = boundingRect(with: size, options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.width
        
        return h
    }
    
    @objc (converToDateS1)
    public func converToDateS1() -> String { return (self as String).converToDateS1() }
    @objc (converToDateS2)
    public func converToDateS2() -> String { return (self as String).converToDateS2() }
    @objc (converToDateS3)
    public func converToDateS3() -> String { return (self as String).converToDateS3() }
}
extension String {
    
    public var wl_isEmpty: Bool { return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
}

// MARK: 字符串长度 length
extension String {
    // 可以用 lengthOfBytes(using: ) 计算不同编码的长度 得到的是字节的数量 需要运算才能得到字符的数量
    
    public var length: Int { return count }
}
// MARK: validPhone
extension String {
    
    public static func validPhone(phone: String) -> Bool {
        
        guard !phone.isEmpty else { return false }
        
        guard phone.length == 11 ,phone.hasPrefix("1") else { return false }
        
        return true
    }
}

// MARK: validEmail
extension String {
    
    public static func validEmail(email: String) -> Bool {
        
        guard !email.isEmpty else { return false }
        
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
        
        guard !carNo.isEmpty else { return false }
        
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
        
        guard !isEmpty else { fatalError("TSToolKit_Swift 字符串不能为空") }
        
        return String(self[..<index(after: startIndex)])
    }
}

// MARK: pinyin
extension String {
    
    public func transformToPinYin() -> String {
        
        guard !isEmpty else { fatalError("TSToolKit_Swift 字符串不能为空") }
        
        let mutableString = NSMutableString(string: self)
        
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        
        let string = String(mutableString)
        
        return string.replacingOccurrences(of: " ", with: "")
    }
}

// MARK: 计算中文长度
extension String {
    // emoji 按照2个字符算
    public func byteLength() -> Int {
        
        let le = count
        // [一-龥]
        let pattern = "[\u{4e00}-\u{9fa5}]"
        //
        do {
            
            let regex = try NSRegularExpression(pattern: pattern, options: [NSRegularExpression.Options.caseInsensitive])
            
            let matches = regex.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, le))
            
            return matches
        } catch  {
            
            fatalError(error.localizedDescription)
        }
    }
}
extension String {
    
    public func transformToPinyin() -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false) // 转换为带音标的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false) // 去掉音标
        let pinyin = stringRef as String
        return pinyin.replacingOccurrences(of: " ", with: "")
    }
}
// MARK: 计算 宽度 高度
extension String {
    
    public func caculateHeight(_ size: CGSize,fontSize: CGFloat ,lineSpace: CGFloat = 1) -> CGFloat { return (self as NSString).caculateHeight(size, fontSize: fontSize, lineSpace: lineSpace) }
    
    public func caculateWidth(_ size: CGSize,fontSize: CGFloat ,lineSpace: CGFloat = 1) -> CGFloat { return (self as NSString).caculateWidth(size, fontSize: fontSize, lineSpace: lineSpace) }
}
// MARK: 计算日期
extension String {
    
    public func converToDateS1() -> String {
        
        let df = DateFormatter()
        
        df.dateFormat = "MM.dd HH:mm"
        
        let interval = Double(self) ?? 0
        
        let date = Date(timeIntervalSince1970: interval)
        
        return df.string(from: date)
    }
    public func converToDateS2() -> String {
        
        let df = DateFormatter()
        
        df.dateFormat = "yyyy-MM-dd hh:mm"
        
        let interval = Double(self) ?? 0
        
        let date = Date(timeIntervalSince1970: interval)
        
        return df.string(from: date)
    }
    public func converToDateS3() -> String {
        
        let df = DateFormatter()
        
        let interval = Double(self) ?? 0
        
        let current = Date().timeIntervalSince1970
        
        let time = current - interval
        
        let seconds: Int = Int(time)
        
        if seconds < 60 {
            return "\(seconds)秒前"
        }
        
        let minutes: Int = Int(time) / 60
        
        if minutes < 60 {
            return "\(minutes)分钟前"
        }
        
        let hours: Int = Int(time) / 3600
        
        if hours < 24 {
            return "\(hours)小时前"
        }
        
        df.dateFormat = "yyyy-MM-dd hh:mm"
        
        let date = Date(timeIntervalSince1970: interval)
        
        return df.string(from: date)
    }
}
