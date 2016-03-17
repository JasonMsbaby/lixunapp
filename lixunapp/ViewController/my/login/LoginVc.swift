//
//  Login.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/15.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit
import SnapKit

class LoginVc:BaseVc,PresentProtocol,UITextFieldDelegate,CmitBtnProtocol,AlertProtocol{
    
    var nameF:UITextField!
    var pwdF:UITextField!
    var cmitBtn:UIButton!
    var activiteF:UITextField?
    var afterLogin:(()->())?

    override func viewDidLoad(){
    
        super.viewDidLoad()
        self.title = "登录"
        setupViews()
    }
    
    private func setupViews(){
    
        let logoV = UIImageView(image: UIImage(named: "comm_logo"))
        logoV.contentMode = .ScaleAspectFit
        self.view.addSubview(logoV)
        
        logoV.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(CGFloat(Constants.Measure.top)+200..)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSize(width: 816.., height: 186..))
        }
        
        nameF = createTextF("账号",imgStr: "comm_user",tag: Constants.Tag.name)
        self.view.addSubview(nameF)
        nameF.returnKeyType = .Next
        
        nameF.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(logoV.snp_bottom).offset(316..)
            make.height.equalTo(140..)
            make.centerX.equalTo(self.view)
            make.width.equalTo(736..)
        }
        
        pwdF = createTextF("密码",imgStr:"comm_pwd",tag: Constants.Tag.pwd)
        self.view.addSubview(pwdF)
        pwdF.secureTextEntry = true
        
        pwdF.snp_makeConstraints { (make) -> Void in
            make.left.right.height.equalTo(nameF)
            make.top.equalTo(nameF.snp_bottom)
        }
        
        cmitBtn = createCmitBtn("登录",tag: Constants.Tag.login)
        self.view.addSubview(cmitBtn)
        
        cmitBtn.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(1000..)
            make.centerX.equalTo(self.view)
            make.height.equalTo(100..)
            make.top.equalTo(pwdF.snp_bottom).offset(200..)
        }
        
        addBgTap()
        
    }
    
    private func addBgTap(){
        
        let tap = UITapGestureRecognizer(target: self, action: "gestureAction:")
        self.view.addGestureRecognizer(tap)
    }
    
    func gestureAction(gest:UITapGestureRecognizer){
        
        activiteF?.resignFirstResponder()
    }
    
    private func createTextF(placeHolder:String?,imgStr:String,tag:Int=0)->UITextField{
        
        let textF = pp_textF(placeHolder, imgStr: imgStr,tag: tag)
        textF.delegate = self
        return textF
    }
    
    func clickCmitBtn(sender: UIButton) {
        
        guard let empCode = nameF.text where empCode != "" else{
            
            showAlert("提示", message: "请填写用户名")
            return
        }
        
        guard let pwd = pwdF.text where pwd != "" else{
            
            showAlert("提示", message: "请填写密码")
            return
        }
        
        activiteF?.resignFirstResponder()
        
        pp_hudShow(self.view)
        
        let req = GetLoginSessionReq()
        req.empCode = empCode
        req.pwd = pwd
        
        HttpHelper.invokeJson(req) {[unowned self] (result) -> Void in
            
            self.pp_hudHide(self.view)
            switch result{
                
            case let .Success(value):
                let resp = GetLoginSessionResp(string: value,error: nil)
                self.handlerLogin(resp,pwd: pwd)
                
            case let .Failure(err):
                
                self.showAlert("出错啦",message: "\(err)")
            }
        }
        
    }
    
    private func handlerLogin(resp:GetLoginSessionResp?,pwd:String){
        
        if (resp == nil || !resp!.IsSuccess){
            let msg = resp!.ErrMsg ?? "未知错误"
            showAlert("登录失败", message: "\(msg)")
            return;
        }
        
        let user = DataUser(empCode: resp?.AppSession?.EmpCode, pwd: pwd)
        if let appSession = resp?.AppSession {
            user.CompanyCode = appSession.CompanyCode
            user.EmpName = appSession.EmpName
            user.CompanyName = appSession.CompanyName
            user.Profit = appSession.Profit
            user.EnglishName = appSession.EnglishName
            user.Gender = appSession.Gender
            user.Birthday = appSession.Birthday
            user.Email = appSession.Email
            user.Telephone = appSession.Telephone
            user.DeptCode = appSession.DeptCode
            user.DeptName = appSession.DeptName
            user.SalaryLevel = appSession.SalaryLevel
            user.CompanyCodeSel = user.CompanyCode
            user.ProfitSel = user.Profit
        }
        
        DataHelper.saveUser(user)
        
        self.dismissViewControllerAnimated(true, completion: afterLogin)
    }
    
    //MARK text filed delegate
    func textFieldDidBeginEditing(textField: UITextField) {
        
        self.activiteF = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if(activiteF == textField){
            
            activiteF = nil
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if(activiteF == textField){
            
            if textField.tag == Constants.Tag.name{
                
                pwdF.becomeFirstResponder()
            } else if textField.tag == Constants.Tag.pwd{
                
                textField.resignFirstResponder()
            }
        }
        
        return true
    }
    
}