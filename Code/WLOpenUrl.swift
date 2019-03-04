//
//  WLOpenUrl.swift
//  WLToolKit_Swift
//
//  Created by three stone 王 on 2018/11/14.
//  Copyright © 2018年 three stone 王. All righWL reserved.
//

import UIKit

// MARK: openUrl
open class WLOpenUrl: NSObject {
    
    public static func openUrl(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            if #available(iOS 10.0, *) {
                // iOS 8 及其以上系统运行
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                
                UIApplication.shared.openURL(url)
            }
        }
    }
}

// MARK: openSetting
extension WLOpenUrl {
    
    public static func openSetting() {
        
        let settingUrl = URL(string: UIApplication.openSettingsURLString)
        
        if let url = settingUrl, UIApplication.shared.canOpenURL(url) {
            
            if #available(iOS 10.0, *) {
                // iOS 8 及其以上系统运行
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                
                UIApplication.shared.openURL(url)
            }
        }
    }
}
