//
//  UIImage+MoYu.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

extension UIImage{
    
    /**
     缩放图片
     
     - parameter size: 缩放的大小
     
     - returns: UIImage
     */
    func mo_scaleToSize(size:CGSize) -> UIImage {
        
        //1.创建一个bitmap的context
        //2.把他设置成为当前正在使用的 context
        UIGraphicsBeginImageContext(size)
        //3.绘制改变大小的图片
        self.drawInRect(CGRect(origin: CGPointZero, size: size))
        //4.从当前的context出堆栈
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //5.返回新的改变大小后的图片
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /**
     改变图片的颜色
     
     - parameter color: 颜色
     
     - returns: new Image
     */
    func mo_changeColor(color:UIColor)->UIImage{
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, .Normal)
        let rect = CGRect(origin: CGPointZero, size: self.size)
        CGContextClipToMask(context, rect, self.CGImage)
        color.setFill()
        CGContextFillRect(context, rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
 
}


extension UIImage {
    func drawRectWithRoundedCorner(radius  radius: CGFloat, _ sizetoFit: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: sizetoFit)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        CGContextAddPath(UIGraphicsGetCurrentContext(),
                         UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.AllCorners,
                            cornerRadii: CGSize(width: radius, height: radius)).CGPath)
        CGContextClip(UIGraphicsGetCurrentContext())
        
        self.drawInRect(rect)
        CGContextDrawPath(UIGraphicsGetCurrentContext(), .FillStroke)
        let output = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return output
    }
}

extension UIImage {
    class func blurEffect(cgImage: CGImageRef, boxSize: CGFloat) -> UIImage! {
        return UIImage(CGImage: cgImage.blurEffect(boxSize))
    }
    
    func blurEffect(boxSize: CGFloat) -> UIImage! {
        return UIImage(CGImage: bluredCGImage(boxSize))
    }
    
    func bluredCGImage(boxSize: CGFloat) -> CGImageRef! {
        return CGImage!.blurEffect(boxSize)
    }
}

