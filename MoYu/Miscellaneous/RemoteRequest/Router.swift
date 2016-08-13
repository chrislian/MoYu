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
    case updateNickname(name:String)
    case updateAutograph(string:String)
    case updateSex(value:Int)
    case updateAge(value:Int)
    case updateAvatar(string:String)//跟新头像
    
    case financial//财务信息
    case feedback(type:String, title:String, content:String) //用户反馈
    case messageCenter//消息中心
    case recruitCenter//招募中心
    
    case myTaskList(page:Int)//个人发布的兼职列表
    case myParttimeJobList(page:Int)//获取个人兼职列表
    
    case jobZoneList(page:Int)//职来职往
    case jobZoneZan(id:String, value:Bool)//职来职往点赞
    case commitJobZone(message:String)//发布职来职往
    
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
            parameters = compose(parameters: ["type": type, "title": title, "content": content])
            
        case .messageCenter:
            parameters = compose(parameters: ["category_id": 39])
            
        case .recruitCenter:
            parameters = compose(parameters: ["category_id": 40])
            
        case .jobZoneList(let page):
            parameters = compose(parameters: ["page": page])
            
        case .myTaskList(let page):
            parameters = compose(parameters: ["page": page])
            
        case .myParttimeJobList(let page):
            parameters = compose(parameters: ["page": page])
            
        case .jobZoneZan(let id, _):
            parameters = compose(parameters: ["id":id])
            
        case .commitJobZone(let message):
            parameters = compose(parameters: ["memo": message] )
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
            
        case .jobZoneList:
            suffix = "getJobZoneLists"
            
        case .myTaskList:
            suffix = "getMyTaskList"
            
        case .myParttimeJobList:
            suffix =  "getMyPartTimeJobsList"
            
        case .jobZoneZan:
            suffix = "postJobZoneZan"
            
        case .commitJobZone:
            suffix = "postJobZone"
        }
        return mainUrl + suffix
    }
}
