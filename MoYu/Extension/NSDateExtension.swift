//
//  NSDateExtension.swift
//  meiqu
//
//  Created by shenfh on 16/1/27.
//  Copyright © 2016年 com.meiqu.com. All rights reserved.
//

import Foundation
extension NSDate {
    /**
     Returns the year component.
     */
    func mo_year () -> Int {
        return self.components().year
    }
    
    /**
     Returns the month component.
     */
    func mo_month() ->Int{
        return self.components().month
    }
    
    /**
     Returns the week of year component.
     */
    func mo_week () -> Int {
        return self.components().weekOfYear
    }
    
    /**
     Returns the day component.
     */
    func mo_day () -> Int {
        return self.components().day
    }
    
    /**
     Returns the hour component.
     */
    func mo_hour () -> Int {
        return self.components().hour
    }
    
    /**
     Returns the minute component.
     */
    func mo_minute () -> Int {
        return self.components().minute
    }
    
    /**
     Returns the seconds component.
     */
    func mo_seconds () -> Int {
        return self.components().second
    }
    
    
    /**
     Returns the weekday component.
     */
    func mo_weekday () -> Int {
        return self.components().weekday
    }
    
    /**
     Returns the nth days component. e.g. 2nd Tuesday of the month is 2.
     */
    func mo_nthWeekday () -> Int {
        return self.components().weekdayOrdinal
    }
    
    /**
     Returns the days of the month.
     */
    func mo_monthDays () -> Int {
        return NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self).length
    }
   
    /**
        Gets the number of seconds since a date.
     */
    func mo_secondsSinceDate(date: NSDate) -> Int{
        return Int(self.timeIntervalSinceDate(date))
    }
    
    /**
     Gets the number of minutes since a date.
     */
    func mo_minutesSinceDate(date: NSDate) -> Int{
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.minuteInSeconds())
    }
    
    /**
     Gets the number of hours since a date.
     */
    func mo_hoursSinceDate(date: NSDate) -> Int{
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.hourInSeconds())
    }
    
    /**
     Gets the number of days since a date.
     */
    func mo_daysSinceDate(date: NSDate) -> Int{
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.dayInSeconds())
    }
    
    // MARK:Create New Date
    
    
    /**
    Creates a new date by adding second.
    */
    func mo_dateByAddingSeconds(seconds: Int) -> NSDate{
        let dateComp    = NSDateComponents()
        dateComp.second = seconds
        return self.mo_dateByAddingComponents(dateComp)
    }
    
    /**
     Creates a new date by adding hours.
     */
    func mo_dateByAddingMinutes(minutes: Int) -> NSDate{
        let dateComp    = NSDateComponents()
        dateComp.minute = minutes
        return self.mo_dateByAddingComponents(dateComp)
    }
    
    /**
     Creates a new date by adding hours.
     */
    func mo_dateByAddingHours(hours: Int) -> NSDate{
        let dateComp = NSDateComponents()
        dateComp.hour = hours
        return self.mo_dateByAddingComponents(dateComp)
    }
    
    /**
        Creates a new date by adding days.
    */
    func mo_dateByAddingDays(days: Int) -> NSDate{
        let dateComp = NSDateComponents()
        dateComp.day = days
        return self.mo_dateByAddingComponents(dateComp)
    }
    
    /**
        Creates a new date by adding months.
     */
    func mo_dateByAddingMonths(months:Int)->NSDate{
        let dateComp   = NSDateComponents()
        dateComp.month = months
        return self.mo_dateByAddingComponents(dateComp)
    }
    
    /**
       Creates a new date by adding years.
     */
    func mo_dateByAddingYears(years:Int)->NSDate{
        let dateComp  = NSDateComponents()
        dateComp.year = years
        return self.mo_dateByAddingComponents(dateComp)
    }
    
    func mo_dateByAddingComponents(component:NSDateComponents)->NSDate{
        return NSCalendar.currentCalendar().dateByAddingComponents(component, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    
    //MARK: Date Check
    
    /**
        Returns ture if date is same with current date
    */
    func mo_isSameDate(date:NSDate)->Bool{
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: date)
        return ((comp1.year == comp2.year) && (comp1.month == comp2.month) && (comp1.day == comp2.day))
    }
    
    /**
     Returns ture if date is today
     */
    func mo_isToday()->Bool{
        return mo_isSameDate(NSDate())
    }
    
    /**
     Returns true if date is tomorrow.
     */
    func mo_isTomorrow() -> Bool {
        return self.mo_isSameDate(NSDate().mo_dateByAddingDays(1))
    }
    
    /**
     Returns true if date is yesterday.
     */
    func mo_isYesterday() -> Bool{
        return self.mo_isSameDate(NSDate().mo_dateByAddingDays(-1))
    }
    
    func mo_isAfterDay() ->Bool{
        return self.mo_secondsSinceDate(NSDate())>0
    }
    
    // MARK: ISO Date Formate
    public class func mo_ISOStringFromDate(date: NSDate) -> String {
        
        let dateFormatter        = NSDateFormatter()
        dateFormatter.locale     = NSLocale.currentLocale()
        dateFormatter.timeZone   = NSTimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.stringFromDate(date).stringByAppendingString("Z")
    }
    
    public class func mo_dateFromISOString(string: String) -> NSDate? {
        let dateFormatter        = NSDateFormatter()
        dateFormatter.locale     = NSLocale.currentLocale()
        dateFormatter.timeZone   = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.dateFromString(string)
    }
    
    //MARK: pravate func
    private class func minuteInSeconds() -> Double { return 60 }
    private class func hourInSeconds() -> Double { return 3600 }
    private class func dayInSeconds() -> Double { return 86400 }
    private class func weekInSeconds() -> Double { return 604800 }
    private class func yearInSeconds() -> Double { return 31556926 }
   
    private class func componentFlags() -> NSCalendarUnit {
        return [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Weekday, NSCalendarUnit.WeekdayOrdinal, NSCalendarUnit.WeekOfYear]
    }
    
    private class func components(fromDate fromDate: NSDate) -> NSDateComponents! {
        return NSCalendar.currentCalendar().components(NSDate.componentFlags(), fromDate: fromDate)
    }
    private func components() -> NSDateComponents  {
        return NSDate.components(fromDate: self)!
    }
}
public enum MODateFormateType{
    case Default
    case Detail
}
extension NSDate{
    
    /**
     获取当天0时0分0秒的时间 
     */
    public func fistTime() ->NSDate {
        let comps = self.components()
        return dateFromYear(comps.year, month: comps.month, day: comps.day, hour: 0, minute: 0, second: 0)
    }
    public func firstTimeInterval()-> NSTimeInterval {
        return self.fistTime().timeIntervalSince1970
    }
    public func dateFromYear(year:Int,month:Int,day:Int,hour:Int,minute:Int,second:Int) ->NSDate{
       let comps = self.components()
        comps.year   = Int(year)
        comps.month  = Int(month)
        comps.day    = Int(day)
        comps.hour   = Int(hour)
        comps.minute = Int(minute)
        comps.second = Int(second)
        return NSCalendar.currentCalendar().dateFromComponents(comps)!
    }


    
    // MARK: Date to String
    
    public func mo_ToString(type:MODateFormateType = .Default) ->String{
        switch type{
        case .Default:
            return self.mo_toMainViewString()
        case .Detail:
            return self.mo_toDetailViewString()
        }
    }
    
    private func mo_toMainViewString()->String{
        let timeInterval = NSDate().timeIntervalSinceDate(self)<0 ? 0 : NSDate().timeIntervalSinceDate(self)
        if (timeInterval >= 0 && timeInterval < NSDate.minuteInSeconds()){
            return "刚刚"
        } else if (timeInterval >= NSDate.minuteInSeconds() && timeInterval < 60*NSDate.minuteInSeconds()) {
            return "\(Int(timeInterval/NSDate.minuteInSeconds()))分钟前"
        } else if( timeInterval < NSDate.dayInSeconds() ){
            return "\(Int(timeInterval/NSDate.hourInSeconds()))小时前"
        } else if ( timeInterval >= NSDate.dayInSeconds() && timeInterval < 2*NSDate.dayInSeconds()){
            return "昨天"
        } else if (timeInterval >= 2*NSDate.dayInSeconds() && timeInterval < 3*NSDate.dayInSeconds() ){
            return "前天"
        }
        return "\(self.mo_month())月\(self.mo_day())日";
    }
    private func mo_toDetailViewString()->String{
        let timeInterval = NSDate().timeIntervalSinceDate(self)<0 ? 0 : NSDate().timeIntervalSinceDate(self)
       
        if (timeInterval >= 0 && timeInterval < NSDate.minuteInSeconds()){
            return "刚刚"
        } else if (timeInterval >= NSDate.minuteInSeconds() && timeInterval < 60*NSDate.minuteInSeconds()) {
            return "\(Int(timeInterval/NSDate.minuteInSeconds()))分钟前"
        } else if( timeInterval < NSDate.dayInSeconds() ){
            return "\(Int(timeInterval/NSDate.hourInSeconds()))小时前"
        } else if ( timeInterval >= NSDate.dayInSeconds() && timeInterval < 2*NSDate.dayInSeconds()){
            return String(format:"昨天 %02d:%02d", arguments:[self.mo_hour(),self.mo_minute()])
        } else if (timeInterval >= 2*NSDate.dayInSeconds() && timeInterval < 3*NSDate.dayInSeconds() ){
            return String(format:"前天 %02d:%02d", arguments:[self.mo_hour(),self.mo_minute()])
        } else if (timeInterval < NSDate.yearInSeconds()){
            
            let date = NSDate()
            let calendar:NSCalendar = NSCalendar.currentCalendar()
            let  dateComponent = calendar.component(NSCalendarUnit.Year, fromDate: date)
            if(self.mo_year() <  dateComponent){
                return String(format: "%d年%d月%d日 %02d:%02d", arguments: [self.mo_year(),self.mo_month(),self.mo_day(),self.mo_hour(),self.mo_minute()]);
            }
            return String(format: "%d月%d日 %02d:%02d", arguments: [self.mo_month(),self.mo_day(),self.mo_hour(),self.mo_minute()])
        }
        return String(format: "%d年%d月%d日 %02d:%02d", arguments: [self.mo_year(),self.mo_month(),self.mo_day(),self.mo_hour(),self.mo_minute()]);
    }

}