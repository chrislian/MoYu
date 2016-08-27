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
    var profession = "不限"
    var education = "不限"
    var workingtime:Double = 0
    var longitude:Double = 0
    var latitude:Double = 0
    
    func combination()->[String: AnyObject]{
        
        return ["name": name, "city": city, "commission": commission, "address": address,
                "content": content, "sum":sum, "type": type, "time": time, "sex": sex, "profession": profession,
        "education": education, "workingtime": workingtime, "longitude": longitude, "latitude":latitude ]
        
    }
    
    mutating func simulateData(){
        self.name = "年轻人的第一个兼职"
        self.city = "厦门"
        self.commission = "200"
        self.address = "小农村"
        self.content = "我也不知道为什么,就是突然想发一个兼职"
        self.sum = 99
        self.time = String( NSDate().timeIntervalSince1970 )
        self.sex = 1
        self.profession = "市场营销"
        self.workingtime = 0
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
