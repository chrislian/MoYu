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
    case updateSex(value:Int)
    case updateAge(value:Int)
    case updateAvatar(string:String)
    
    func request(remote clourse: RemoteClourse){
        
        println("urlString:\(self.urlString())")
//        println("parameters:\(self.parameters())")
//        
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
        case .changeNickname, .updateAutograph, updateSex, .updateAge, updateAvatar:
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
    
    private func MOUID()->String{
        return MODevice.MOUID()!
    }
    
    private func personalInfo(key key:String,value:AnyObject) -> [String: AnyObject]{
        
        return ["userid":userID(), "sessionid": sessionID(), "device":MOUID(), key:value]
    }
    
    private func parameters() -> [String:AnyObject]? {
        
        var parameters:[String:AnyObject]? = nil
        
        switch self {
        case .signIn(let phone, let code):
            parameters = ["type": 2,"device": MOUID(),"phonenum": phone,"verify": code]
        case .signOut:
            parameters = ["sessionid" : self.sessionID(),"device": MOUID()]
        case .authCode(let phone):
            parameters = ["phonenum" : phone]
        case .changeNickname(let name):
            parameters = personalInfo(key: "nickname", value: name)
        case .updateAutograph(let autograph):
            parameters = personalInfo(key: "autograph", value: autograph)
        case .updateSex(let sex):
            parameters = personalInfo(key: "sex", value: sex)
        case .updateAge(let age):
            parameters = personalInfo(key: "age", value: age)
        case .updateAvatar(let base64String):
            parameters = personalInfo(key: "photo", value: base64String)
        }
        return parameters
    }
}