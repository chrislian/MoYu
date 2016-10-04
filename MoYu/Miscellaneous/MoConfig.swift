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

let MoScreenSize   = UIScreen.main.bounds.size
let MoScreenWidth  = UIScreen.main.bounds.size.width
let MoScreenHeight = UIScreen.main.bounds.size.height
let MoScreenBounds = UIScreen.main.bounds

let MoDefaultLoadMoreCount = 10

private let backgroundQueue = DispatchQueue(label: "com.moyu.backgroundQueue", attributes: DispatchQueue.Attributes.concurrent)

/**
 回到主线程执行
 
 - parameter clourse:
 */
func mainThread(_ clourse: @escaping ()->() ){
    
    if Thread.current.isMainThread{
        clourse()
    }else{
        DispatchQueue.main.async(execute: clourse)
    }
}
/**
 异步执行
 
 - parameter clourse:
 */
func backgroundThread(_ clourse : @escaping ()->()){
    backgroundQueue.async(execute: clourse)
}


func sendMessage(_ name:String, object:AnyObject? = nil,userInfo: [AnyHashable: Any]? = nil){

    Async.main{
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object, userInfo: userInfo)
    }
}

/**
 *  坐标
 */
struct MoYuLocation {
    var latitude:Double = 0
    var longitude:Double = 0
}
