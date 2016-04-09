//
//  MOHomeMenuItemModel.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation


struct MOHomeMenuItem {
    
    let imageName:String
    let date:String
    let title:String
    let area:String
    let price:String
    
}

struct MOHomeMenuItemModel {
    
    
    var datas:[MOHomeMenuItem] = []
    let rows:Int
    
    init(items:Int){
        
        rows = items
        for i in 0..<items {
            let item:MOHomeMenuItem
            switch i%3 {
            case 0:
                item = MOHomeMenuItem(imageName: "home_menu_server", date: "04-10", title: "服务员和传菜员", area: "思明区", price: "100¥/天")
            case 1:
                item = MOHomeMenuItem(imageName: "home_menu_worker", date: "04-26", title: "工厂工作人员", area: "湖里区", price: "150¥/天")
            default:
                item = MOHomeMenuItem(imageName: "home_menu_sender", date: "04-01", title: "传单员", area: "集美区", price: "88.0¥/天")
            }
            datas.append(item)
        }
    }
}