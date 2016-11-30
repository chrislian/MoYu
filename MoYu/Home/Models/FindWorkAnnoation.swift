//
//  FindWorkAnnoation.swift
//  MoYu
//
//  Created by lxb on 2016/11/30.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class FindWorkAnnoation: BMKPointAnnotation {
    
    var model:HomeMenuModel
    
    init(model:HomeMenuModel) {
        
        self.model = model
        super.init()
        
        if let latitude = Double(model.latitude), let longitude = Double(model.longitude){
            self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            self.title = ""
        }
    }
  
    
    func distance(location:MoYuLocation) ->String{
        
        guard let lat = Double(model.latitude), let lon = Double(model.longitude) else{
            return "未知位置"
        }
        return location.distance(latitude: lat, longitude: lon)
    }
}
