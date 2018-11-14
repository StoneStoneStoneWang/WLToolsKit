//
//  ViewController.swift
//  TSToolKit_Swift
//
//  Created by three stone 王 on 2018/11/13.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = UIButton(type: .custom)
        
        view.addSubview(a)
        
        a.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        a.backgroundColor = TSHEXCOLOR(hexColor: "#000000")
        
        let b = UIButton(type: .custom)
        
        view.addSubview(b)
        
        b.frame = CGRect(x: 0, y: 200, width: 100, height: 100)
        
        b.backgroundColor = TSHEXCOLOR_ALPHA(hexColor: "#eeeeee20")
        
        printLog(message: CGFloat(20) / 100)
    }
}

//Users/threestonewang/Desktop/新的仓库/TSToolKit_Swift/TSToolKit_Swift/TSToolKit_Swift/ViewController.swift:33:20: Generic parameter 'T' could not be inferred
