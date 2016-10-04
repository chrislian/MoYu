//
//  MyTaskJob.swift
//  MoYu
//
//  Created by Chris on 2016/10/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MyPostTaskJob {
    
    var address = ""
    var commission:Double = 0
    var complain = 0
    var content = ""
    var createtime:Double = 0
    var id = ""
    var issuer = ""
    var name = ""
    var order:Double = 0
    var ordernum = ""
    var status = 0
    var step = ""
    var sum:Double = 0
    var type = 0
    var userid = ""
    
    init(json:JSON?) {
        
        guard let json = json else{ return }
        
        address = json["address"].stringValue
        commission = json["commission"].doubleValue
        complain = json["complain"].intValue
        content = json["content"].stringValue
        createtime = json["createtime"].doubleValue
        id = json["id"].stringValue
        issuer = json["issuer"].stringValue
        name = json["name"].stringValue
        order = json["order"].doubleValue
        ordernum = json["ordernum"].stringValue
        status = json["status"].intValue
        step = json["step"].stringValue
        sum = json["sum"].doubleValue
        type = json["type"].intValue
        userid = json["userid"].stringValue
    }
}
