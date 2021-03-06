//
//  UIFont+MoYu.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

extension UIFont{
    enum MoYuFont:CGFloat {
        case smallest = 12.0
        case smaller = 13.0
        case small = 14.0
        case normal = 15.0
        case big = 16.0
        case bigger = 17.0
        case biggest = 18.0
    }
    
    class func mo_font(_ type:MoYuFont = .normal) -> UIFont {
        return UIFont.systemFont(ofSize: type.rawValue)
    }
    
    class func mo_boldFont(_ type:MoYuFont = .normal) -> UIFont {
        return UIFont.boldSystemFont(ofSize: type.rawValue)
    }
    
    class func mo_italicFont(_ type:MoYuFont = .normal) -> UIFont {
        return UIFont.italicSystemFont(ofSize: type.rawValue)
    }
}
