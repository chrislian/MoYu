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
    var city = ""
    var address = "软件园"
    var content = ""
    var sum = 0
    var type = 0
    var time = NSDate().mo_dateByAddingDays(-1)
    var sex = 0
    var profession = "不限"
    var education = "不限"
    var commission:Double = 0
    var workingtime:Double = 0
    var longitude:Double = 0
    var latitude:Double = 0
    
    func combination()->[String: AnyObject]{
        
        return ["name": name, "city": city, "commission": commission, "address": address,
                "content": content, "sum":sum, "type": type, "time": time.timeIntervalSince1970, "sex": sex, "profession": profession,
        "education": education, "workingtime": workingtime, "longitude": longitude, "latitude":latitude ]
        
    }
}

struct PostTaskModel {
    var name = ""
    var address = ""
    var commission = ""
    var content = ""
    var type = ""
    var step = ""
    
    func combination()->[String: AnyObject]{
        return ["name": name, "address": address, "commission": commission, "content": content, "type": type, "step": step]
    }
}
