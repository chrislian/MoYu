//
//  MoNotification.swift
//  MoYu
//
//  Created by lxb on 2016/12/29.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import Async


struct MoNotification {
    
    static let updateUserInfo = NSNotification.Name(rawValue: "com.moyu.user.notification.update.user.info")
    static let updateAboutJob = NSNotification.Name(rawValue: "com.moyu.user.notification.update.aboutJob")
    
}

extension NotificationCenter{
    
    class func post(name:NSNotification.Name, object:AnyObject? = nil, userInfo:[AnyHashable : Any]? = nil){
        Async.main {
            NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
            
        }
    }
    
    class func add(observer: AnyObject, selector: Selector, name:NSNotification.Name? = nil, object:AnyObject? = nil){
        Async.main{
            NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
        }
    }
}
