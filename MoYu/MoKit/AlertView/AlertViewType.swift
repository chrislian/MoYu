//
//  AlertViewType.swift
//  MoYu
//
//  Created by Chris on 16/9/2.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import Async

protocol AlertViewType {
    
    var alertView : OLGhostAlertView { set get }
    var alertLock : NSLock { get set }
    
    func showAlert(message aTitle:String, subTitle:String?, timout:NSTimeInterval, forced:Bool, completed:(Void->Void)?)
    
    func showAlert(customView view: UIView, timeout: NSTimeInterval , backgroundColor: UIColor, completed: (Void -> Void)?)
    
    func dismiss()
}

extension AlertViewType{

    func showAlert(message aTitle:String, subTitle:String? = nil, timout:NSTimeInterval = 2, forced:Bool = false, completed:(Void->Void)? = nil){
        
        Async.main {
            self.alertLock.lock()
            if self.alertView.visible{
                self.alertView.hide()
            }
            self.alertView.position = .Center
            self.alertView.completionBlock = completed
            
            self.alertView.message = subTitle ?? ""
            self.alertView.title = aTitle
            self.alertView.customView = nil
            
            if forced{
                self.alertView.showInWindow()
            }else{
                self.alertView.show()
            }
            self.alertLock.unlock()
        }
    }
    
    func showAlert(customView view: UIView, timeout: NSTimeInterval = 2, backgroundColor: UIColor = UIColor.lightGrayColor() ,completed: (Void -> Void)? = nil){
        
        Async.main {
            if self.alertView.visible{
                self.alertView.hide()
            }
            self.alertView.position = .Center
            self.alertView.completionBlock = completed
            self.alertView.timeout = timeout
            self.alertView.backgroundColor = backgroundColor
            self.alertView.title = ""
            self.alertView.customView = view
            self.alertView.show()
        }
    }
    
    func dismiss(){
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2), dispatch_get_main_queue()) {
            
            self.alertView.hide(true)
        }
    }
    
}

class AlertView : AlertViewType{
    
    lazy var alertView = OLGhostAlertView()
    lazy var alertLock = NSLock()
}

