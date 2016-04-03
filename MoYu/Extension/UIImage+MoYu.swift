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
}
