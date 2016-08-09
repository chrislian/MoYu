//
//  Router.swift
//  MoYu
//
//  Created by Chris on 16/7/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

private let mainUrl = "http://moyu.ushesoft.com/api.php/api/"
private let baseUrl = "http://www.moyu.com/api.php/job/"

enum Router {
    
    case signIn(phone:String, verifyCode:String)
    case signOut
    case authCode(phone:String)
    case updateNickname(name:String)
    case updateAutograph(string:String)
    case updateSex(value:Int)
    case updateAge(value:Int)
    case updateAvatar(string:String)//跟新头像
    
    case financial//财务信息
    case feedback(type:String, title:String, content:String) //用户反馈
    case messageCenter//消息中心
    case recruitCenter//招募中心
    case aboutJob(page:Int)//职来职往
    
    func request(remote clourse: RemoteClourse){
        
        println("urlString:\(self.urlString())")
        println("parameters:\(self.parameters())")
        
        Remote.post(url: self.urlString(), parameters: self.parameters(),callback: clourse)
    }
  
}

extension Router: RouterType{
    
    // MARK: - request parameters
    func parameters() -> [String:AnyObject]? {
        
        var parameters:[String:AnyObject]? = nil
        
        switch self {
        case .signIn(let phone, let code):
            parameters = ["type": 2,"device": self.MOUID(),"phonenum": phone,"verify": code]
        case .signOut,.financial:
            parameters = compose()
            
        case .authCode(let phone):
            parameters = ["phonenum" : phone]
            
        case .updateNickname(let name):
            parameters = compose(parameters: ["nickname": name])
            
        case .updateAutograph(let autograph):
            parameters = compose(parameters: ["autograph": autograph])
            
        case .updateSex(let sex):
            parameters = compose(parameters: ["sex": sex])
            
        case .updateAge(let age):
            parameters = compose(parameters: ["age": age])
            
        case .updateAvatar(let base64String):
            parameters = compose(parameters: ["photo": base64String])
            
        case .feedback(let type, let title, let content):
            parameters = compose(parameters: ["type":type, "title":title, "content": content])
            
        case .messageCenter:
            parameters = compose(parameters: ["category_id":39])
            
        case .recruitCenter:
            parameters = compose(parameters: ["category_id":40])
            
        case .aboutJob(let page):
            parameters = compose(parameters: ["page":page])
        }
        return parameters
    }
    
    // MARK: - urlString
    func urlString()->String{
        let suffix:String
        switch self {
        case .signIn:
            suffix = "login"
            
        case .signOut:
            suffix = "logout"
            
        case .authCode:
            suffix = "getVerify"
            
        case .updateNickname, .updateAutograph, .updateSex, .updateAge, .updateAvatar:
            suffix = "personalInformation"
            
        case .financial:
            suffix = "financialInformation"
            
        case .feedback:
            suffix = "feedback"
            
        case .messageCenter, recruitCenter:
            suffix = "getNewsList"
            
        case .aboutJob:
            suffix = "getJobZoneLists"
        }
        return mainUrl + suffix
    }
}
