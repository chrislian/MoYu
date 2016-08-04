//
//  Router.swift
//  MoYu
//
//  Created by Chris on 16/7/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

private let mainUrl = "http://moyu.ushesoft.com/api.php/api/"

enum Router {
    case signIn(phone:String, verifyCode:String)
    case signOut(sessionID:String)
    case authCode(phone:String)
    
    
    
    func urlString()->String{
        switch self {
        case .signIn:
            return mainUrl + "login"
        case .signOut:
            return "http://www.ushesoft.com/api.php/User/logout?"
        case .authCode:
            return mainUrl + "getVerify"
        }
    }
    
    func parameters() -> [String:AnyObject]? {
        
        var parameters:[String:AnyObject]? = nil
        
        guard let mouid = MODevice.MOUID() else{
            return parameters
        }
        
        switch self {
        case .signIn(let phone, let code):
            parameters = ["type": 2,"device": mouid,"phonenum": phone,"verify": code]
        case .signOut(let sessionID):
            parameters = ["sessionid" : sessionID]
        case .authCode(let phone):
            parameters = ["phonenum" : phone]
        }
        return parameters
    }
    
    func request(remote clourse: RemoteClourse){
        
        println("urlString:\(self.urlString())")
        println("parameters:\(self.parameters())")
        
        Remote.post(url: self.urlString(), parameters: self.parameters(),callback: clourse)
    }
    
}