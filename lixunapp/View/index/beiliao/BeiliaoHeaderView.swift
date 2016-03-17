//
//  BeiliaoHeaderView.swift
//  lixunapp
//
//  Created by Jason_Msbaby on 16/3/15.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit

class BeiliaoHeaderView: UIView {
    // MARK: - 属性
    private let containView:UIView = UIView()
    let lbl_xianbie:UILabel = UILabel()
    let lbl_name:UILabel = UILabel()
    let img_head = UIImageView()
    let lbl_number = UILabel()
    var model:FatFeed?{
        didSet{
//            self.setupData()
        }
    }
    // MARK: - 方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = Constants.Color.navColor
        self.addSubview(self.containView)
        self.containView.backgroundColor = Constants.Color.white
        self.containView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(20..)
            make.right.equalTo(self).offset(-200..)
            make.bottom.equalTo(self)
            make.top.equalTo(self)
        }
        
        let left:UIImageView  = UIImageView()
        self.containView.addSubview(left)
        left.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.containView).offset(56..)
            make.left.equalTo(self.containView).offset(40..)
            make.size.equalTo(CGSizeMake(70.., 90..))
        }
        left.image = UIImage(named: "bl_xianbie")
        //线别
        self.containView.addSubview(self.lbl_xianbie)
        self.lbl_xianbie.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.containView).offset(68..)
            make.left.equalTo(left.snp_right).offset(80..)
        }
        self.lbl_xianbie.text = "线别"
        self.lbl_xianbie.font = Constants.Font.f36
        self.lbl_xianbie.textColor = Constants.Color.fontDeep
        
        //
        self.containView.addSubview(self.lbl_name)
        self.lbl_name.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.lbl_xianbie.snp_right).offset(50..)
            make.top.equalTo(self.containView).offset(100..)
        }
        self.lbl_name.font = Constants.Font.f18
        self.lbl_name.textColor = Constants.Color.fontLight
        self.lbl_name.appendAttr("线别/厂商    ")
        .appendAttr("名称    ")
        .appendAttr("目的工厂线别")
        //右侧头像
        let rightView = UIView()
        self.containView.addSubview(rightView)
        rightView.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.containView)
            make.right.equalTo(self).offset(-20..)
            make.width.equalTo(448..)
        }
        rightView.backgroundColor = Constants.Color.orange
        rightView.layer.cornerRadius = 100..
        rightView.clipsToBounds = true
        //头像
        rightView.addSubview(img_head)
        self.img_head.snp_makeConstraints { (make) -> Void in
            make.top.bottom.right.equalTo(rightView)
            make.width.equalTo(200..)
        }
        img_head.layer.cornerRadius = (200..)/2
        img_head.clipsToBounds = true
        img_head.sd_setImageWithURL(NSURL(string: Constants.Config.img_demo))
        //数量
        rightView.addSubview(lbl_number)
        lbl_number.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(rightView).offset(72..)
            make.centerY.equalTo(rightView)
        }
        lbl_number.appendAttr("1", font: Constants.Font.f40, color: Constants.Color.red)
        .appendAttr("/6", font: Constants.Font.f40, color: Constants.Color.fontDeep)
    }
    
//    func setupData(){
//        self.lbl_xianbie.text = model?.tc_imc02
//        self.lbl_name.appendAttr((model?.sfp07)!+"     ")
//        .appendAttr(" ")
//        .appendAttr((model?.sfpud15)!)
//        lbl_number.appendAttr(model, font: Constants.Font.f40, color: Constants.Color.red)
//            .appendAttr("/"+model., font: Constants.Font.f40, color: Constants.Color.fontDeep)
//    }

}
