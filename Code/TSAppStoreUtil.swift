//
//  TSAppStoreUtil.swift
//  TSToolKit_Swift
//
//  Created by three stone 王 on 2018/11/14.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import UIKit

class TSAppStoreUtil: NSObject {
    // MARK: 单例模式
    public static var util: TSAppStoreUtil = TSAppStoreUtil()
    
    private override init() {
        
    }
    
    fileprivate var appId: String = ""
    
    fileprivate var appStoreUrl: String = ""
    
    fileprivate var appStoreEvaUrl: String = ""
}
// MARK: 注册appid
extension TSAppStoreUtil {
    
    open func regFor(appId: String) {
        
        self.appId = appId
        
        self.appStoreUrl = "itms-apps://itunes.apple.com/app/\(appId)%@?mt=8"
        
        self.appStoreEvaUrl = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(appId)&pageNumber=0&sortOrdering=2&mt=8"
    }
}
extension TSAppStoreUtil {
    
    open func skipToAppStore() -> Bool {
        
        return TSOpenUrl.openUrl(urlString: appStoreUrl)
    }
    
    open func skipToEva() -> Bool {
        
        return TSOpenUrl.openUrl(urlString: appStoreEvaUrl)
    }
}
