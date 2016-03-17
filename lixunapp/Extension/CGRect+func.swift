//
//  CGRect+func.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit

func +(lhs:CGRect,rhs:CGRect) -> CGRect{
    
    return CGRect(x: lhs.origin.x + rhs.origin.x, y: lhs.origin.y + rhs.origin.y, width: lhs.size.width + rhs.size.width, height: lhs.size.height + rhs.size.height)
}