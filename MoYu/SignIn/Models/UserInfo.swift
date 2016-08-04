//
//  UseInfo.swift
//  MoYu
//
//  Created by Chris on 16/8/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import RealmSwift
import Realm
import SwiftyJSON

class UserInfo: Object {
    
    dynamic var id = ""
    dynamic var sessionid = ""
    dynamic var phonenum = ""
    dynamic var device = ""
    dynamic var img = ""
    dynamic var nickname = ""
    dynamic var sex = 0
    dynamic var age = 0
    dynamic var level = 0
    dynamic var regtime = 0
    dynamic var balance = 0.0
    dynamic var intension = ""
    dynamic var invite = ""
    dynamic var status = 0
    dynamic var logintime = 0
    
    dynamic var address = ""
    dynamic var merchantca = ""
    dynamic var intergral = ""
    dynamic var trade = ""
    dynamic var longitude = ""
    dynamic var latitude = ""
    dynamic var invitationcode = ""
    dynamic var autograph = ""
    dynamic var geohash = ""

    init(json:JSON) {
        
        super.init()
        
        id             = json["id"].stringValue
        sessionid      = json["sessionid"].stringValue
        phonenum       = json["phonenum"].stringValue
        device         = json["device"].stringValue
        img            = json["img"].stringValue
        nickname       = json["nickname"].stringValue
        sex            = json["sex"].intValue
        age            = json["age"].intValue
        level          = json["level"].intValue
        regtime        = json["regtime"].intValue
        balance        = json["balance"].doubleValue
        intension      = json["intension"].stringValue
        invite         = json["invite"].stringValue
        status         = json["status"].intValue
        logintime      = json["logintime"].intValue
        address        = json["address"].stringValue
        merchantca     = json["merchantca"].stringValue
        intergral      = json["intergral"].stringValue
        trade          = json["trade"].stringValue
        longitude      = json["longitude"].stringValue
        latitude       = json["latitude"].stringValue
        invitationcode = json["invitationcode"].stringValue
        autograph      = json["autograph"].stringValue
        geohash        = json["geohash"].stringValue
        
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: AnyObject, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    
    override static func primaryKey() -> String? {
        return "phonenum"
    }
}
