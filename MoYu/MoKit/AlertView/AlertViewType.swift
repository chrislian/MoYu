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
    
    func showAlert(message aTitle:String, subTitle:String?, timout:TimeInterval, forced:Bool, completed:((Void)->Void)?)
    
    func showAlert(customView view: UIView, timeout: TimeInterval , backgroundColor: UIColor, completed: ((Void) -> Void)?)
    
    func dismiss()
}

extension AlertViewType{
    
    var alertView: OLGhostAlertView{
        
        return MoAlertView.shareInstance.alertView
    }
    
    var alertLock:NSLock{
        
        return MoAlertView.shareInstance.alertLock
    }
    
    func showAlert(message aTitle:String, subTitle:String? = nil, timout:TimeInterval = 2, forced:Bool = false, completed:((Void)->Void)? = nil){
        
        Async.main {
            self.alertLock.lock()
            if self.alertView.isVisible{
                self.alertView.hide()
            }
            self.alertView.position = .center
            self.alertView.completionBlock = completed
            
            self.alertView.message = subTitle
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
    
    func showAlert(customView view: UIView, timeout: TimeInterval = 2, backgroundColor: UIColor = UIColor.lightGray ,completed: ((Void) -> Void)? = nil){
        
        Async.main {

            if self.alertView.isVisible{
                self.alertView.hide()
            }
            self.alertView.position = .center
            self.alertView.completionBlock = completed
            self.alertView.timeout = timeout
            self.alertView.backgroundColor = backgroundColor
            self.alertView.title = ""
            self.alertView.customView = view
            self.alertView.show()
        }
    }
    
    func dismiss(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(2) / Double(NSEC_PER_SEC)) {
            
            self.alertView.hide(true)
        }
    }
}

private class MoAlertView : AlertViewType{
    
    static let shareInstance = MoAlertView()
    
    lazy var alertView = OLGhostAlertView()
    lazy var alertLock = NSLock()
}

