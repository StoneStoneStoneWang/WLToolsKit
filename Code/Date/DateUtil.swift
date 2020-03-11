//
//  DateUtil.swift
//  TSToolKit_Swift
//
//  Created by three stone 王 on 2018/11/14.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import Foundation

extension Date {
    
    public static func getTimeStamp_S() -> String { return "\(Int8(Date().timeIntervalSince1970))" }
    
    public static func getTimeStamp_MS() -> String { return "\(UInt64(Date().timeIntervalSince1970 * 1000))" }
}
extension NSDate {
    
    @objc (getTimeStamp_S)
    public static func getTimeStamp_S() -> String {  return Date.getTimeStamp_S() }
    
    @objc (getTimeStamp_MS)
    public static func getTimeStamp_MS() -> String { return Date.getTimeStamp_MS() }
}


private let iso8601 = Calendar(identifier: Calendar.Identifier.iso8601)

extension Date {
    
    public var currentMonth: String {
        
        guard let month = iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self).month else {
            return ""
        }
        
        return "\(month)"
    }
    public var currentWeek: String {
        
        guard let week = iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self).weekOfYear else {
            return ""
        }
        
        return "\(week)"
    }
    
    //    var cureentWeekMonday: Date {
    //
    //        let iso8601 = Calendar(identifier: Calendar.Identifier.iso8601)
    //
    //        printLog(message: iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    //
    //        return iso8601.date(from: iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    //    }
    //
    //    var cureentWeekTuesday: Date {
    //
    //        let iso8601 = Calendar(identifier: Calendar.Identifier.iso8601)
    //
    //        return iso8601.date(from: iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    //    }
    //
    //    var cureentWeekWed: Date {
    //
    //        let iso8601 = Calendar(identifier: Calendar.Identifier.iso8601)
    //
    //        return iso8601.date(from: iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    //    }
    //
    //    public static func fetchCurrentMonth() -> String {
    //
    //        let calendar = Calendar.current
    //
    //        let currentDate = calendar.startOfDay(for: Date())
    //
    //        let nextWeek：Date = calendar.date（byAdding：.weekOfMonth，value：1，to：currentDate）！ as date
    //    }
    //
    //    public static func fetchCurrentWeek() -> String {
    //
    //        let date = Date()
    //
    //        let df = DateFormatter()
    //
    //        df.dateFormat = "YYYY年MM月"
    //
    //        let dateString = df.string(from: date)
    //
    //        let calendar = Calendar.current
    //
    //        let comps = calendar.component(Calendar.Component.weekday, from: date)
    //
    //        return
    //    }
    //
    //    public static func fetchNextWeek() -> String {
    //
    //
    //    }
}
extension NSDate {
    
    @objc public var currentMonth: String {
        
        guard let month = iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self as Date).month else {
            return ""
        }
        
        return "\(month)"
    }
    @objc public var currentWeek: String {
        
        guard let week = iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self as Date).weekOfYear else {
            return ""
        }
        
        return "\(week)"
    }
}
