//
//  String+MoYu.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

extension String{

    static func my_stringToBool(string:String) ->Bool {
        if string == "true" || string == "TRUE" {
            return true
        }
        return false
    }
    
    static func my_boolToString(bool:Bool) -> String {
        if bool {
            return "true"
        }
        return "false"
    }
}