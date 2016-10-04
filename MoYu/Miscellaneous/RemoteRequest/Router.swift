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
    
    case postParttimeJob(parameter: [String: AnyObject])//发布兼职
    case postTask(paramter: [String:AnyObject])//发布任务
    case searchParttimeJob(page:Int,keyword:String)//兼职关键字搜索
    
    //任务
    case allTask(page:Int)//所有任务
    case taskCategory(type:TaskDetailType, page:Int)//任务分类 1.应用体验， 2.问卷调查，3.其他
    case postTaskStatus(order:String, status:Int)//status 0,接任务， 1.用户完成， 2.商家完成
    case postPartTimeStatus(order:String,status:Int)//status 0,接任务， 1.用户完成， 2.商家完成
    
}

extension Router: RouterType{
    
    
    // MARK: - request parameters
    func parameters() -> [String:AnyObject]? {
        
        var parameters:[String:AnyObject]? = nil
        
        switch self {
        case .signIn(let phone, let code):
            parameters = ["type": 2 as AnyObject,"device": self.MOUID() as AnyObject,"phonenum": phone as AnyObject,"verify": code as AnyObject]
        case .signOut,.financial:
            parameters = compose()
            
        case .authCode(let phone):
            parameters = ["phonenum" : phone as AnyObject]
            
        case .updateNickname(let name):
            parameters = compose(parameters: ["nickname": name as AnyObject])
            
        case .updateAutograph(let autograph):
            parameters = compose(parameters: ["autograph": autograph as AnyObject])
            
        case .updateSex(let sex):
            parameters = compose(parameters: ["sex": sex as AnyObject])
            
        case .updateAge(let age):
            parameters = compose(parameters: ["age": age as AnyObject])
            
        case .updateAvatar(let base64String):
            parameters = compose(parameters: ["photo": base64String as AnyObject])
            
        case .feedback(let type, let title, let content):
            parameters = compose(parameters: ["type": type as AnyObject, "title": title as AnyObject, "content": content as AnyObject])
            
        case .messageCenter:
            parameters = compose(parameters: ["category_id": 39 as AnyObject])
            
        case .recruitCenter:
            parameters = compose(parameters: ["category_id": 40 as AnyObject])
            
        case .jobZoneList(let page):
            parameters = compose(parameters: ["page": page as AnyObject])
            
        case .myTaskList(let page):
            parameters = compose(parameters: ["page": page as AnyObject])
            
        case .myParttimeJobList(let page):
            parameters = compose(parameters: ["page": page as AnyObject])
            
        case .jobZoneZan(let id, _):
            parameters = compose(parameters: ["id":id as AnyObject])
            
        case .commitJobZone(let message):
            parameters = compose(parameters: ["memo": message as AnyObject] )
            
        case .allPartTimeJobList(let page, let location):
            
            var tmp:[String:AnyObject] = ["page": page as AnyObject]
            if let tmpLocation = location{
                tmp["latitude"] = tmpLocation.latitude as AnyObject?
                tmp["longitude"] = tmpLocation.longitude as AnyObject?
            }
            parameters = compose(parameters: tmp)
        
        case .postParttimeJob(let parameter):
            parameters = compose(parameters: parameter)
            
        case .postTask(let paramter):
            parameters = compose(parameters: paramter)
        case .searchParttimeJob(let page, let keyword):
            parameters = compose(parameters: ["page":page as AnyObject,"title":keyword as AnyObject])
        
        case .allTask(let page):
            parameters = compose(parameters: ["page": page as AnyObject])
            
        case .taskCategory(let type, let page):
            parameters = compose(parameters: ["page": page as AnyObject, "type":type.rawValue as AnyObject] )
            
        case .postTaskStatus(let order, let status):
            parameters = compose(parameters: ["ordernum":order as AnyObject, "status":status as AnyObject])
        case .postPartTimeStatus(let order, let status):
            parameters = compose(parameters: ["ordernum":order as AnyObject, "status":status as AnyObject])
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
        }
        return mainUrl + suffix
    }
}
