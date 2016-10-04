//
//  MyGetParttimeJob.swift
//  MoYu
//
//  Created by Chris on 2016/10/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MyGetPartTimeJob {
    
    
    var address = ""
    var city = ""
    var commission:Double = 0
    var complain = 0
    var content = ""
    var createtime:Double = 0
    var education = ""
    var geohash = ""
    var id = ""
    var issuer = ""
    var latitude:Double = 0
    var longitude:Double = 0
    var name = ""
    var order:Double = 0
    var ordernum = ""
    var profession = ""
    var sex = 0
    var status = 0
    var sum:Double = 0
    var time = 0
    var type = 0
    var userid = ""
    var workingtime:Double = 0
    
    
    init(json:JSON?) {
        
        guard let json = json else{ return }
        
        address = json["address"].stringValue
        city = json["city"].stringValue
        commission = json["commission"].doubleValue
        complain = json["complain"].intValue
        content = json["content"].stringValue
        createtime = json["createtime"].doubleValue
        education = json["education"].stringValue
        geohash = json["geohash"].stringValue
        id = json["id"].stringValue
        issuer = json["issuer"].stringValue
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
        name = json["name"].stringValue
        order = json["order"].doubleValue
        ordernum = json["ordernum"].stringValue
        profession = json["profession"].stringValue
        sex = json["sex"].intValue
        status = json["status"].intValue
        sum = json["sum"].doubleValue
        time = json["time"].intValue
        type = json["type"].intValue
        userid = json["userid"].stringValue
        workingtime = json["workingtime"].doubleValue
    }
    
}
