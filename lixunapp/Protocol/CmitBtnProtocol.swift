//
//  CmitBtnProtocol.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit

protocol CmitBtnProtocol:class{
    
    func clickCmitBtn(sender:UIButton)
    
    func createCmitBtn(title:String,tag:Int)->UIButton
}

extension CmitBtnProtocol{
    
    func createCmitBtn(title:String,tag:Int=0)->UIButton{
        
        let btn = UIButton.init(frame: CGRect(x: 0, y: 0, width: Constants.App.screenWidth * 0.65, height: CGFloat(Constants.Measure.btnH)))
        btn.titleLabel?.font = Constants.Font.f24
        btn.addTarget(self, action: Selector("clickCmitBtn:"), forControlEvents:.TouchUpInside)
        btn.setTitle(title, forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.backgroundColor = Constants.Color.commitBtn
        btn.layer.cornerRadius = 20..
        
        return btn
    }
}

