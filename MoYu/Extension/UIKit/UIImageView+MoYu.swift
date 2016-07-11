//
//  UIImageView+MoYu.swift
//  MoYu
//
//  Created by Chris on 16/4/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    public func mo_loadImage(urlString:String ,placeholder:UIImage){
        guard let url = NSURL(string: urlString) else{
            println("urlString:\(urlString)")
            return
        }
        self.kf_setImageWithURL(url, placeholderImage: placeholder)
    }
    
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
    
    public func mo_loadRoundImage(urlString:String,radius:CGFloat = 0, placeholder:UIImage){
        self.radius = radius
        guard let url = NSURL(string: urlString) else{
            println("urlString:\(urlString)")
            return
        }
        self.kf_setImageWithURL(url, placeholderImage:placeholder)
    }
    
    private var radius:CGFloat = 0
}
