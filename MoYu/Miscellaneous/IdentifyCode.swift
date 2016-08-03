//
//  IdentifyCode.swift
//  CLSwiftExtension
//
//  Created by Chris on 16/1/12.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

struct RegexHelper {
    let regex: NSRegularExpression?
    init?(_ pattern: String) {
        do{
            regex = try NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
        }catch{
            return nil
        }
    }
    
    func match(input: String) -> Bool {
        guard let res = regex?.matchesInString(input,options: [], range: NSMakeRange(0, input.characters.count)) else{
            return false
        }
        return res.count > 0
    }
}

class IdentifyCode: NSObject {
    
    /**
     正则表达式,判断邮箱格式
     
     - parameter address: 邮箱地址
     
     - returns: true or false
     */
    class func validateEmail(email address:String)->Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        guard let regex = RegexHelper(emailRegex) else{
            return false
        }
        return regex.match(address)
    }
    
    /**
     正则表达式 判断手机格式
     
     - parameter number: 手机号码
     
     - returns: ture or false
     */
    class func validatePhone(phone number:String)->Bool{
        let phoneRegex = "1[3|5|7|8|][0-9]{9}"
        guard let regex = RegexHelper(phoneRegex) else{
            print("init failed")
            return false
        }
        return regex.match(number)
    }
}
