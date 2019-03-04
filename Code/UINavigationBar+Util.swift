//
//  UINavigationBar+Util.swift
//  TSToolKit_Swift
//
//  Created by three stone 王 on 2019/3/4.
//  Copyright © 2019年 three stone 王. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    
    public func wl_setBackgroundColor(_ color: UIColor) {
        
        let view = UIView(frame: bounds)
        
        setValue(view, forKey: "backgroundView")
    }
}
