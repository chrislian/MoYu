//
//  RouterType.swift
//  MoYu
//
//  Created by Chris on 16/8/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

protocol RouterType {
    
    func sessionID()->String
    
    func userID()->String
    
    func MOUID()->String
    
    func compose(parameters parameters: [String:AnyObject]?) -> [String: AnyObject]
    
    
    //required
    func parameters() -> [String:AnyObject]?
    //required
    func urlString()->String
}

extension RouterType {
    
    func sessionID()->String{
        
        return UserManager.sharedInstance.user.sessionid
    }
    
    func userID()->String{
        
        return UserManager.sharedInstance.user.id
    }
    
    func MOUID()->String{
        return MODevice.MOUID()!
    }
    
    func compose(parameters parameters: [String: AnyObject]? = nil) -> [String: AnyObject]{
        
        let base:[String:AnyObject] = ["userid": self.userID(), "sessionid": self.sessionID(), "device": self.MOUID()]
        
        guard let parameters = parameters else { return base }
        
        let array = base.map{ $0 } + parameters.map{ $0 }
        
        return array.reduce( [:], combine: {
            var tmp = $0
            tmp[$1.0] = $1.1
            return tmp
        })
    }
}

