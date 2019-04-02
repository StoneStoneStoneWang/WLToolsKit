//
//  WLDeviceInfo.swift
//  Point
//
//  Created by three stone 王 on 2019/1/23.
//  Copyright © 2019年 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony
import LocalAuthentication
import AdSupport
import SystemConfiguration
import SystemConfiguration.CaptiveNetwork

public let WL_SCREEN_NATIVE_WIDTH: CGFloat = UIScreen.main.nativeBounds.width

public let WL_SCREEN_NATIVE_HEIGHT: CGFloat = UIScreen.main.nativeBounds.height

public struct WLDeviceInfo {
    
    // MARK: screen size
    public static func wl_device_screenSize() -> String { return String(format: "%.0f*%.0f", WL_SCREEN_WIDTH,WL_SCREEN_HEIGHT) }
    // MARK: native size
    public static func wl_device_nativeSize() -> String { return String(format: "%.0f*%.0f", WL_SCREEN_NATIVE_WIDTH,WL_SCREEN_NATIVE_HEIGHT) }
    // MARK: 磁盘总大小
    public static func wl_device_TotalDiskSize() -> String { return "\(UIDevice.current.TotalDiskSize)" }
    // MARK: 磁盘可用大小
    public static func wl_device_AvailableDiskSize() -> String { return "\(UIDevice.current.TotalDiskSize)" }
    // MARK: 是否有sim卡
    public static func wl_device_hasSIM() -> Bool { return wl_device_hawl_sim_use }
    // MARK: 运营商: 0未知，1移动，2联通，3电信
    public static func wl_device_carrier_operator() -> String {
        
        let result = wl_device_carrier().map { $0.mobileNetworkCode }
        
        var oper: WLCarrierOperator = .UNKNOWN
        
        for item in result {
            
            if let item = item {
                
                oper = WLCarrierOperator(temp: item)
            }
        }
        
        return oper.rawValue
    }
    
    
    // MARK: 设备型号:iPhone 9,1
    public static func wl_device_deviceModel() -> String { return z_device_deviceModel() }
    // MARK: 电池状态 0:未知，1:未充电，2:正在充电,3:电池已充满
    public static func wl_device_batteryState() -> Int {
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        return UIDevice.current.batteryState.rawValue
    }
    // MARK: 0未知，1没有，2TouchID，3FaceID
    // TODO: .... 这个之后处理 可能用到指纹登录
    public static func wl_device_biometryType() -> Int {
        
        let c = LAContext()
        
        if c.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) { return 0 }
        
        if #available(iOS 11.0, *) { return c.biometryType.rawValue + 1 }
            
        else { return 0 }
    }
    // MARK: 代理检测
    public static func wl_device_hasProxy() -> Bool {
        
        guard let proxySettings = CFNetworkCopySystemProxySettings() else { return false }
        
        let proxies = CFNetworkCopyProxiesForURL(unsafeBitCast(URL(string: "https://www.baidu.com")!, to: CFURL.self), proxySettings.takeUnretainedValue())
        
        let settings = proxies.takeUnretainedValue()
        
        if let line = CFArrayGetValueAtIndex(settings, 0) {
            
            #if arch(i386) || arch(x86_64)
            
            #else
            
            let dict: [String: String] = Unmanaged<NSDictionary>.fromOpaque(line).takeUnretainedValue() as! [String : String]
            
            if let r = dict[kCFProxyTypeKey as String] {
                
                if r != "kCFProxyTypeNone" { return true }
            }
            
            #endif
        }
        
        return false
    }
    
    // MARK: vpn检测
    public static func wl_device_hasVPN() -> Bool {
        
        var result: Bool = false
        
        guard let proxySettings = CFNetworkCopySystemProxySettings() else { return false }
        
        let dict = Unmanaged<NSDictionary>.fromOpaque(proxySettings.toOpaque()).takeUnretainedValue()
        
        guard let SCOPED = dict["__SCOPED__"] else { return false }
        
        let keys = (SCOPED as! Dictionary<NSString,Any>).keys
        
        for key in keys {
            
            if key.range(of: "tap").location != NSNotFound || key.range(of: "tun").location != NSNotFound || key.range(of: "ipsec").location != NSNotFound || key.range(of: "ppp").location != NSNotFound {
                
                result = true
                
                break
            }
        }
        return result
    }
    
    // MARK: 设备版本号
    public static func wl_device_version() -> String {
        
        return UIDevice.current.systemVersion
    }
    // MARK: 剪切板
    public static func wl_device_pasteboard() -> String {
        
        guard let pb = UIPasteboard.general.string else { return "" }
        
        if pb.count > 200 { return String(pb[..<pb.index(pb.startIndex, offsetBy: 200)]) }
        
        return pb
    }
    // MARK: 剪切板
    public static func wl_device_pasteboard4len(_ len: Int) -> String {
        
        guard let pb = UIPasteboard.general.string else { return "" }
        
        let result = len <= 0 ? 200 : len >= 1000 ? 1000 : len
        
        if pb.count > result { return String(pb[..<pb.index(pb.startIndex, offsetBy: result)]) }
        
        return pb
    }
    // MARK: 开机时间:单位s
    public static func wl_device_systemUptime() -> String {
        
        return ProcessInfo.processInfo.systemUptime.format("0")
    }
    // MARK: wifi名
    public static func wl_device_ssid() -> String {
        
        guard let interfaces = CNCopySupportedInterfaces() else { return "" }
        
        let interfaceArr = CFBridgingRetain(interfaces) as! Array<String>
        
        guard interfaceArr.count > 0 else { return "-1" }
        
        guard let unsafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceArr[0] as CFString) else { return "" }
        
        let interfaceData = unsafeInterfaceData as! Dictionary<String, Any>
        
        guard let wifi = interfaceData["SSID"] else { return "-1" }
        
        return wifi as! String
    }
    public static func wl_device_bssid() -> String {
        
        guard let interfaces = CNCopySupportedInterfaces() else { return "" }
        
        let interfaceArr = CFBridgingRetain(interfaces) as! Array<String>
        
        guard interfaceArr.count > 0 else { return "-1" }
        
        guard let unsafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceArr[0] as CFString) else { return "" }
        
        let interfaceData = unsafeInterfaceData as! Dictionary<String, Any>
        
        guard let macIp = interfaceData["BSSID"] else { return "-1" }
        
        return macIp as! String
    }
    
    public static func wl_ip_Address() -> String {
        
        #if arch(i386) || arch(x86_64)
        
        return "0.0.0.0"
        #else
        
        var addresses = [String]()
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return addresses.first ?? "0.0.0.0"
        #endif
        
        
    }
}

extension WLDeviceInfo {
    
    public enum WLCarrierOperator: String {
        
        case LTE = "1"
        
        case WCDMA = "2"
        
        case CDMA = "3"
        
        case UNKNOWN = "0"
        
        init(temp: String) {
            switch temp {
            case "00","02","07": self = .LTE
                
            case "01","06","09": self = .WCDMA
                
            case "03","05","11": self = .CDMA
                
            default: self = .UNKNOWN
                
            }
        }
    }
    
}

private extension UIDevice{
    
    private func blankof<T>(type:T.Type) -> T {
        let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
        let val = ptr.pointee
        ptr.deinitialize(count: MemoryLayout<T>.size)
        return val
    }
    //MARK: 磁盘总大小
    var TotalDiskSize: Int64{
        var fs = blankof(type: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_blocks)
        }
        return -1
    }
    
    //MARK: 磁盘可用大小
    var AvailableDiskSize: Int64{
        var fs = blankof(type: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_bavail)
        }
        return -1
    }
}
// MARK: 含有两个sim卡
public let wl_device_sim_1: String = "0000000100000001"

public let wl_device_sim_2: String = "0000000100000001"

public var wl_device_hawl_sim_use: Bool {
    
    let result = wl_device_carrier().map { $0.mobileNetworkCode }.map { $0 != nil }
    
    var flag: Bool = false
    
    for item in result {
        
        if item { flag = true; continue }
    }
    
    return flag
}
private func wl_device_carrier() -> Array<CTCarrier> {
    
    let networkInfo = CTTelephonyNetworkInfo()
    
    if #available(iOS 12.0, *) {
        
        guard let carriers = networkInfo.serviceSubscriberCellularProviders else { return [] }
        
        return carriers.values.map({ $0 })
    } else {
        
        guard let carrier = networkInfo.subscriberCellularProvider else { return [] }
        
        return [carrier]
    }
}

public var wl_device_isSimulator: Bool {
    
    return !z_device_deviceModel().hasPrefix("iPhone") && !z_device_deviceModel().hasPrefix("iPad")
}

private func z_device_deviceModel() -> String {
    
    let name = UnsafeMutablePointer<utsname>.allocate(capacity: 1)
    uname(name)
    let machine = withUnsafePointer(to: &name.pointee.machine, { (ptr) -> String? in
        
        let int8Ptr = ptr.withMemoryRebound(to: Int8.self, capacity: 1, { return $0 })
        
        return String(cString : int8Ptr)
    })
    
    _ = withUnsafePointer(to: &name.pointee.nodename, { (ptr) -> String? in
        
        let int8Ptr = ptr.withMemoryRebound(to: Int8.self, capacity: 1, {
            
            return $0
        })
        return String(cString : int8Ptr)
    })
    name.deallocate()
    
    guard let deviceString = machine else {
        return ""
    }
    return deviceString
}

private extension CGFloat {
    
    func format(_ f: String) -> String {
        
        return String(format: "%.\(f)f", self)
    }
}
private extension Double {
    
    func format(_ f: String) -> String {
        
        return String(format: "%.\(f)lf", self)
    }
}
