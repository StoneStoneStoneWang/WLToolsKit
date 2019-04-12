//
//  WLAppStoreUtil.swift
//  WLToolKit_Swift
//
//  Created by three stone 王 on 2018/11/14.
//  Copyright © 2018年 three stone 王. All righWL reserved.
//

import UIKit

@objc public final class WLAppStoreUtil: NSObject {
    
    @objc (skipToAppStoreWithAppId:)
    public static func skipToAppStore(_ appId: String) {
        
        WLOpenUrl.openUrl(urlString: "itms-apps://itunes.apple.com/app/id\(appId)?mt=8")
    }
    @objc (skipToEvaWithAppId:)
    public static func skipToEva(_ appId: String) {
        
        WLOpenUrl.openUrl(urlString: "itms-apps://itunes.apple.com/WebObjecWL/MZStore.woa/wa/viewContenWLUserReviews?type=Purple+Software&id=\(appId)&pageNumber=0&sortOrdering=2&mt=8")
    }
}
