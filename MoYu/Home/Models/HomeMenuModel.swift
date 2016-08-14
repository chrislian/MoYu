//
//  HomeMenuItemModel.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import SwiftyJSON

struct HomeMenuModel{
    
    let address:String
    let city:String
    let commission:String
    let complain:Int
    let content:String
    let createtime:NSDate
    let education:String
    let geohash:String
    let id:String
    let issuer:String
    let longitude:String
    let latitude:String
    let name:String
    let order:String
    let ordernum:String
    let profession:String
    let sex:Int
    let status:Int
    let sum:Int
    let time:NSDate
    let userid:String
    let workingtime:NSDate
    
    init(json:JSON){
        address = json["address"].stringValue
        city = json["city"].stringValue
        commission = json["commission"].stringValue
        complain = json["complain"].intValue
        content = json["content"].stringValue
        createtime = NSDate(timeIntervalSince1970: json["createtime"].doubleValue)
        education = json["education"].stringValue
        geohash = json["geohash"].stringValue
        id = json["id"].stringValue
        issuer = json["issuer"].stringValue
        longitude = json["longitude"].stringValue
        latitude = json["latitude"].stringValue
        name = json["name"].stringValue
        order = json["order"].stringValue
        ordernum = json["ordernum"].stringValue
        profession = json["profession"].stringValue
        sex = json["sex"].intValue
        status = json["status"].intValue
        sum = json["sum"].intValue
        time = NSDate.init(timeIntervalSince1970: json["time"].doubleValue)
        userid = json["userid"].stringValue
        workingtime = NSDate(timeIntervalSince1970: json["workingtime"].doubleValue)
    }
}