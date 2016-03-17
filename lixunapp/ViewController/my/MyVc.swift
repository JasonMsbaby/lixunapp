//
//  MyVc.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//
import SDWebImage
import Foundation
import UIKit
import SnapKit

class MyVc: BaseVc,UIActionSheetDelegate,AlertProtocol,CheckLoginProtocol,QrCodeProtocol{
    
    var img_head:UIImageView = UIImageView()
    var txt_username:UILabel = UILabel()
    var currentUser:DataUser?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.Str.my
        currentUser = DataHelper.getUser()
        setupViews()
    }

    // MARK: - 加载视图
    private func setupViews(){
        self.view.backgroundColor = Constants.Color.defaultBg
        //头像
        self.view.addSubview(img_head)
        img_head.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset((100..)+64)
            make.width.height.equalTo(356..)
            make.centerX.equalTo(self.view)
        }
        img_head.layer.cornerRadius = (356..)/2
        img_head.clipsToBounds = true
        img_head.sd_setImageWithURL(NSURL(string: (self.currentUser?.HeadImg)!))
        
        //用户名
        self.view.addSubview(txt_username)
        txt_username.snp_makeConstraints { (make) -> Void in
            make.centerX.width.equalTo(img_head)
            make.top.equalTo(img_head.snp_bottom).offset(64..)
        }
        txt_username.textAlignment = .Center
        txt_username.text = self.currentUser?.EmpName
        txt_username.font = Constants.Font.f24
        txt_username.textColor = Constants.Color.fontLight
        
        
       //查看个人详情
        let btn_info = UIButton()
        self.view.addSubview(btn_info)
        
        btn_info.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 1000.., height: 90..))
            make.centerX.equalTo(self.view)
            make.top.equalTo(txt_username).offset(244..)
        }
        btn_info.setTitle("个人资料", forState: .Normal)
        btn_info.addTarget(self, action: "btn_info_action", forControlEvents: .TouchUpInside)
        
        btn_info.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn_info.titleLabel?.font = Constants.Font.f22
        btn_info.layer.cornerRadius = 20..
        btn_info.clipsToBounds = true
        btn_info.backgroundColor = Constants.Color.buttonOrigin
        
        //查看岗位详情
        let btn_jobDetail:UIButton = UIButton()
        self.view.addSubview(btn_jobDetail)
        btn_jobDetail.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(btn_info.snp_bottom).offset(100..)
            make.left.right.height.equalTo(btn_info)
        }
        btn_jobDetail.setTitle("岗位说明", forState: .Normal)
        btn_jobDetail.addTarget(self, action: "btn_jobDetail_action", forControlEvents: .TouchUpInside)
        
        btn_jobDetail.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn_jobDetail.titleLabel?.font = Constants.Font.f22
        btn_jobDetail.layer.cornerRadius = 20..
        btn_jobDetail.clipsToBounds = true
        btn_jobDetail.backgroundColor = Constants.Color.buttonOrigin
        
        //退出登录
        let btn_exit:UIButton = UIButton(type: .System)
        self.view.addSubview(btn_exit)
        btn_exit.snp_makeConstraints { (make) -> Void in
            make.left.right.height.equalTo(btn_jobDetail)
            make.top.equalTo(btn_jobDetail.snp_bottom).offset(250..)
        }
        btn_exit.setTitle("退出登录", forState: .Normal)
        btn_exit.setTitleColor(Constants.Color.red, forState: .Normal)
        btn_exit.layer.backgroundColor = Constants.Color.white.CGColor
        btn_exit.titleLabel?.font = Constants.Font.f24
        btn_exit.layer.cornerRadius = 20..
        btn_exit.clipsToBounds = true
        btn_exit.addTarget(self, action: "exit_acount", forControlEvents: .TouchUpInside)
        
        //切换账号 临时用
//        let btn_changeAcount:UIButton = UIButton(type: .System)
//        self.view.addSubview(btn_changeAcount)
//        btn_changeAcount.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        btn_changeAcount.setTitle("切换账号", forState: .Normal)
//        btn_changeAcount.addTarget(self, action: "btn_changeAcount", forControlEvents: .TouchUpInside)
//        btn_changeAcount.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(btn_jobDetail.snp_bottom).offset(100..)
//            make.centerX.equalTo(self.view)
//        }
        //扫码
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "扫一扫", style: UIBarButtonItemStyle.Done, target: self, action: "scanCodeAction");
        
    }
    // MARK: - 退出账户
    func exit_acount(){
        let sheet:UIActionSheet = UIActionSheet(title: "是否退出登录", delegate:self , cancelButtonTitle: "取消", destructiveButtonTitle: "退出登录",otherButtonTitles: "取消");
        sheet.showInView(self.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        
        switch buttonIndex{
            
        case 0:
            DataHelper.delUser()
            doAfterLogin{
                print("this is after login")
            }
        default: break
            
        }
        
    }
    
    // MARK: - 扫一扫
    func scanCodeAction(){
        
        scanQrCode {[weak self] (str) -> () in
            self?.showAlert("二维码", message: "扫到二维码\(str)")
        }
    }
    
    
//    let pop:PopView  = PopView()
//    func btn_changeAcount(){
//        pop.dataSource = self
//        pop.show()
//    }
    // MARK: - 设置弹出视图的数据源
//    func popViewWithBottomView() -> UIView {
//        let v:UIView = UIView(frame: CGRectMake(0,0,self.view.bounds.width,200..))
//        v.backgroundColor = UIColor.whiteColor()
//        let btn:UIButton = UIButton(type: .Custom)
//        v.addSubview(btn)
//        btn.snp_makeConstraints { (make) -> Void in
//            make.center.equalTo(v)
//            make.width.height.equalTo(100..)
//        }
//        btn.addTarget(self, action: "changeAction", forControlEvents: .TouchUpInside)
//        btn.setImage(UIImage(named: "changeAcount"), forState: .Normal)
//        return v
//    }
//    func changeAction(){
//        pop.hidden()
//    }
    
    
    
    // MARK: - 点击事件
    /*!
    点击个人详情页面
    */
    func btn_info_action(){
        let personVc:PersonInfoVc = PersonInfoVc()
        pushNext(personVc)
        
    }
    /*!
    *  岗位说明
    */
    func btn_jobDetail_action(){
        let jobDetailVc:JobDetailVc = JobDetailVc()
        pushNext(jobDetailVc)
    }
}