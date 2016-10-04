//
//  File.swift
//  MoYu
//
//  Created by Chris on 16/8/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

struct PostPartTimeJobModel {
    var name = ""
    var city = "厦门"
    var address = "软件园"
    var content = ""
    var sum = 0
    var type = 0
    var time = Date().mo_dateByAddingDays(-1)
    var sex = 0
    var profession = "不限"
    var education = "不限"
    var commission:Double = 0
    var workingtime:Double = 0
    var longitude:Double = 11.23123
    var latitude:Double = 123.2323
    
    func combination()->[String: AnyObject]{
        
        return ["name": name as AnyObject, "city": city as AnyObject, "commission": commission as AnyObject, "address": address as AnyObject,
                "content": content as AnyObject, "sum":sum as AnyObject, "type": type as AnyObject, "time": Date.mo_stringFromDatetime2(self.time) as AnyObject, "sex": sex as AnyObject, "profession": profession as AnyObject,
        "education": education as AnyObject, "workingtime": workingtime as AnyObject, "longitude": longitude as AnyObject, "latitude":latitude as AnyObject ]
        
    }
}

struct PostTaskModel {
    var name = ""
    var address = "www.usoft.com"
    var commission:Double = 0
    var content = ""
    var type = -1
    var step = ""
    var sum = 0
    var longitude:Double = 11.23123
    var latitude:Double = 123.2323
    
    func combination()->[String: AnyObject]{
        return ["name": name as AnyObject, "address": address as AnyObject, "commission": commission as AnyObject, "content": content as AnyObject, "type": type as AnyObject, "step": step as AnyObject, "sum": sum as AnyObject,"longitude": longitude as AnyObject, "latitude":latitude as AnyObject ]
    }
}
