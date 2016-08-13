//
//  MoConfig.swift
//  MoYu
//
//  Created by Chris on 16/8/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import UIKit
import Async

let MoScreenSize   = UIScreen.mainScreen().bounds.size
let MoScreenWidth  = UIScreen.mainScreen().bounds.size.width
let MoScreenHeight = UIScreen.mainScreen().bounds.size.height
let MoScreenBounds = UIScreen.mainScreen().bounds


func sendMessage(name:String, object:AnyObject? = nil,userInfo: [NSObject : AnyObject]? = nil){

    Async.main{
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: object, userInfo: userInfo)
    }
}

/**
 *  坐标
 */
struct MoYuLocation {
    var latitude:Double = 0
    var longtitude:Double = 0
}