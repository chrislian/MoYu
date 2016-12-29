//
//  UISeachBar+Extension.swift
//  meiqu
//
//  Created by meiqu on 16/3/24.
//  Copyright © 2016年 com.meiqu.com. All rights reserved.
//

import UIKit

extension UISearchBar{
    
    /**
     设置搜索栏的颜色
     
     - parameter isSelected: 是否选中状态
     */
    func mo_setSearchBar(color isSelected:Bool, font:UIFont = .mo_font()){
        
        guard let tmpView = self.subviews.first else { return }
        
        for subview in tmpView.subviews where subview.isKind(of: NSClassFromString("UITextField")!){
            subview.layer.borderWidth = 0.5
            if isSelected{
                subview.layer.borderColor = UIColor.mo_main.cgColor
            }else{
                subview.layer.borderColor = UIColor.mo_mercury.cgColor
            }
            subview.layer.cornerRadius = 14
            subview.layer.masksToBounds = true
            
            if let textfield = subview as? UITextField{
                textfield.font = font
            }
        }
    }
}
