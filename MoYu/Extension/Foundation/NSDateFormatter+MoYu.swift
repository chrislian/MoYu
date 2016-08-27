//
//  NSDateFormatter+MoYu.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

var gDateFormatter:NSDateFormatter? = nil
extension NSDate{
    
    class private func mo_dateFormatter()->NSDateFormatter{
        var dateFormater:NSDateFormatter
        if let tmp = gDateFormatter{
            return tmp
        }
        
        dateFormater = NSDateFormatter()
        gDateFormatter = dateFormater
        return dateFormater
    }
    
    class func mo_stringFromDate(date:NSDate) ->String{
        let dateFormatter = NSDate.mo_dateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(date)
    }
    
    class func mo_dateFromString(stringDate:String) -> NSDate?{
        let dateFormatter = NSDate.mo_dateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.dateFromString(stringDate)
    }
    
    class func mo_stringFromDatetime(date:NSDate) ->String{
        let dateFormatter = NSDate.mo_dateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.stringFromDate(date)
    }
    
    class func mo_stringFromDatetime2(date:NSDate) ->String{
        let dateFormatter = NSDate.mo_dateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.stringFromDate(date)
    }
    
    class func mo_datetimeFromString(stringDate:String) -> NSDate?{
        let dateFormatter = NSDate.mo_dateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.dateFromString(stringDate)
    }
}