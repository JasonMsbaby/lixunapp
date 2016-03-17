//
//  XianbieQueryVc.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class XianbieQueryVc: BaseVc,CmitBtnProtocol,AlertProtocol,UITextFieldDelegate,PresentProtocol,QrCodeProtocol {
    
    var activeF:UITextField?
    var xianbieF:UITextField?
    var headImgV:UIImageView?
    var empCodeF:UITextField?
    var mudiF:UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "查询"
        setupViews()
    }
    
    private func setupViews(){
        
        addheadImgV()
        
        addEmpCodeF()
        
        addXianbieF()
        
        addMudiF()
        
        addCmitBtn()
        
        addTapGest()
    }
    
    private func addMudiF(){
        
        mudiF = createTextF("目的线别", imgStr: Constants.imgStr.mudixianbie, tag: Constants.Tag.mudixianbie)
        self.view.addSubview(mudiF!)
        
        mudiF?.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(xianbieF!.snp_bottom)
            make.height.left.width.equalTo(empCodeF!)
        }
    }
    
    private func addEmpCodeF(){
        
        let user = DataHelper.getUser()
        let empCodeStr = user?.empCode ?? "工号"
        
        empCodeF = createTextF(empCodeStr, imgStr: Constants.imgStr.user, tag: Constants.Tag.empCode)
        self.view.addSubview(empCodeF!)
        empCodeF?.text = empCodeStr
        empCodeF?.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(headImgV!.snp_bottom).offset(160..)
            make.centerX.equalTo(self.view)
            make.height.equalTo(130..)
            make.left.equalTo(self.view).offset(350..)
        }
        
        let saoBtn = UIButton(type: .Custom)
        saoBtn.setImage(UIImage(named: Constants.imgStr.saoyisao), forState:.Normal)
        saoBtn.bounds = CGRectMake(0, 0, 48.., 130..)
        saoBtn.tag = Constants.Tag.saoyisao
        saoBtn.addTarget(self, action: "clickBtn:", forControlEvents: .TouchUpInside)
        
        empCodeF?.rightView = saoBtn
        empCodeF?.rightViewMode = .Always
        
    }
    
    
    
    private func addheadImgV(){
        
        self.headImgV = UIImageView()
        self.view.addSubview(headImgV!)
        
        headImgV?.snp_makeConstraints{ (make) -> Void in
            make.top.equalTo(self.view).offset(CGFloat(Constants.Measure.top) + 100..)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSize(width: 356.., height: 356..))
        }
        
        headImgV?.clipsToBounds = true
        headImgV?.layer.cornerRadius = (356/2)..
        headImgV?.contentMode = .ScaleAspectFit
        headImgV?.backgroundColor = Constants.Color.white
        
        guard let user = DataHelper.getUser() else{
            
            return;
        }
        
        headImgV?.sd_setImageWithURL(NSURL(string: user.HeadImg))
    }
    
    private func addTapGest(){
        
        let gest = UITapGestureRecognizer(target: self, action: "tapGesture:")
        self.view.addGestureRecognizer(gest)
    }
    
    func tapGesture(gest:UITapGestureRecognizer){
        
        activeF?.resignFirstResponder()
    }
    
    private func addXianbieF(){
        
        xianbieF = createTextF("线别", imgStr: Constants.imgStr.xianbie, tag: Constants.Tag.xianbie)
        self.view.addSubview(xianbieF!)
        
        xianbieF?.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(empCodeF!.snp_bottom)
            make.height.left.width.equalTo(empCodeF!)
        }
        
    }
    
    private func createTextF(placeholder:String?,imgStr:String,tag:Int = 0) -> UITextField{
        
        let xianbieF = pp_textF(placeholder, imgStr: imgStr, tag: tag)
        xianbieF.delegate = self
        
        return xianbieF
    }
    
    func addCmitBtn(){
        
        let btn = createCmitBtn("查询")
        self.view.addSubview(btn)
        btn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(mudiF!.snp_bottom).offset(170..)
            make.size.equalTo(CGSize(width: 1000.., height: 100..))
            make.centerX.equalTo(self.view)
        }
    }
    
    //MARK: this is click btn
    func clickCmitBtn(sender: UIButton) {
        
        //        print("add commit btn")
        showAlert("add commit btn")
    }
    
    //MARK: text field delegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        activeF = textField
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if activeF == textField {
            
            activeF = nil
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        activeF = nil
        return true
    }
    
    //MARK: click action
    func clickBtn(sender:UIButton){
        
        switch sender.tag{
            
        case Constants.Tag.saoyisao:
            
            scanQrCode({ (str) -> () in
                print("receive result is \(str)")
            })
            
        default:
            break;
        }
    }
}