//
//  Helper.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/10.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit

struct Helper {
    
    static func label(font:UIFont,text:String?=nil,textColor:UIColor?=nil)->UILabel{
        
        let l = UILabel.init()
        l.backgroundColor = UIColor.clearColor()
        l.font = font
        l.text = text
        l.textColor = textColor
        
        return l
    }
    
    static func label(size:CGFloat,text:String?=nil,textColor:UIColor?=nil)->UILabel{
        
        return label(Constants.Font.common(size), text: text, textColor: textColor)
    }
}
