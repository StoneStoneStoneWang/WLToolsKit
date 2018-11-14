//
//  UIColor+Util.swift
//  TSToolKit_Swift
//
//  Created by three stone 王 on 2018/11/14.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import Foundation
import UIKit

public func TSRGBColor(r: CGFloat,g: CGFloat ,b: CGFloat) -> UIColor {
    return TSRGBColor(r: r,g: g ,b: b,alpha: 1)
}
public func TSRGBColor(r: CGFloat,g: CGFloat ,b: CGFloat,alpha: CGFloat) -> UIColor {
    return UIColor(red: r / 255.0,green: g / 255.0,blue: b / 255.0,alpha: alpha)
}

public func TSHEXCOLOR(hexColor: String) -> UIColor {
    
    return UIColor.colorWithHexString(hexColor: hexColor)
}

public func TSHEXCOLOR_ALPHA(hexColor: String) -> UIColor {
    
    return UIColor.alpha_colorWithHexString(hexColor: hexColor)
}

extension UIColor {
    // 传入参数0xffffff 、#ffffff、 ffffff
    fileprivate static func colorWithHexString(hexColor: String) -> UIColor {
        
        var cString: String = hexColor.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        // String should be 6 - 8 characters
        if cString.count < 6 { return .clear }
        
        if cString.hasPrefix("0X") {
            
            let index = cString.index(cString.startIndex, offsetBy: 2)
            
            cString = "\(cString[..<index])"
        }
        
        if cString.hasPrefix("#") { cString = String(cString[cString.index(after: cString.startIndex)...]) }
        
        if cString.length != 6 { return .clear }
        
        var range: NSRange = NSRange(location: 0, length: 2)
        
        let rString = "\(cString[Range(range, in: cString)!])"
        
        range.location = 2
        
        let gString = "\(cString[Range(range, in: cString)!])"
        
        range.location = 4
        
        let bString = "\(cString[Range(range, in: cString)!])"
        
        var r = 0 ,g = 0 ,b = 0
        
        Scanner(string: rString).scanInt(&r)
        
        Scanner(string: gString).scanInt(&g)
        
        Scanner(string: bString).scanInt(&b)
        
        return TSRGBColor(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
    // 要设置透明度 一般情况下透明度都是0.3所以在需要透明度的地方 传入参数如下 #ffffff30 0xffffff30
    fileprivate static func alpha_colorWithHexString(hexColor: String) -> UIColor {
        
        var cString: String = hexColor.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        // String should be 8 - 10 characters
        if cString.count < 8 { return .clear }
        
        if cString.hasPrefix("0X") {
            
            let index = cString.index(cString.startIndex, offsetBy: 2)
            
            cString = "\(cString[..<index])"
        }
        
        if cString.hasPrefix("#") { cString = String(cString[cString.index(after: cString.startIndex)...]) }
        
        if cString.length != 8 { return .clear }
        
        var range: NSRange = NSRange(location: 0, length: 2)
        
        let rString = "\(cString[Range(range, in: cString)!])"
        
        range.location = 2
        
        let gString = "\(cString[Range(range, in: cString)!])"
        
        range.location = 4
        
        let bString = "\(cString[Range(range, in: cString)!])"
        
        range.location = 6
        
        let alphaString = "\(cString[Range(range, in: cString)!])"
        
        var r = 0 ,g = 0 ,b = 0 ,alpha = 0
        
        Scanner(string: rString).scanInt(&r)
        
        Scanner(string: gString).scanInt(&g)
        
        Scanner(string: bString).scanInt(&b)
        
        Scanner(string: alphaString).scanInt(&alpha)
        
        return TSRGBColor(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b) ,alpha: CGFloat(alpha) / 100)
    }
}
