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
    
    class func my_font(type:MoYuFont = .normal) -> UIFont {
        return UIFont.systemFontOfSize(type.rawValue)
    }
    
    class func my_boldFont(type:MoYuFont = .normal) -> UIFont {
        return UIFont.boldSystemFontOfSize(type.rawValue)
    }
    
    class func my_italicFont(type:MoYuFont = .normal) -> UIFont {
        return UIFont.italicSystemFontOfSize(type.rawValue)
    }
}
