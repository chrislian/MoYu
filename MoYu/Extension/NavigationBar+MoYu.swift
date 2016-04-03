//
//  NavigationBar+MoYu.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

extension UINavigationBar{
    
    /**
     找出导航栏底部的横线
     
     - returns: UIImageView
     */
    func mo_findHairLineImageView()->UIImageView?{
        
        func findHairLineImageViewUnder(view:UIView)-> UIImageView?{
            
            if view.isKindOfClass(UIImageView) && view.bounds.size.height <= 1.0{
                return view as? UIImageView
            }
            return nil
        }
        
        for subview in self.subviews{
            
            return findHairLineImageViewUnder(subview)
        }
        return nil
    }
    
}