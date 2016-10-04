//
//  NSDateExtension.swift
//  meiqu
//
//  Created by shenfh on 16/1/27.
//  Copyright © 2016年 com.meiqu.com. All rights reserved.
//

import Foundation
extension Date {
    /**
     Returns the year component.
     */
    func mo_year () -> Int {
        return self.components().year!
    }
    
    /**
     Returns the month component.
     */
    func mo_month() ->Int{
        return self.components().month!
    }
    
    /**
     Returns the week of year component.
     */
    func mo_week () -> Int {
        return self.components().weekOfYear!
    }
    
    /**
     Returns the day component.
     */
    func mo_day () -> Int {
        return self.components().day!
    }
    
    /**
     Returns the hour component.
     */
    func mo_hour () -> Int {
        return self.components().hour!
    }
    
    /**
     Returns the minute component.
     */
    func mo_minute () -> Int {
        return self.components().minute!
    }
    
    /**
     Returns the seconds component.
     */
    func mo_seconds () -> Int {
        return self.components().second!
    }
    
    
    /**
     Returns the weekday component.
     */
    func mo_weekday () -> Int {
        return self.components().weekday!
    }
    
    /**
     Returns the nth days component. e.g. 2nd Tuesday of the month is 2.
     */
    func mo_nthWeekday () -> Int {
        return self.components().weekdayOrdinal!
    }
    
    /**
     Returns the days of the month.
     */
    func mo_monthDays () -> Int {
        return (Calendar.current as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self).length
    }
   
    /**
        Gets the number of seconds since a date.
     */
    func mo_secondsSinceDate(_ date: Date) -> Int{
        return Int(self.timeIntervalSince(date))
    }
    
    /**
     Gets the number of minutes since a date.
     */
    func mo_minutesSinceDate(_ date: Date) -> Int{
        let interval = self.timeIntervalSince(date)
        return Int(interval / Date.minuteInSeconds())
    }
    
    /**
     Gets the number of hours since a date.
     */
    func mo_hoursSinceDate(_ date: Date) -> Int{
        let interval = self.timeIntervalSince(date)
        return Int(interval / Date.hourInSeconds())
    }
    
    /**
     Gets the number of days since a date.
     */
    func mo_daysSinceDate(_ date: Date) -> Int{
        let interval = self.timeIntervalSince(date)
        return Int(interval / Date.dayInSeconds())
    }
    
    // MARK:Create New Date
    
    
    /**
    Creates a new date by adding second.
    */
    func mo_dateByAddingSeconds(_ seconds: Int) -> Date{
        var dateComp    = DateComponents()
        dateComp.second = seconds
        return self.mo_dateByAddingComponents(dateComp)
    }
    
    /**
     Creates a new date by adding hours.
     */
    func mo_dateByAddingMinutes(_ minutes: Int) -> Date{
        var dateComp    = DateComponents()
        dateComp.minute = minutes
        return self.mo_dateByAddingComponents(dateComp)
    }
    
    /**
     Creates a new date by adding hours.
     */
    func mo_dateByAddingHours(_ hours: Int) -> Date{
        var dateComp = DateComponents()
        dateComp.hour = hours
        return self.mo_dateByAddingComponents(dateComp)
    }
    
    /**
        Creates a new date by adding days.
    */
    func mo_dateByAddingDays(_ days: Int) -> Date{
        var dateComp = DateComponents()
        dateComp.day = days
        return self.mo_dateByAddingComponents(dateComp)
    }
    
    /**
        Creates a new date by adding months.
     */
    func mo_dateByAddingMonths(_ months:Int)->Date{
        var dateComp   = DateComponents()
        dateComp.month = months
        return self.mo_dateByAddingComponents(dateComp)
    }
    
    /**
       Creates a new date by adding years.
     */
    func mo_dateByAddingYears(_ years:Int)->Date{
        var dateComp  = DateComponents()
        dateComp.year = years
        return self.mo_dateByAddingComponents(dateComp)
    }
    
    func mo_dateByAddingComponents(_ component:DateComponents)->Date{
        return (Calendar.current as NSCalendar).date(byAdding: component, to: self, options: NSCalendar.Options(rawValue: 0))!
    }
    
    
    //MARK: Date Check
    
    /**
        Returns ture if date is same with current date
    */
    func mo_isSameDate(_ date:Date)->Bool{
        let comp1 = Date.components(fromDate: self)
        let comp2 = Date.components(fromDate: date)
        return ((comp1!.year == comp2!.year) && (comp1!.month == comp2!.month) && (comp1!.day == comp2!.day))
    }
    
    /**
     Returns ture if date is today
     */
    func mo_isToday()->Bool{
        return mo_isSameDate(Date())
    }
    
    /**
     Returns true if date is tomorrow.
     */
    func mo_isTomorrow() -> Bool {
        return self.mo_isSameDate(Date().mo_dateByAddingDays(1))
    }
    
    /**
     Returns true if date is yesterday.
     */
    func mo_isYesterday() -> Bool{
        return self.mo_isSameDate(Date().mo_dateByAddingDays(-1))
    }
    
    func mo_isAfterDay() ->Bool{
        return self.mo_secondsSinceDate(Date())>0
    }
    
    // MARK: ISO Date Formate
    public static func mo_ISOStringFromDate(_ date: Date) -> String {
        
        let dateFormatter        = DateFormatter()
        dateFormatter.locale     = Locale.current
        dateFormatter.timeZone   = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.string(from: date) + "Z"
    }
    
    public static func mo_dateFromISOString(_ string: String) -> Date? {
        let dateFormatter        = DateFormatter()
        dateFormatter.locale     = Locale.current
        dateFormatter.timeZone   = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: string)
    }
    
    //MARK: pravate func
    fileprivate static func minuteInSeconds() -> Double { return 60 }
    fileprivate static func hourInSeconds() -> Double { return 3600 }
    fileprivate static func dayInSeconds() -> Double { return 86400 }
    fileprivate static func weekInSeconds() -> Double { return 604800 }
    fileprivate static func yearInSeconds() -> Double { return 31556926 }
   
    fileprivate static func componentFlags() -> NSCalendar.Unit {
        return [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.weekOfYear, NSCalendar.Unit.hour, NSCalendar.Unit.minute, NSCalendar.Unit.second, NSCalendar.Unit.weekday, NSCalendar.Unit.weekdayOrdinal, NSCalendar.Unit.weekOfYear]
    }
    
    fileprivate static func components(fromDate: Date) -> DateComponents! {
        return (Calendar.current as NSCalendar).components(Date.componentFlags(), from: fromDate)
    }
    fileprivate func components() -> DateComponents  {
        return Date.components(fromDate: self)!
    }
}
public enum MODateFormateType{
    case `default`
    case detail
}
extension Date{
    
    /**
     获取当天0时0分0秒的时间 
     */
    public func fistTime() ->Date {
        let comps = self.components()
        return dateFromYear(comps.year!, month: comps.month!, day: comps.day!, hour: 0, minute: 0, second: 0)
    }
    public func firstTimeInterval()-> TimeInterval {
        return self.fistTime().timeIntervalSince1970
    }
    public func dateFromYear(_ year:Int,month:Int,day:Int,hour:Int,minute:Int,second:Int) ->Date{
       var comps = self.components()
        comps.year   = Int(year)
        comps.month  = Int(month)
        comps.day    = Int(day)
        comps.hour   = Int(hour)
        comps.minute = Int(minute)
        comps.second = Int(second)
        return Calendar.current.date(from: comps)!
    }


    
    // MARK: Date to String
    
    public func mo_ToString(_ type:MODateFormateType = .default) ->String{
        switch type{
        case .default:
            return self.mo_toMainViewString()
        case .detail:
            return self.mo_toDetailViewString()
        }
    }
    
    fileprivate func mo_toMainViewString()->String{
        let timeInterval = Date().timeIntervalSince(self)<0 ? 0 : Date().timeIntervalSince(self)
        if (timeInterval >= 0 && timeInterval < Date.minuteInSeconds()){
            return "刚刚"
        } else if (timeInterval >= Date.minuteInSeconds() && timeInterval < 60*Date.minuteInSeconds()) {
            return "\(Int(timeInterval/Date.minuteInSeconds()))分钟前"
        } else if( timeInterval < Date.dayInSeconds() ){
            return "\(Int(timeInterval/Date.hourInSeconds()))小时前"
        } else if ( timeInterval >= Date.dayInSeconds() && timeInterval < 2*Date.dayInSeconds()){
            return "昨天"
        } else if (timeInterval >= 2*Date.dayInSeconds() && timeInterval < 3*Date.dayInSeconds() ){
            return "前天"
        }
        return "\(self.mo_month())月\(self.mo_day())日";
    }
    fileprivate func mo_toDetailViewString()->String{
        let timeInterval = Date().timeIntervalSince(self)<0 ? 0 : Date().timeIntervalSince(self)
       
        if (timeInterval >= 0 && timeInterval < Date.minuteInSeconds()){
            return "刚刚"
        } else if (timeInterval >= Date.minuteInSeconds() && timeInterval < 60*Date.minuteInSeconds()) {
            return "\(Int(timeInterval/Date.minuteInSeconds()))分钟前"
        } else if( timeInterval < Date.dayInSeconds() ){
            return "\(Int(timeInterval/Date.hourInSeconds()))小时前"
        } else if ( timeInterval >= Date.dayInSeconds() && timeInterval < 2*Date.dayInSeconds()){
            return String(format:"昨天 %02d:%02d", arguments:[self.mo_hour(),self.mo_minute()])
        } else if (timeInterval >= 2*Date.dayInSeconds() && timeInterval < 3*Date.dayInSeconds() ){
            return String(format:"前天 %02d:%02d", arguments:[self.mo_hour(),self.mo_minute()])
        } else if (timeInterval < Date.yearInSeconds()){
            
            let date = Date()
            let calendar:Calendar = Calendar.current
            let  dateComponent = (calendar as NSCalendar).component(NSCalendar.Unit.year, from: date)
            if(self.mo_year() <  dateComponent){
                return String(format: "%d年%d月%d日 %02d:%02d", arguments: [self.mo_year(),self.mo_month(),self.mo_day(),self.mo_hour(),self.mo_minute()]);
            }
            return String(format: "%d月%d日 %02d:%02d", arguments: [self.mo_month(),self.mo_day(),self.mo_hour(),self.mo_minute()])
        }
        return String(format: "%d年%d月%d日 %02d:%02d", arguments: [self.mo_year(),self.mo_month(),self.mo_day(),self.mo_hour(),self.mo_minute()]);
    }

}
