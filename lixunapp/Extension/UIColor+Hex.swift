//
//  UIColor+Hex.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    convenience init(hex: UInt32,alpha:Double = 1) {
        
        self.init(red: CGFloat(hex >> UInt32(16)) / 255.0,
            green: CGFloat((hex >> UInt32(8)) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF)/255.0,
            alpha: 1)
    }
}