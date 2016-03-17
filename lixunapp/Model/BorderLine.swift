//
//  BorderLine.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation

func | (lhs:BorderLine,rhs:BorderLine) -> Int{
    
    return lhs.rawValue | rhs.rawValue
}

func | (lhs:Int,rhs:BorderLine) -> Int{
    
    return lhs | rhs.rawValue
}

func hasBorderLine(value:Int) -> [BorderLine]{
    
    let all:[BorderLine] = [.left,.top,.bottom,.right]
    var result:[BorderLine] = []
    
    all.forEach{
        
        if(value & $0.rawValue > 0){
            result.append($0)
        }
    }
    
    return result
}

// 计算有哪些线，当前index 0 开始 total 总共  rowcell 每行几个
func hasBorderLine(index:Int,total:Int,rowCell:Int) -> [BorderLine]{
    
    var lines:[BorderLine] = []
    // top
    if(index < rowCell){
        lines.append(BorderLine.top)
    }
    // left
    if(index % rowCell == 0){
        lines.append(BorderLine.left)
    }
    // right
    lines.append(BorderLine.right)
    // bottom
    lines.append(BorderLine.bottom)
    
    return lines
}

enum BorderLine:Int,CustomStringConvertible{
    
    case top = 0b1,right = 0b10,bottom = 0b100,left = 0b1000
    
    var description:String{
        
        switch self{
            
        case .top:
            return "top"
        case .right:
            return "right"
        case .bottom:
            return "bottom"
        case .left:
            return "left"
        }
    }
}