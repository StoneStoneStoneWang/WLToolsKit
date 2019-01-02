//
//  UIImage+Util.swift
//  TSToolKit_Swift
//
//  Created by three stone 王 on 2018/11/14.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import Foundation
import UIKit

// MARK: colorTransformToImage
public extension UIImage {
    
    public static func colorTransformToImage(color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        
        context.fill(rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return img
    }
}
// MARK: viewTransformToImage
extension UIImage {
    // 转场的时候可能会用到 之后写转场动画的时候使用遇到问题在解决这个
    public static func viewTransformToImage(view: UIView) -> UIImage? {
        
        UIGraphicsBeginImageContext(view.bounds.size)
        
        if view.responds(to: #selector(view.drawHierarchy(in:afterScreenUpdates:))) {
            
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        } else {
            
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
        }
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
    }
    
    // 什么时候都能用
    public static func viewTransformToImg(view: UIView) -> UIImage? {
        
        UIGraphicsBeginImageContext(view.bounds.size)
        
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
    }
}

extension UIImage {
    // 字符串转图片
    public static func stringTransformToImg(_ string: String ,_ attribute: [NSAttributedString.Key : Any],_ size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        (string as NSString).draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), withAttributes: attribute)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
    }
    
}
// MARK: 截取图片的一部分
extension UIImage {
    
    public static func wl_imageFromImage(_ image: UIImage ,inRect rect: CGRect) -> UIImage {
        
        let scale = UIScreen.main.scale
        
        let x = rect.origin.x * scale ,y = rect.origin.y * scale ,w = rect.width * scale ,h = rect.height * scale
        
        let dianRect = CGRect(x: x, y: y, width: w, height: h)
        
        let sourceImageRef: CGImage = image.cgImage!
        
        let newCGImage = sourceImageRef.cropping(to: dianRect)
        
        let newImage = UIImage(cgImage: newCGImage!, scale: scale, orientation: .up)
        
        return newImage
    }
}
extension UIImage {
    
    // MARK: 存入图片
    public static func wl_imagePath(image: UIImage,imageName: String) -> String {
        
        let data = image.jpegData(compressionQuality: 1)
        
        let documentsPath = (NSHomeDirectory() as NSString).appendingPathComponent("Documents")
        
        let fm = FileManager.default
        
        try! fm.createDirectory(atPath: documentsPath, withIntermediateDirectories:  true, attributes: nil)
        
        let imagePath = "/\(imageName)"
        
        fm.createFile(atPath: "\(documentsPath)\(imagePath)", contents: data, attributes: nil)
        
        return "\(documentsPath)\(imagePath)"
    }
    
    // MARK: 存入图片
    public static func wl_imagePath(data: Data,imageName: String) -> String {
        
        let documentsPath = (NSHomeDirectory() as NSString).appendingPathComponent("Documents")
        
        let fm = FileManager.default
        
        try! fm.createDirectory(atPath: documentsPath, withIntermediateDirectories:  true, attributes: nil)
        
        let imagePath = "/\(imageName)"
        
        fm.createFile(atPath: "\(documentsPath)\(imagePath)", contents: data, attributes: nil)
        
        return "\(documentsPath)\(imagePath)"
    }
    
    // MARK: 移除图片
    public static func wl_removeImageAtPath(imageName: String) {
        let documentsPath = (NSHomeDirectory() as NSString).appendingPathComponent("Documents")
        
        let fm = FileManager.default
        
        let filePath = "\(documentsPath)/\(imageName)"
        
        do {
            
            try fm.removeItem(atPath: filePath)
            
        } catch {
            
            printLog(message: error)
        }
    }
    
}

extension UIImage {
    
    // MARK: 二分法 压缩图片
    public static func compressImage(_ image: UIImage ,maxLength: NSInteger) -> Data {
        
        var compression: CGFloat = 1
        
        var data = image.jpegData(compressionQuality: compression)!
        
        if data.count < maxLength { return data}
        
        var max: CGFloat = 1
        
        var min: CGFloat = 0
        
        for _ in 0..<6 {
            
            compression = (max + min) / 2
            
            data = image.jpegData(compressionQuality: compression)!
            
            if data.count < NSInteger(Double(maxLength) * 0.9) {
                
                min = compression
            } else if data.count > maxLength {
                
                max = compression
            } else {  break }
        }
        return data
    }
}


