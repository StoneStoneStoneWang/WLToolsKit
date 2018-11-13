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

extension UIColor {
    
    fileprivate static func colorWithHexString(hexColor: String) -> UIColor {
        
        var cString: String = hexColor.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        // String should be 6 or 8 characters
        if cString.length() < 6 { return .clear }
        
        if cString.hasPrefix("0X") {
            
            let index = cString.index(after: (cString.index(after: cString.startIndex)))
            
            cString = "\(cString[..<index])"
        }
        
        if cString.hasPrefix("#") { cString = String(cString[cString.index(after: cString.startIndex)...]) }
        
        if cString.length() != 6 { return .clear }
        
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
}
