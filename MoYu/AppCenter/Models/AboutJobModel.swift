//
//  AboutJobModel.swift
//  MoYu
//
//  Created by Chris on 16/8/12.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AboutJobItem{
    
    let photo:String
    let id: String
    let imgs: [String]
    let memo: String
    let nickname: String
    let status: Int
    let zan: Bool
    let userid: String
    let create_time:NSDate
    
    init(json:JSON){
        
        photo = json["photo"].stringValue
        id = json["id"].stringValue
        imgs = json["imgs"].arrayValue.map{ $0.stringValue }
        memo = json["memo"].stringValue
        nickname = json["nickname"].stringValue
        status = json["status"].intValue
        zan = json["zan"].boolValue
        userid = json["userid"].stringValue
        
        create_time = NSDate( timeIntervalSince1970: json["create_time"].doubleValue )
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