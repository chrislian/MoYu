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
    
    public func mo_loadImage(_ urlString:String ,placeholder:UIImage? = UIImage(named: "defaultAvator")){
        self.kf.setImage(with: URL(string: urlString), placeholder: placeholder)
    }
    
    public func mo_captureImage(_ rect: CGRect) -> UIImage?{
        if let image = self.image, let cgImage = image.cgImage?.cropping(to: rect){
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
}


open class MOImageView: UIImageView {
    
    open override var image: UIImage? {
        set {
            guard let mg = newValue else {
                super.image = newValue
                return
            }
            super.image = mg.mo_drawRectWithRoundedCorner(radius: self.radius, self.bounds.size)
        }
        get{
            return super.image
        }
    }
    
    open func mo_loadRoundImage(_ urlString:String,radius:CGFloat = 0, placeholder:UIImage? = UIImage(named: "defaultAvator")){
        self.radius = radius
        self.kf.setImage(with: URL(string: urlString), placeholder: placeholder)
    }
    
    fileprivate var radius:CGFloat = 0
}
