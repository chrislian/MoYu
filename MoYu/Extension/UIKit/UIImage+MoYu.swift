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
    func mo_drawRectWithRoundedCorner(radius  radius: CGFloat, _ sizetoFit: CGSize) -> UIImage {
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
    
    /**
     颜色转图片
     
     - parameter color:
     
     - returns: UIImage
     */
    class func mo_createImageWithColor(color:UIColor)->UIImage{
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func mo_blurEffect(cgImage: CGImageRef, boxSize: CGFloat) -> UIImage! {
        return UIImage(CGImage: cgImage.blurEffect(boxSize))
    }
    
    func mo_blurEffect(boxSize: CGFloat) -> UIImage! {
        return UIImage(CGImage: mo_bluredCGImage(boxSize))
    }
    
    func mo_bluredCGImage(boxSize: CGFloat) -> CGImageRef! {
        return CGImage!.blurEffect(boxSize)
    }
}


public extension UIImage {
    
    public func largestCenteredSquareImage() -> UIImage {
        let scale = self.scale
        
        let originalWidth  = self.size.width * scale
        let originalHeight = self.size.height * scale
        
        let edge: CGFloat
        if originalWidth > originalHeight {
            edge = originalHeight
        } else {
            edge = originalWidth
        }
        
        let posX = (originalWidth  - edge) / 2.0
        let posY = (originalHeight - edge) / 2.0
        
        let cropSquare = CGRectMake(posX, posY, edge, edge)
        
        let imageRef = CGImageCreateWithImageInRect(self.CGImage, cropSquare)!
        
        return UIImage(CGImage: imageRef, scale: scale, orientation: self.imageOrientation)
    }
    
    public func resizeToTargetSize(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        let scale = UIScreen.mainScreen().scale
        let newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(scale * floor(size.width * heightRatio), scale * floor(size.height * heightRatio))
        } else {
            newSize = CGSizeMake(scale * floor(size.width * widthRatio), scale * floor(size.height * widthRatio))
        }
        
        let rect = CGRectMake(0, 0, floor(newSize.width), floor(newSize.height))
        
        //println("size: \(size), newSize: \(newSize), rect: \(rect)")
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public func scaleToMinSideLength(sideLength: CGFloat) -> UIImage {
        
        let pixelSideLength = sideLength * UIScreen.mainScreen().scale
        
        //println("pixelSideLength: \(pixelSideLength)")
        //println("size: \(size)")
        
        let pixelWidth = size.width * scale
        let pixelHeight = size.height * scale
        
        //println("pixelWidth: \(pixelWidth)")
        //println("pixelHeight: \(pixelHeight)")
        
        let newSize: CGSize
        
        if pixelWidth > pixelHeight {
            
            guard pixelHeight > pixelSideLength else {
                return self
            }
            
            let newHeight = pixelSideLength
            let newWidth = (pixelSideLength / pixelHeight) * pixelWidth
            newSize = CGSize(width: floor(newWidth), height: floor(newHeight))
            
        } else {
            
            guard pixelWidth > pixelSideLength else {
                return self
            }
            
            let newWidth = pixelSideLength
            let newHeight = (pixelSideLength / pixelWidth) * pixelHeight
            newSize = CGSize(width: floor(newWidth), height: floor(newHeight))
        }
        
        if scale == UIScreen.mainScreen().scale {
            let newSize = CGSize(width: floor(newSize.width / scale), height: floor(newSize.height / scale))
            //println("A scaleToMinSideLength newSize: \(newSize)")
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
            let rect = CGRectMake(0, 0, newSize.width, newSize.height)
            self.drawInRect(rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let image = newImage {
                return image
            }
            
            return self
            
        } else {
            //println("B scaleToMinSideLength newSize: \(newSize)")
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            let rect = CGRectMake(0, 0, newSize.width, newSize.height)
            self.drawInRect(rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let image = newImage {
                return image
            }
            
            return self
        }
    }
    
    public func fixRotation() -> UIImage {
        if self.imageOrientation == .Up {
            return self
        }
        
        let width = self.size.width
        let height = self.size.height
        
        var transform = CGAffineTransformIdentity
        
        switch self.imageOrientation {
        case .Down, .DownMirrored:
            transform = CGAffineTransformTranslate(transform, width, height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
            
        case .Left, .LeftMirrored:
            transform = CGAffineTransformTranslate(transform, width, 0)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            
        case .Right, .RightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, height)
            transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
            
        default:
            break
        }
        
        switch self.imageOrientation {
        case .UpMirrored, .DownMirrored:
            transform = CGAffineTransformTranslate(transform, width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            
        case .LeftMirrored, .RightMirrored:
            transform = CGAffineTransformTranslate(transform, height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            
        default:
            break
        }
        
        let selfCGImage = self.CGImage
        let context = CGBitmapContextCreate(nil, Int(width), Int(height), CGImageGetBitsPerComponent(selfCGImage), 0, CGImageGetColorSpace(selfCGImage), CGImageGetBitmapInfo(selfCGImage).rawValue);
        
        CGContextConcatCTM(context, transform)
        
        switch self.imageOrientation {
        case .Left, .LeftMirrored, .Right, .RightMirrored:
            CGContextDrawImage(context, CGRectMake(0,0, height, width), selfCGImage)
            
        default:
            CGContextDrawImage(context, CGRectMake(0,0, width, height), selfCGImage)
        }
        
        let cgImage = CGBitmapContextCreateImage(context)!
        return UIImage(CGImage: cgImage)
    }
}

extension UIImage{

    func image2Base64()->String?{
        
        var imageData:NSData?
        if self.hasAlpha(){
            imageData = UIImagePNGRepresentation(self)
        }else{
            imageData = UIImageJPEGRepresentation(self, 1)
        }
        
        return imageData?.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
    }
    
    func hasAlpha()->Bool{
        let alpha = CGImageGetAlphaInfo(self.CGImage)
        switch alpha {
        case .PremultipliedLast,
             .PremultipliedFirst,
             .Last,
             .First: return true
            
        default: return false
        }
    }
}

