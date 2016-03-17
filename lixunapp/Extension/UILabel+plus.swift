//
//  UILabel+plus.swift
//  lixunapp
//
//  Created by Jason_Msbaby on 16/3/10.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit

extension UILabel{
    
    func appendAttr(text:String,font:UIFont?=nil,color:UIColor?=nil) -> UILabel{
        
        let arrStr = NSMutableAttributedString()
        
        if let odd = self.attributedText {
            arrStr.appendAttributedString(odd)
        }
    
            
            let lbl_str:NSMutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString.init(string: text))
            if let a = font {
                lbl_str.addAttribute(NSFontAttributeName, value: a, range: NSMakeRange(0, lbl_str.length))
            }
        
            if let b = color {
                lbl_str.addAttribute(NSForegroundColorAttributeName, value: b, range: NSMakeRange(0, lbl_str.length))
            }
            arrStr.appendAttributedString(lbl_str)
        
        
        self.attributedText = arrStr
        
        return self
    }
}