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
     隐藏导航栏底部的黑线
     
     - parameter hide: ture or false
     */
    func mo_hide(hairLine hide:Bool){
        func findHairLineUnder(_ view:UIView) -> UIImageView? {
            if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
                return view as? UIImageView
            }
            for subview in view.subviews {
                return findHairLineUnder(subview)
            }
            return nil
        }
        
        guard let imageView = findHairLineUnder(self) else{
            return
        }
        imageView.isHidden = hide
    }
    
}
