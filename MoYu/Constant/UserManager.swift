//
//  UserManager.swift
//  MoYu
//
//  Created by Chris on 16/8/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON


struct UserNotification {
    
    static let updateUserInfo = "com.moyu.user.notification.update.user.info"
    
}

extension Realm{
    
    class func setDefaultRealm(phone num:String){
        
        var config = Realm.Configuration()
        // 使用默认的目录，但是使用用户名来替换默认的文件名
        config.fileURL = config.fileURL!.URLByDeletingLastPathComponent?.URLByAppendingPathComponent("\(num).realm")
        
        // 将这个配置应用到默认的 Realm 数据库当中
        Realm.Configuration.defaultConfiguration = config
    }
}


class UserManager {

    static let sharedInstance = UserManager()
    
    private(set) var user = UserInfo()
    
    private(set) var isLoginIn = false
    
    let realm = try! Realm()
    
    func update(user json:JSON, phone:String){
        
        Realm.setDefaultRealm(phone: phone)
        
        self.set(phone: phone)
        
        user = UserInfo(json: json)
        
        self.isLoginIn = true
        
        do{
            try realm.write({ 
                realm.add(user, update: true)
            })
        }catch let error{
            println("reaml add error: \(error)")
        }
    }
    
    
    func deleteUser(){
        
        self.isLoginIn = false
        
        self.set(phone: "")
        do{
            try realm.write({ 
                realm.delete(user)
            })
        }catch let error{
            println("realm delete user error: \(error)")
        }
    }
    
    func getUserBy(phone num:String)->Bool{
        
        guard let user = realm.objectForPrimaryKey(UserInfo.self, key: num) else{
            return false
        }
        self.user = user
        return true
    }
    
    func getPhoneNumber()->String?{
        
        guard let phone =  NSUserDefaults.standardUserDefaults().valueForKey("userPhoneNumber") as? String else{
            return nil
        }
        
        self.getUserBy(phone: phone)
        
        return phone
        
    }
    
    func set(phone number:String){
        NSUserDefaults.standardUserDefaults().setObject(number, forKey: "userPhoneNumber")
    }
}
