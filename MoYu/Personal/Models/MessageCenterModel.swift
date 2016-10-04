//
//  MessageCenterModel.swift
//  MoYu
//
//  Created by Chris on 16/8/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MessageCenterItem {

    var createTime:Date?
    let description:String
    let title:String
    
    init(json:JSON){
        
        description = json["description"].stringValue
        
        title = json["title"].stringValue
        
        if let value = json["create_time"].int{
            createTime = Date(timeIntervalSince1970: TimeInterval(value) )
        }
    }
}

struct MessageCenterModel {
    
    var items:[MessageCenterItem] = []
    
    mutating func prase(response json:JSON){
        
        guard let array = json["reslist"].array else{ return }
        
        items = array.map( MessageCenterItem.init )
    }
}
