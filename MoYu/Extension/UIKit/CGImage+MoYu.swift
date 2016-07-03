//
//  CGImage+Extension.swift
//  MoYu
//
//  Created by Chris on 16/4/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import QuartzCore
import Accelerate


extension CGImage {
    func blurEffect(boxSize: CGFloat) -> CGImageRef! {
        
        let boxSize = boxSize - (boxSize % 2) + 1
        
        let inProvider = CGImageGetDataProvider(self)
        
        let height = vImagePixelCount(CGImageGetHeight(self))
        let width = vImagePixelCount(CGImageGetWidth(self))
        let rowBytes = CGImageGetBytesPerRow(self)
        
        let inBitmapData = CGDataProviderCopyData(inProvider)
        let inData = UnsafeMutablePointer<Void>(CFDataGetBytePtr(inBitmapData))
        var inBuffer = vImage_Buffer(data: inData, height: height, width: width, rowBytes: rowBytes)
        
        let outData = malloc(CGImageGetBytesPerRow(self) * CGImageGetHeight(self))
        var outBuffer = vImage_Buffer(data: outData, height: height, width: width, rowBytes: rowBytes)
        
        vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context = CGBitmapContextCreate(outBuffer.data, Int(outBuffer.width), Int(outBuffer.height), 8, outBuffer.rowBytes, colorSpace, CGBitmapInfo(rawValue: CGBitmapInfo.ByteOrderDefault.rawValue | CGImageAlphaInfo.PremultipliedLast.rawValue).rawValue)
        
        let imageRef = CGBitmapContextCreateImage(context)
        
        free(outData)
        
        return imageRef
    }
}
