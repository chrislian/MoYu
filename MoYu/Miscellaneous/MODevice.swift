//
//  MODevice.swift
//  MoYu
//
//  Created by Chris on 16/7/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

struct MODevice {
    
    private static let serviceName = "com.chris.moyu"
    private static let userName = "MoYu"
    
    static func MOUID()->String?{
        
        if let mouid = try? SFHFKeychainUtils.getPasswordForUsername(userName, andServiceName: serviceName) where !mouid.isEmpty{
            return mouid
        }
        
        if let uuid = UIDevice.currentDevice().identifierForVendor?.UUIDString,
            let _ = try? SFHFKeychainUtils.storeUsername(userName, andPassword: uuid, forServiceName: serviceName, updateExisting: true){
            return uuid
        }
        println("get MOUID failed")
        return nil
    }
}
