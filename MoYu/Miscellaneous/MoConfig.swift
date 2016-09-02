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

let MoDefaultLoadMoreCount = 10

private let backgroundQueue = dispatch_queue_create("com.moyu.backgroundQueue", DISPATCH_QUEUE_CONCURRENT)

/**
 回到主线程执行
 
 - parameter clourse:
 */
func mainThread(clourse: dispatch_block_t ){
    
    if NSThread.currentThread().isMainThread{
        clourse()
    }else{
        dispatch_async(dispatch_get_main_queue(), clourse)
    }
}
/**
 异步执行
 
 - parameter clourse:
 */
func backgroundThread(clourse : dispatch_block_t){
    dispatch_async(backgroundQueue, clourse)
}


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
    var longitude:Double = 0
}