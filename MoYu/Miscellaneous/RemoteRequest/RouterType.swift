//
//  RouterType.swift
//  MoYu
//
//  Created by Chris on 16/8/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String:Any]

protocol RouterType {
    
    func sessionID()->String
    
    func userID()->String
    
    func MOUID()->String
    
    func compose(parameters: JSONDictionary?) -> JSONDictionary
    
    func request(remote clourse: @escaping RemoteClourse)
    
    //required
    func parameters() -> JSONDictionary?
    //required
    func urlString()->String
}

extension RouterType {
    
    func request(remote clourse: @escaping RemoteClourse){
        
//        println("urlString:\(self.urlString())")
//        println("parameters:\(self.parameters())")
        
        Remote.post(url: self.urlString(), parameters: self.parameters(),callback: clourse)
    }
    
    
    func sessionID()->String{
        
        return UserManager.sharedInstance.user.sessionid
    }
    
    func userID()->String{
        
        return UserManager.sharedInstance.user.id
    }
    
    func MOUID()->String{
        return MODevice.MOUID() ?? ""
    }
    
    func compose(parameters: JSONDictionary? = nil) -> JSONDictionary{
        
        var base:JSONDictionary = ["device": self.MOUID() ]
        
        if !self.userID().isEmpty{
            base["userid"] = self.userID()
        }
        if !self.sessionID().isEmpty{
            base["sessionid"] = self.sessionID()
        }
        
        guard let parameters = parameters else { return base }
        
        let array = base.map{ $0 } + parameters.map{ $0 }
        
        return array.reduce( [:], {
            var tmp = $0
            tmp[$1.0] = $1.1
            return tmp
        })
    }
}

