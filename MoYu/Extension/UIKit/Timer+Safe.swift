//
//  File.swift
//  MoYu
//
//  Created by lxb on 2016/12/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

public extension Timer{
    
    /**
     定时器
     
     - parameter interval: NSTimeInterval
     - parameter repeats:  true or false
     - parameter closure:  Void->Void
     
     - returns: NSTimer
     */
    public class func cl_startTimer(interval:TimeInterval, repeats:Bool, closure:@escaping ((Void)->Void))->Timer{
        
        
        let timer = Timer(timeInterval: interval, target: self, selector: #selector(cl_closureInvoke(timer:)), userInfo:closure, repeats: repeats)
        
        return timer
    }
    
    @objc fileprivate class func cl_closureInvoke(timer:Timer){
        
        if let clourse = timer.userInfo as? ((Void)->Void) {
            clourse()
        }
        
    }
}
