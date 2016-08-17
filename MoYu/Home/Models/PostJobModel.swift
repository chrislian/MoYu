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
    var commission = ""
    var address = ""
    var content = ""
    var sum = 0
    var type = 0
    var time = ""
    var sex = 0
    var profession = ""
    var education = ""
    var workingtime = ""
    var longitude:Double = 0
    var latitude:Double = 0
    
    func combination()->[String: AnyObject]{
        
        return ["name": name, "city": city, "commission": commission, "address": address,
                "content": content, "sum":sum, "type": type, "time": time, "sex": sex, "profession": profession,
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
