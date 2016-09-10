//
//  UINavigationController+MoYu.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

extension UINavigationController{
    
    /**
     隐藏导航条返回键的 title
     */
    func mo_hideBackButtonTitle(){
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), forBarMetrics:UIBarMetrics.Default)
        
    }
    
    
    /**
     导航栏不透明
     
     - parameter value: true false
     */
    func mo_navigationBar(opaque value:Bool, tintColor:UIColor = UIColor.mo_main()){
        if value{
            self.navigationBar.setBackgroundImage( UIImage.mo_createImageWithColor( tintColor ), forBarMetrics: .Default)
            self.navigationBar.shadowImage = UIImage.mo_createImageWithColor(UIColor.mo_silver())
            //            self.navigationController?.navigationBar.translucent = false
        }else{
            self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            self.navigationBar.shadowImage = UIImage()
            //            self.navigationController?.navigationBar.translucent = true
        }
    }
    
    /**
     隐藏返回标题
     */
    class func mo_hideBackTitle(){
        
        let offset = UIOffset(horizontal: 0, vertical: -60)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(offset, forBarMetrics: .Default)
    }
}
