//
//  Router.swift
//  MoYu
//
//  Created by Chris on 16/7/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

let baseUrl = "http://moyu.ushesoft.com/"

let mainUrl = baseUrl + "api.php/api/"

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
    
    case myTaskList(page:Int)//个人接收的兼职和任务列表
    case myParttimeJobList(page:Int)//获取个人发布的和兼职列表
    case allPartTimeJobList(page:Int, location: MoYuLocation?)//获取所有兼职列表
    
    
    case jobZoneList(page:Int)//职来职往
    case jobZoneZan(id:String, value:Bool)//职来职往点赞
    case commitJobZone(message:String)//发布职来职往
    
    case postParttimeJob(parameter: JSONDictionary)//发布兼职
    case postTask(paramter: JSONDictionary)//发布任务
    case searchParttimeJob(page:Int,keyword:String)//兼职关键字搜索
    case getParttimeJob(order:String, status:Int)//status 0,接兼职， 1.用户完成， 2.商家完成

    
    //任务
    case allTask(page:Int)//所有任务
    case taskCategory(type:TaskDetailType, page:Int)//任务分类 1.应用体验， 2.问卷调查，3.其他
    case postTaskStatus(order:String, status:Int)//status 0,接任务， 1.用户完成， 2.商家完成
    case postPartTimeStatus(order:String,status:Int)//status 0,接任务， 1.用户完成， 2.商家完成
    case checkTaskStatus(order:String)//查看订单状态
    
}

extension Router: RouterType{
    
    
    // MARK: - request parameters
    func parameters() -> JSONDictionary? {
        
        var parameters:JSONDictionary? = nil
        
        switch self {
        case .signIn(let phone, let code):
            parameters = ["type": 2 ,"device": self.MOUID() ,"phonenum": phone ,"verify": code ]
        case .signOut,.financial:
            parameters = compose()
            
        case .authCode(let phone):
            parameters = ["phonenum" : phone ]
            
        case .updateNickname(let name):
            parameters = compose(parameters: ["nickname": name ])
            
        case .updateAutograph(let autograph):
            parameters = compose(parameters: ["autograph": autograph ])
            
        case .updateSex(let sex):
            parameters = compose(parameters: ["sex": sex ])
            
        case .updateAge(let age):
            parameters = compose(parameters: ["age": age ])
            
        case .updateAvatar(let base64String):
            parameters = compose(parameters: ["photo": base64String ])
            
        case .feedback(let type, let title, let content):
            parameters = compose(parameters: ["type": type , "title": title , "content": content ])
            
        case .messageCenter:
            parameters = compose(parameters: ["category_id": 39 ])
            
        case .recruitCenter:
            parameters = compose(parameters: ["category_id": 40 ])
            
        case .jobZoneList(let page):
            parameters = compose(parameters: ["page": page ])
            
        case .myTaskList(let page):
            parameters = compose(parameters: ["page": page ])
            
        case .myParttimeJobList(let page):
            parameters = compose(parameters: ["page": page ])
            
        case .jobZoneZan(let id, _):
            parameters = compose(parameters: ["id":id ])
            
        case .commitJobZone(let message):
            parameters = compose(parameters: ["memo": message ] )
            
        case .allPartTimeJobList(let page, let location):
            
            var tmp:JSONDictionary = ["page": page ]
            if let tmpLocation = location{
                tmp["latitude"] = tmpLocation.latitude
                tmp["longitude"] = tmpLocation.longitude
            }
            parameters = compose(parameters: tmp)
        
        case .postParttimeJob(let parameter):
            parameters = compose(parameters: parameter)
            
        case .postTask(let paramter):
            parameters = compose(parameters: paramter)
        case .searchParttimeJob(let page, let keyword):
            parameters = compose(parameters: ["page":page ,"title":keyword ])
        
        case .allTask(let page):
            parameters = compose(parameters: ["page": page ])
            
        case .taskCategory(let type, let page):
            parameters = compose(parameters: ["page": page , "type":type.rawValue ] )
            
        case .postTaskStatus(let order, let status):
            parameters = compose(parameters: ["ordernum":order , "status":status ])
        case .postPartTimeStatus(let order, let status):
            parameters = compose(parameters: ["ordernum":order , "status":status ])
            
        case .checkTaskStatus(let order):
            parameters = compose(parameters: ["ordernum":order ])
            
        case .getParttimeJob(let order, let status):
            parameters = compose(parameters: ["ordernum":order, "status":status])
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
            
        case .messageCenter, .recruitCenter:
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
            
        case .allPartTimeJobList:
            suffix = "getAllPartTimeJobList"
            
        case .postParttimeJob:
            suffix = "postPartTimeJob"
            
        case .postTask:
            suffix = "postTask"
            
        case .searchParttimeJob:
            suffix = "getPartTimeJobTitle"
            
        case .allTask:
            suffix = "getAllTaskList"
            
        case .taskCategory:
            suffix = "getClassTaskList"
            
        case .postTaskStatus:
            suffix = "postTaskStatus"
        case .postPartTimeStatus:
            suffix = "postPartTimeStatus"
        case .checkTaskStatus:
            suffix = "testS"
        case .getParttimeJob:
            suffix = "postPartTimeStatus"
        }
        return mainUrl + suffix
    }
}
