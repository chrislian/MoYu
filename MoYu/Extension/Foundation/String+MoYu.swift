//
//  String+MoYu.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

extension String{

    func mo_string(toBool string:String) ->Bool {
        if string == "true" || string == "TRUE" {
            return true
        }
        return false
    }
    
    func mo_bool(toString bool:Bool) -> String {
        if bool {
            return "true"
        }
        return "false"
    }
}

extension String {
    
    func base64Encode()->String?{
        
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        
        return data?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
    }
    
    func base64Decode()->String?{
        
        guard let data = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions()) else{ return nil }
        
        return String(data: data, encoding: NSUTF8StringEncoding)
    }
}