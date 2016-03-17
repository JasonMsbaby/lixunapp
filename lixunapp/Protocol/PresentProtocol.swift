//
//  PresentProtocol.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import MBProgressHUD

protocol PresentProtocol{
    // 增加边框
    func pp_border(v:UIView)
    
    func pp_lineV(color:UIColor) -> UIView
    // 文字框
    func pp_textF(placeholder:String?,imgStr:String,tag:Int) -> UITextField
    // 显示等待框
    func pp_hudShow(addToView:UIView,animated:Bool)
    // 隐藏等待框
    func pp_hudHide(addToView:UIView,animated:Bool)
}

extension PresentProtocol{
    
    func pp_hudShow(addToView:UIView,animated:Bool=true){
        
        MBProgressHUD.showHUDAddedTo(addToView, animated: animated)
    }
    
    func pp_hudHide(addToView:UIView,animated:Bool=true){
    
        MBProgressHUD.hideAllHUDsForView(addToView, animated: animated)
    }
    
    func pp_border(v:UIView){
        
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    func pp_lineV(color:UIColor = Constants.Color.lineDefault) -> UIView{
        
        let v = UIView()
        v.backgroundColor = color
        return v
    }
    
    func pp_textF(placeholder:String?,imgStr:String,tag:Int = 0) -> UITextField{
        
        let xianbieF = UITextField()
        
        let imgV = UIImageView(image: UIImage(named: imgStr))
        imgV.contentMode = .ScaleAspectFit
        xianbieF.addSubview(imgV)
        imgV.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(xianbieF).offset(20..)
            make.width.equalTo(60..)
            make.centerY.equalTo(xianbieF)
        }
        
        xianbieF.leftView = UIView()
        xianbieF.leftView?.bounds = CGRect(x: 0, y: 0, width: 144.., height: 20)
        xianbieF.leftViewMode = .Always
        xianbieF.placeholder = placeholder
        xianbieF.tag = tag
        xianbieF.font = Constants.Font.f21
        xianbieF.clearButtonMode = .WhileEditing
        
        let line = pp_lineV()
        xianbieF.addSubview(line)
        line.snp_makeConstraints { (make) -> Void in
            make.bottom.left.right.equalTo(xianbieF)
            make.height.equalTo(1)
        }
        
        return xianbieF
    }
}