//
//  UIImageView+MoYu.swift
//  MoYu
//
//  Created by Chris on 16/4/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

extension UIImageView {
//    public func mqLoadIconImage(url:String!,placeholderImage:UIImage!=UIImage(named: "userDefaultSmall")){
//        self.setMqUserIconWithURLString(url, placeholderImage: placeholderImage)
//    }
//    
//    public func mqLoadImage(url:String!,placeholderImage:UIImage!=UIImage(named: "image_load_failed_common")){
//        self.setMQImageWithURL(url, placeholderImage: placeholderImage)
//    }
    
    public func mo_captureImage(rect: CGRect) -> UIImage?{
        if let image = self.image, cgImage = CGImageCreateWithImageInRect(image.CGImage, rect){
            return UIImage(CGImage: cgImage)
        }
        
        return nil
    }
}


public class MOImageView: UIImageView {
    
    public override var image: UIImage? {
        set {
            guard let mg = newValue else {
                super.image = newValue
                return
            }
            super.image = mg.drawRectWithRoundedCorner(radius: self.radius, self.bounds.size)
        }
        get{
            return super.image
        }
    }
    
//    public func loadRoundImage(url:String,radius:CGFloat = 0,placeholder:UIImage? = UIImage(named: "image_load_failed_common")){
//        self.radius = radius
//        self.mqLoadImage(url, placeholderImage: placeholder)
//    }
    
    private var radius:CGFloat = 0
}
