//
//  consumeHistoryModel.swift
//  MoYu
//
//  Created by Chris on 16/7/26.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

struct ConsumeHistoryItem{
    
    let date:NSDate
    let imageUrl:String
    let consume:Int
    let detail:String
    
    init(){
        date = NSDate()
        imageUrl = ""
        consume = 100
        detail = "话费充值 18350210050"
    }
}