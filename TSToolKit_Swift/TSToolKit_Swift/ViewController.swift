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
        
        let tf = UITextField()
        
        tf.frame = CGRect(x: 0, y: 100, width: 300, height: 44)
        
        tf.backgroundColor = .red
        
        view.addSubview(tf)
        
        tf.delegate = self
        
        tf.addTarget(self, action: #selector(onEditChanged(_:)), for: .editingChanged)
    }
    
    @objc fileprivate func onEditChanged(_ tf: UITextField) {
        
//        var toBeString = tf.text!;
//
//        while toBeString.length > 10 {
//
//            toBeString = "\(toBeString[..<toBeString.index(before: toBeString.endIndex)])"
//
//            tf.text = toBeString;
//        }
        
        let str: String = ""
        
        
    }
    
    
}
extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        printLog(message: textField.text?.fastestEncoding)
        
        printLog(message: string.fastestEncoding)
        
//        var toBeString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//
//        let charLen = toBeString.byteLength()
//
//        printLog(message: textField.text)
//
//        printLog(message: toBeString)
//
//        if charLen > 10 {
//
//            if string != "" {
//
//                if textField.text!.byteLength() != 10 {
//
//                    while toBeString.byteLength() > 10 {
//
//                        printLog(message: toBeString)
//
//                        toBeString = "\(toBeString[..<toBeString.index(before: toBeString.endIndex)])"
//
//                        printLog(message: toBeString)
//
//                        textField.text = toBeString
//                    }
//                }
//                return false
//            }
//        }
        
        return true
    }
    
}
//Users/threestonewang/Desktop/新的仓库/TSToolKit_Swift/TSToolKit_Swift/TSToolKit_Swift/ViewController.swift:33:20: Generic parameter 'T' could not be inferred
