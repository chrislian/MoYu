//
//  MODevice.swift
//  MoYu
//
//  Created by Chris on 16/7/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

struct MODevice {
    
    fileprivate static let serviceName = "com.chris.moyu"
    fileprivate static let userName = "MoYu"
    
    static func MOUID()->String?{
        
        
        //有问题
        
//        if let mouid = try? SFHFKeychainUtils.getPasswordForUsername(userName, andServiceName: serviceName) , !mouid.isEmpty{
//            return mouid
//        }
//        
//        if let uuid = UIDevice.current.identifierForVendor?.uuidString,
//            let _ = try? SFHFKeychainUtils.storeUsername(userName, andPassword: uuid, forServiceName: serviceName, updateExisting: true){
//            return uuid
//        }
//        println("get MOUID failed")
        return UIDevice.current.identifierForVendor?.uuidString
    }
}
