//
//  UIImage+transform.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/17.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation

extension UIImage{
    
    func transformWidth(width:Int,height:Int)->UIImage{
        
        let destW = width;
        let destH = height;
        let sourceW = width;
        let sourceH = height;
        
        let imageRef = self.CGImage;
        let bitmap = CGBitmapContextCreate(nil,
            destW,
            destH,
            CGImageGetBitsPerComponent(imageRef),
            4*destW,
            CGImageGetColorSpace(imageRef),
            ((2 << 12) | 2));
        
        CGContextDrawImage(bitmap, CGRect(x: 0, y: 0, width: sourceW, height: sourceH), imageRef);
        
        let ref = CGBitmapContextCreateImage(bitmap);
        let resultImage = UIImage(CGImage: ref!)
//        CGContextRelease(bitmap);
//        CGImageRelease(ref);
        
        return resultImage;
    }
}