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
    
    func mo_length()->Int{
       return self.characters.count
    }
}

extension String {
    
    func base64Encode()->String?{
        
        let data = self.data(using: String.Encoding.utf8)
        
        return data?.base64EncodedString(options: NSData.Base64EncodingOptions())
    }
    
    func base64Decode()->String?{
        
        guard let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions()) else{ return nil }
        
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
