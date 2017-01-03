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


/**
 *  坐标
 */
struct MoYuLocation {
    var latitude:Double = 0
    var longitude:Double = 0
    
    func distance(latitude:Double, longitude:Double)->String{

        if self.latitude == 0 || self.longitude == 0 || latitude == 0 || longitude == 0 {
            return "未知"
        }
        
        let point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(self.latitude, self.longitude))
        let point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(latitude, longitude))
        let distance = BMKMetersBetweenMapPoints(point1,point2)
        
        switch distance {
        case let value where value >= 0 && value < 1000:
            return "\(Int(distance))m"
        case let value where value < 0:
            return "未知"
        default:
            return String(format: "%0.2fkm", distance/1000)
        }
    }
    
    func distance(location:MoYuLocation)->String{
        
        return distance(latitude: location.latitude, longitude: location.longitude)
    }
}

struct MoYuPlatform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

enum MoSex:Int {
    case none = 0
    case male = 1
    case female = 2
    
    init(_ value:Int) {
        
        switch value {
        case 1: self =  .male
        case 2: self =  .female
        default: self =  .none
        }
    }
}
