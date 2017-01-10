//
//  AboutJobModel.swift
//  MoYu
//
//  Created by Chris on 16/8/12.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import SwiftyJSON


struct AboutJobSubItem {
    let nickname:String
    let replyname:String
    let id:String
    let comment:String
    let userid:String
    let replyid:String
    let create_date:Date
    let parentid:String
    
    init(json:JSON) {
        
        nickname = json["nickname"].stringValue
        replyname = json["replyname"].stringValue
        id = json["id"].stringValue
        comment = json["comment"].stringValue
        userid = json["userid"].stringValue
        replyid = json["replyid"].stringValue
        create_date = Date( timeIntervalSince1970: json["create_time"].doubleValue )
        parentid = json["parentid"].stringValue
    
    }
}

struct AboutJobItem{
    
    
    let photo:String
    let id: String
    let imgs: [String]
    let memo: String
    let nickname: String
    let status: Int
    let zan: String
    let userid: String
    let create_time:Date
    
    let replylists:[AboutJobSubItem]
    
    
    init(json:JSON){
        
        photo = json["photo"].stringValue
        id = json["id"].stringValue
        imgs = json["imgs"].arrayValue.map{ $0.stringValue }
        memo = json["memo"].stringValue
        nickname = json["nickname"].stringValue
        status = json["status"].intValue
        zan = json["zan"].stringValue
        userid = json["userid"].stringValue
        
        create_time = Date( timeIntervalSince1970: json["create_time"].doubleValue )
        
        replylists = json["replylists"].arrayValue.map( AboutJobSubItem.init )
    }
    
    var avator:String {
        
        return baseUrl + photo
    }
}


struct AboutJobModel {
    
    var items:[AboutJobItem] = []
    
    init(){
    
    }
    
    init(json:JSON?){
        
        guard let data = json else {
            return
        }
        
        items = data["reslists"].arrayValue.map( AboutJobItem.init )
    }
}
