//
//  AroundPeopleModel.swift
//  MoYu
//
//  Created by lxb on 2016/12/29.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AroundPeopleModel {
    var id = ""
    var sessionid = ""
    var phonenum = ""
    var device = ""
    var img = ""
    var nickname = ""
    var age = 0
    var sex = MoSex.none
    var level = ""
    var regtime = ""
    var balance:Double = 0
    var integral = ""
    var intension = ""
    var invite = ""
    var status = ""
    var logintime = ""
    var address = ""
    var school = ""
    var trade = ""
    var merchantca = ""
    var certification = false
    var invitationcode = ""
    var longitude:Double = 0
    var latitude:Double = 0
    var geohash = ""
    var autograph = ""
    var jingyan = ""
    var type = ""
    var label = ""
    var capacity1 = ""
    var distance:Double = 0
    
    var location:MoYuLocation {
        return MoYuLocation(latitude: self.latitude , longitude: self.longitude)
    }
    var avator:String {
        
        return mainUrl + img
    }

    
    init(json:JSON) {
        
        id = json["id"].stringValue
        sessionid = json["sessionid"].stringValue
        phonenum = json["phonenum"].stringValue
        device  = json["device"].stringValue
        img = json["img"].stringValue
        nickname = json["nickname"].stringValue
        age = json["age"].intValue
        sex = MoSex(json["sex"].intValue)
        level = json["level"].stringValue
        regtime = json["regtime"].stringValue
        balance = json["balance"].doubleValue
        integral = json["integral"].stringValue
        intension = json["intension"].stringValue
        invite = json["invite"].stringValue
        status = json["status"].stringValue
        logintime = json["logintime"].stringValue
        address = json["address"].stringValue
        school = json["school"].stringValue
        trade = json["trade"].stringValue
        merchantca = json["merchantca"].stringValue
        certification = json["certification"].boolValue
        invitationcode = json["invitationcode"].stringValue
        longitude = json["longitude"].doubleValue
        latitude = json["latitude"].doubleValue
        geohash = json["geohash"].stringValue
        autograph = json["autograph"].stringValue
        jingyan = json["jingyan"].stringValue
        type = json["type"].stringValue
        label = json["label"].stringValue
        capacity1 = json["capacity1"].stringValue
        distance = json["distance"].doubleValue
    }
}
