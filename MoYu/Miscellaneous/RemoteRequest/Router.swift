//
//  Router.swift
//  MoYu
//
//  Created by Chris on 16/7/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

private let mainUrl = "http://www.moyu.ushesoft.com/"

enum Router {
    case SignIn(phone:String, verifyCode:String)
    case SignOut
    
    
    
    func urlString()->String{
        switch self {
        case .SignIn:
            return mainUrl + "api.php/api/login"
        case .SignOut:
            break

        }
        return ""
    }
    
    func parameters() -> [String:AnyObject]? {
        
        var parameters:[String:AnyObject]? = nil
        
        guard let mouid = MODevice.MOUID() else{
            return parameters
        }
        
        switch self {
        case .SignIn(let phone, let code):
            parameters = ["type": 2,"device": mouid,"phonenum": phone,"verify": code]
        case .SignOut:
            break
        }
        return parameters
    }
    
    func request(remote clourse: RemoteClourse){
        
        println("urlString:\(self.urlString())")
        println("parameters:\(self.parameters())")
        
        Remote.post(url: self.urlString(), parameters: self.parameters(),callback: clourse)
    }
    
}