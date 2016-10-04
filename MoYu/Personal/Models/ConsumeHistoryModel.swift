//
//  consumeHistoryModel.swift
//  MoYu
//
//  Created by Chris on 16/7/26.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

struct ConsumeHistoryItem{
    
    let date:Date
    let imageUrl:String
    let consume:Int
    let detail:String
    
    init(){
        date = Date()
        imageUrl = ""
        consume = 100
        detail = "话费充值 18350210050"
    }
}
