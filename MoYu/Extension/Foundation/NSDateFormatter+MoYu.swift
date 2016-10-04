//
//  NSDateFormatter+MoYu.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

var gDateFormatter:DateFormatter? = nil
extension Date{
    
    static fileprivate func mo_dateFormatter()->DateFormatter{
        var dateFormater:DateFormatter
        if let tmp = gDateFormatter{
            return tmp
        }
        
        dateFormater = DateFormatter()
        gDateFormatter = dateFormater
        return dateFormater
    }
    
    static func mo_stringFromDate(_ date:Date) ->String{
        let dateFormatter = Date.mo_dateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    static func mo_dateFromString(_ stringDate:String) -> Date?{
        let dateFormatter = Date.mo_dateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: stringDate)
    }
    
    static func mo_stringFromDatetime(_ date:Date) ->String{
        let dateFormatter = Date.mo_dateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    static func mo_stringFromDatetime2(_ date:Date) ->String{
        let dateFormatter = Date.mo_dateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func mo_datetimeFromString(_ stringDate:String) -> Date?{
        let dateFormatter = Date.mo_dateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: stringDate)
    }
}
