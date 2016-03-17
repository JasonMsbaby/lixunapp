//
//  ChangeAcount.swift
//  lixunapp
//  从底部弹出视图公共基座view
//  Created by Jason_Msbaby on 16/3/11.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit
//弹出视图的数据源 设置被弹出的view
protocol PopViewDataSource{
    
    func popViewWithBottomView()->UIView
}

class PopView: UIView {
    
    var dataSource:PopViewDataSource?
    
    private var h:CGFloat?
    
    private var btmView:UIView?{
        didSet{
            h = self.btmView?.bounds.height
        }
    }
    
    // MARK: - 弹出页面
    func show(){
        self.setupView()
        if(btmView != nil){
            UIView.animateWithDuration(0.5, animations: {[unowned self] () -> Void in
                self.backgroundColor = self.backgroundColor?.colorWithAlphaComponent(0.5)
                self.btmView?.transform = CGAffineTransformMakeTranslation(0, -self.h!);
                })
        }else{
            print("Plase Make Sure Bottom View is Not nil!!!! dataSource <PopViewDataSource> to achieve the agreement can be")
        }
        
    }
    //隐藏页面
    func hidden(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.backgroundColor = self.backgroundColor?.colorWithAlphaComponent(0)
            self.btmView?.transform = CGAffineTransformMakeTranslation(0, self.h!)
            }) { (result) -> Void in
                self.removeFromSuperview();
        }
    }
    // MARK: - 添加轻拍手势
    func addTapGesture(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: "tapAction:")
        self.addGestureRecognizer(tap)
    }
    // MARK: - 轻拍手势出发
    func tapAction(let tap:UITapGestureRecognizer){
        let positionY = tap.locationInView(self).y
        if positionY < Constants.App.screenHeight - h!{
            self.hidden()
        }
    }
    
    // MARK: - 加载视图
    func setupView(){
        self.frame = Constants.App.mainBounds
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0)
        if dataSource != nil{
            self.btmView = self.dataSource?.popViewWithBottomView();
            if(btmView != nil){
                var frame:CGRect = (btmView?.frame)!;
                frame.origin.y = Constants.App.screenHeight;
                btmView?.frame = frame
            }
            self.addSubview(btmView!)
            UIApplication.sharedApplication().keyWindow?.addSubview(self)
            self.addTapGesture()
        }
        
    }
    
}
