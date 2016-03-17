//
//  PersonInfoHeader.swift
//  lixunapp
//
//  Created by Jason_Msbaby on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit
import SnapKit
class PersonInfoHeader: UIView {
    // MARK: - 属性
    var model:PersonInfoM!
        {
        didSet(newModel){
            layoutModel()
        }
    }
    let width = Constants.App.screenWidth
    
    var img_head:UIImageView = UIImageView()
    var txt_name:UILabel = UILabel()
    var txt_compony:UILabel = UILabel()
    var txt_depart:UILabel = UILabel()
    var txt_job:UILabel = UILabel()
    var txt_joinTime:UILabel = UILabel()
    var txt_origin:UILabel = UILabel()
    
    // MARK: - 生命周期
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        let currentUser:DataUser = DataHelper.getUser()!
        addSubview(img_head)
        //头像
        img_head.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(150..)
            make.width.height.equalTo(356..)
            make.top.equalTo(self).offset(100..)
        }
        self.layoutIfNeeded()
        img_head.layer.cornerRadius = img_head.bounds.size.width/2;
        img_head.clipsToBounds = true
        img_head.sd_setImageWithURL(NSURL(string: currentUser.HeadImg))
        //用户名
        addSubview(txt_name)
        txt_name.snp_makeConstraints { (make) -> Void in
            make.centerX.width.equalTo(img_head)
            make.top.equalTo(img_head.snp_bottom).offset(40..)
            make.height.equalTo(60..)
        }
        txt_name.textAlignment = .Center
        txt_name.font = Constants.Font.f24
        txt_name.text = currentUser.EmpName
        
        
        
        
        //右侧框架view
        let body:UIView = UIView()
        addSubview(body)
        body.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(130..)
            make.left.equalTo(self).offset(792..)
            make.size.equalTo(self).dividedBy(2);
        }
        
        
        var preL:UILabel?
        
        for(var i = 0; i < 4; i++){
            let info:UILabel = UILabel()
            body.addSubview(info)
            info.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.equalTo(body)
                if preL == nil{
                     make.top.equalTo(body).offset(0)
                } else{
                    make.top.equalTo(preL!.snp_bottom).offset(32..)
                }
            })
            
            info.appendAttr("运营单位:",font: Constants.Font.f22,color: Constants.Color.fontDeep)
                .appendAttr("立讯精密",font: Constants.Font.f20,color: Constants.Color.fontLight)
            info.textAlignment = .Left
            
            preL = info
            
        }
    }
    
    // MARK: - 加载数据
    func layoutModel(){
        
    }
    
}
