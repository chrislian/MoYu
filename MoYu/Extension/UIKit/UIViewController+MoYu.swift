//
//  UIViewController+MoYu.swift
//  MoYu
//
//  Created by Chris on 16/9/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

extension UIViewController{
    
    /**
     通过`titleView`设置导航栏的title
     
     - parameter aTitle:
     */
    func mo_navigationBar(title aTitle:String){
        
        self.navigationItem.titleView = nil
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 43))
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.bigger)
        label.textAlignment = .Center
        label.text = aTitle
        
        self.navigationItem.titleView  = label
    }
}
