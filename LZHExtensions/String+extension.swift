//
//  String+extension.swift
//  LZHExtensionsDemo
//
//  Created by lzh on 2021/4/15.
//

import Foundation
import UIKit
extension String {

    public func timeintervalToDate(interval:String,formart:String) -> String {
        let timeString = NSString(string: interval)
        let range = _NSRange(location: 0, length: 10)
        let suString = timeString.substring(with: range)
        let formatter = DateFormatter()
        formatter.dateFormat = formart
        let date = NSDate(timeIntervalSince1970: Double(suString)!)
        return self.compareDate(oldDate: date)
    }



    fileprivate func compareDate(oldDate:NSDate) -> String{
        //8小时时差
        let now = NSDate()
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT(for: now as Date)
        let localeDate = now.addingTimeInterval(Double(interval))
        let today = localeDate

        let newDate = oldDate.addingTimeInterval(Double(interval))

        let secondsPerDay:TimeInterval = 24 * 60 * 60
        let yesterday = today.addingTimeInterval(-secondsPerDay)
        let tomorrowday = today.addingTimeInterval(secondsPerDay)

        let beforeOfYesterday = yesterday.addingTimeInterval(-secondsPerDay)
        let dateString = NSString(string: newDate.description).substring(to: 10)
        let todayString = NSString(string: today.description).substring(to: 10)
        let tomorrowString = NSString(string: tomorrowday.description).substring(to: 10)
        let yesterdayString = NSString(string: yesterday.description).substring(to: 10)
        let beforeOfYesterdayString = NSString(string: beforeOfYesterday.description).substring(to: 10);
        let toYears = NSString(string: today.description).substring(to: 4)
        let dateYears = NSString(string: newDate.description).substring(to: 4)
        let timeH = NSString(string: newDate.description).substring(with: _NSRange(location: 11, length: 5))
        let timeG = NSString(string: newDate.description).substring(with: _NSRange(location: 5, length: 11))
        if toYears == dateYears {
            if dateString == todayString {
                return "今天 \(timeH)"
            } else if dateString == yesterdayString {
                return "昨天 \(timeH)"
            } else if dateString == beforeOfYesterdayString {
                return "前天 \(timeH)"
            } else if dateString == tomorrowString {
                return "明天 \(timeH)"
            } else {
                //                    return timeG
                //先替换第一个 - 为月 后插入日
                return ((((timeG as NSString).replacingCharacters(in: _NSRange(location: 2, length: 1), with: "月")) as NSString).replacingCharacters(in: _NSRange(location: 5, length: 1), with: "日 "))
            }
        } else {
            //                return dateString
            let timeStr = NSString(string: newDate.description).substring(to: 16)


            return ((((((timeStr as NSString).replacingCharacters(in: _NSRange(location: 4, length: 1), with: "年")) as NSString).replacingCharacters(in: _NSRange(location: 7, length: 1), with: "月")) as NSString).replacingCharacters(in: _NSRange(location: 10, length: 1), with: "日 "))
        }
    }

    /// 获得字符串的尺寸
    public func needTextRect(font: UIFont) -> CGRect {
        return self.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    }
    /// 汉字转拼音
    public func transformToPinYin()->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "")
    }
    /// 判断是否包含表情及特殊符号
    public  var containsEmoji:Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x00A0...0x00AF,
                 0x2030...0x204F,
                 0x2120...0x213F,
                 0x2190...0x21AF,
                 0x2310...0x329F,
                 0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    /// 替换字符串
    public func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)

        let str = regex.stringByReplacingMatches(in: self, options: [],
                                                 range: NSMakeRange(0, self.count),
                                                 withTemplate: with)
        return str
    }

    /// 将原始的url编码为合法的url
    public  func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
                                                            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }

    /// 将编码后的url转换回原始的url
    public func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
