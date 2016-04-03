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
    func my_hideBackButtonTitle(){
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), forBarMetrics:UIBarMetrics.Default)
        
    }
}
