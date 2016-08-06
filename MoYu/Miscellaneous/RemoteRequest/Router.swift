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
    case signOut
    case authCode(phone:String)
    case changeNickname(name:String)
    case updateAutograph(string:String)
    
    func request(remote clourse: RemoteClourse){
        
        println("urlString:\(self.urlString())")
        println("parameters:\(self.parameters())")
        
        Remote.post(url: self.urlString(), parameters: self.parameters(),callback: clourse)
    }
    
}

// MARK: - urlString
extension Router{
    
    private func urlString()->String{
        let suffix:String
        switch self {
        case .signIn:
            suffix = "login"
        case .signOut:
            suffix = "logout"
        case .authCode:
            suffix = "getVerify"
        case .changeNickname,.updateAutograph:
            suffix = "personalInformation"
        }
        return mainUrl + suffix
    }
}

// MARK: - request parameters
extension Router{

    private func sessionID()->String{
        
        return UserManager.sharedInstance.user.sessionid
    }
    
    private func userID()->String{
        
        return UserManager.sharedInstance.user.id
    }
    
    private func parameters() -> [String:AnyObject]? {
        
        var parameters:[String:AnyObject]? = nil
        
        guard let mouid = MODevice.MOUID() else{
            return parameters
        }
        
        switch self {
        case .signIn(let phone, let code):
            parameters = ["type": 2,"device": mouid,"phonenum": phone,"verify": code]
        case .signOut:
            parameters = ["sessionid" : self.sessionID(),"device": mouid]
        case .authCode(let phone):
            parameters = ["phonenum" : phone]
        case .changeNickname(let name):
            parameters = ["userid":self.userID(), "sessionid": self.sessionID(), "device":mouid, "nickname": name]
        case .updateAutograph(let autograph):
            parameters = ["userid":self.userID(), "sessionid": self.sessionID(), "device":mouid, "autograph": autograph]
        }
        return parameters
    }
}