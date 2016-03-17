//
//  IndexM.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation

enum IndexCellType:Int{
    
    case None=0,Beiliao = 1,Faliao,Zafa
    
    func info() -> (name:String,img:String){
        
        var info:(String,String) = ("unkonwn","unkonwn")
        
        switch self{
            
        case .Beiliao:
            info = ("备料","idx_beiliao")
        case .Faliao:
            info = ("发料","idx_faliao")
        case .Zafa:
            info = ("杂发","idx_zafa")
        case .None:
            info = ("","")
        }
        
        return info
    }
    
}

struct IndexM {
    // 名称
    var title:String
    // 图片
    var img:String?
    // 是否可见
    var visible:Bool = true
    
    var lines:[BorderLine]
    
    var type:IndexCellType{
        didSet{
            self.title = type.info().name
            self.img = type.info().img
        }
    }
    
    init(cellType:IndexCellType,visible:Bool = true,lines:[BorderLine]=[]){
        
        self.type = cellType
        self.title = type.info().name
        self.img = type.info().img
        self.visible = visible
        self.lines = lines
    }
    
}