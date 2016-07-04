//
//  AccountBindingModel.swift
//  MoYu
//
//  Created by Chris on 16/7/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

enum AccountType:Int {
    case QQ,WeChat,Weibo,Phone
}

struct AccountItem {
    let isBinding:Bool
    let name:String
    let status:String
    let type:AccountType
}

struct MOAccountBindingModel {
    
    let accounts:[AccountItem]
    
    init(){
        let qq = AccountItem(isBinding: true, name: "QQ", status: "331713696",type: .QQ)
        let wechat = AccountItem(isBinding: false, name: "微信", status: "",type: .WeChat)
        let weibo = AccountItem(isBinding: true, name: "微博", status: "公子连",type: .Weibo)
        let phone = AccountItem(isBinding: true, name: "手机", status: "18350210050",type:.Phone)
        
        accounts = [qq,wechat,weibo,phone]
    }
}