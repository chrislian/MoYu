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
    
    func compose(parameters: JSONDictionary?) -> JSONDictionary
    
    func request(remote clourse: @escaping RemoteClourse)
    
    var sessionID:String{ get }
    
    var userID:String{ get }
    
    var MOUID:String{ get }
    
    //required
    var parameters:JSONDictionary?{ get }
    var urlString:String{ get }
}

extension RouterType {
    
    func request(remote clourse: @escaping RemoteClourse){
        
//        println("urlString:\(self.urlString())")
//        println("parameters:\(self.parameters())")
        
        Remote.post(url: urlString, parameters: parameters,callback: clourse)
    }
    
    
    var sessionID:String{
        
        return UserManager.sharedInstance.user.sessionid
    }
    
    var userID:String{
        
        return UserManager.sharedInstance.user.id
    }
    
    var MOUID:String{
        return MODevice.MOUID() ?? ""
    }
    
    func compose(parameters: JSONDictionary? = nil) -> JSONDictionary{
        
        var base:JSONDictionary = ["device": MOUID]
        
        if !userID.isEmpty{
            base["userid"] = userID
        }
        if !sessionID.isEmpty{
            base["sessionid"] = sessionID
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

