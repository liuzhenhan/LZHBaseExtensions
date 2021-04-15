//
//  Date+extension.swift
//  LZHExtensionsDemo
//
//  Created by QD202010282474A on 2021/4/15.
//

import Foundation


extension Date {

    /// 获取当前 秒级 时间戳 - 10位
    var getTimeStamp : Int {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }

    /// 获取当前 毫秒级 时间戳 - 13位
    var getMilliStamp : Int {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = Int(timeInterval) * 1000
        return millisecond
    }

    /// Date 格式化日期
    func dateToDateString(_ date:Date,DateFormat dateFormat:String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }

    /// 格式化日期转时间戳
    func dateStringToDateTimeStamp(_ dateString:String,DateFormat dateFormat:String = "yyyy-MM-dd HH:mm")-> Int {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        let date = dfmatter.date(from: dateString)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        return Int(dateStamp)

    }


}
