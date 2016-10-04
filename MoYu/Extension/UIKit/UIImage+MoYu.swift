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
    func mo_scaleToSize(_ size:CGSize) -> UIImage {
        
        //1.创建一个bitmap的context
        //2.把他设置成为当前正在使用的 context
        UIGraphicsBeginImageContext(size)
        //3.绘制改变大小的图片
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        //4.从当前的context出堆栈
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //5.返回新的改变大小后的图片
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    /**
     改变图片的颜色
     
     - parameter color: 颜色
     
     - returns: new Image
     */
    func mo_changeColor(_ color:UIColor)->UIImage{
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(.normal)
        let rect = CGRect(origin: CGPoint.zero, size: self.size)
        context?.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
 
}


extension UIImage {
    func mo_drawRectWithRoundedCorner(radius: CGFloat, _ sizetoFit: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: sizetoFit)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        UIGraphicsGetCurrentContext()?.addPath(UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners,
                            cornerRadii: CGSize(width: radius, height: radius)).cgPath)
        UIGraphicsGetCurrentContext()?.clip()
        
        self.draw(in: rect)
        UIGraphicsGetCurrentContext()?.drawPath(using: .fillStroke)
        let output = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return output!
    }
}



extension UIImage {
    
    /**
     颜色转图片
     
     - parameter color:
     
     - returns: UIImage
     */
    class func mo_createImageWithColor(_ color:UIColor)->UIImage{
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func mo_blurEffect(_ cgImage: CGImage, boxSize: CGFloat) -> UIImage! {
        return UIImage(cgImage: cgImage.blurEffect(boxSize))
    }
    
    func mo_blurEffect(_ boxSize: CGFloat) -> UIImage! {
        return UIImage(cgImage: mo_bluredCGImage(boxSize))
    }
    
    func mo_bluredCGImage(_ boxSize: CGFloat) -> CGImage! {
        return cgImage!.blurEffect(boxSize)
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
        
        let cropSquare = CGRect(x: posX, y: posY, width: edge, height: edge)
        
        let imageRef = self.cgImage?.cropping(to: cropSquare)!
        
        return UIImage(cgImage: imageRef!, scale: scale, orientation: self.imageOrientation)
    }
    
    public func resizeToTargetSize(_ targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        let scale = UIScreen.main.scale
        let newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: scale * floor(size.width * heightRatio), height: scale * floor(size.height * heightRatio))
        } else {
            newSize = CGSize(width: scale * floor(size.width * widthRatio), height: scale * floor(size.height * widthRatio))
        }
        
        let rect = CGRect(x: 0, y: 0, width: floor(newSize.width), height: floor(newSize.height))
        
        //println("size: \(size), newSize: \(newSize), rect: \(rect)")
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    public func scaleToMinSideLength(_ sideLength: CGFloat) -> UIImage {
        
        let pixelSideLength = sideLength * UIScreen.main.scale
        
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
        
        if scale == UIScreen.main.scale {
            let newSize = CGSize(width: floor(newSize.width / scale), height: floor(newSize.height / scale))
            //println("A scaleToMinSideLength newSize: \(newSize)")
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
            self.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let image = newImage {
                return image
            }
            
            return self
            
        } else {
            //println("B scaleToMinSideLength newSize: \(newSize)")
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
            self.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let image = newImage {
                return image
            }
            
            return self
        }
    }
    
    public func fixRotation() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        
        let width = self.size.width
        let height = self.size.height
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: width, y: height)
            transform = transform.rotated(by: CGFloat(M_PI))
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: height)
            transform = transform.rotated(by: CGFloat(-M_PI_2))
            
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: width, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
            
        default:
            break
        }
        
        let selfCGImage = self.cgImage
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: (selfCGImage?.bitsPerComponent)!, bytesPerRow: 0, space: (selfCGImage?.colorSpace!)!, bitmapInfo: (selfCGImage?.bitmapInfo.rawValue)!);
        
        context?.concatenate(transform)
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            context?.draw(selfCGImage!, in: CGRect(x: 0,y: 0, width: height, height: width))
            
        default:
            context?.draw(selfCGImage!, in: CGRect(x: 0,y: 0, width: width, height: height))
        }
        
        let cgImage = context?.makeImage()!
        return UIImage(cgImage: cgImage!)
    }
}

extension UIImage{

    func imageFrom(base64 string:String) -> UIImage?{
        
        if let decodeImageData = Data(base64Encoded: string, options: .ignoreUnknownCharacters) {
            return UIImage(data: decodeImageData)
        }
        return nil
    }
    
    func image2Base64()->String?{
        
        var imageData:Data?
        if self.hasAlpha(){
            imageData = UIImagePNGRepresentation(self)
        }else{
            imageData = UIImageJPEGRepresentation(self, 1)
        }
        
        return imageData?.base64EncodedString(options: .lineLength64Characters)
    }
    
    func hasAlpha()->Bool{
        
        guard let alpha = self.cgImage?.alphaInfo else{
            return false
        }
        switch alpha {
        case .premultipliedLast,
             .premultipliedFirst,
             .last,
             .first: return true
            
        default: return false
        }
    }
}

