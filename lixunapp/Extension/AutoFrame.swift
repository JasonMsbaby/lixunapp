//
//  AutoFrame.swift
//  lixunapp
//
//  Created by Jason_Msbaby on 16/3/11.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit

postfix operator .. {
}

postfix func ..(lhs:CGFloat)->CGFloat{
    
    return lhs * AutoFrame.scaleBonus
}

postfix func ..(lhs:Int)->CGFloat{
    
    return CGFloat(lhs) * AutoFrame.scaleBonus
}

struct AutoFrame {
    
    static let scaleBonus:CGFloat = {
        
        let width = UIScreen.mainScreen().bounds.size.width
        var result = width / 1536
        result = floor(result * 100)/100
        return result
    }()
}


