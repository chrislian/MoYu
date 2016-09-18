//
//  TaskModel.swift
//  MoYu
//
//  Created by Chris on 16/9/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TaskModel {
    
    var id = ""
    var ordernum = ""
    var name = ""
    var issuer = ""
    var commission = ""
    var createtime = ""
    var status = 0
    var content = ""
    var step = ""
    var complain = ""
    var type = ""
    var userid = ""
    var address = ""
    var sum = 0
    
    init(json:JSON?){
        
        guard let json = json else{ return }
        
        id = json["id"].stringValue
        ordernum = json["ordernum"].stringValue
        name = json["name"].stringValue
        issuer = json["issur"].stringValue
        commission = json["commission"].stringValue
        createtime = json["createtime"].stringValue
        status = json["status"].intValue
        content = json["content"].stringValue
        step = json["step"].stringValue
        complain = json["complain"].stringValue
        type = json["type"].stringValue
        userid = json["userid"].stringValue
        address = json["address"].stringValue
        sum = json["sum"].intValue
    }
    
    
}