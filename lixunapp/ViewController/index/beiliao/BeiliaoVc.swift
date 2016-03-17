//
//  BeiliaoVc.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit

class BeiliaoVc: BaseVc,AlertProtocol,MLKMenuPopoverDelegate,IndexTableViewDelegate,PresentProtocol {
    // MARK: - 属性
    let tableView = IndexTableView(frame: CGRectMake(0, CGFloat(Constants.Measure.top), Constants.App.screenWidth, Constants.App.screenHeight - 215..),type:IndexTableViewType.IndexTableViewTypeBeiliao)
    
    // MARK: - 生命周期
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.clipsToBounds = false
    }
    
    override func viewDidLoad() {
        self.title = "备料"
        self.setupView()
        self.tableView.requestData()
    }
    
    func setupView(){
        self.view.backgroundColor = Constants.Color.navColor
        self.navigationController?.navigationBar.clipsToBounds = true
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        //右上角按钮
        let rightBarButtonItem_Add = UIBarButtonItem(image: UIImage(named: "bl_add"), style: .Plain, target: self, action: "rightBarButtonItem_AddAction:");
        let rightBarButtonItem_Search = UIBarButtonItem(image: UIImage(named: "bl_search"), style:.Plain, target: self, action: "rightBarButtonItem_SearchAction:")
        self.navigationItem.rightBarButtonItems = [rightBarButtonItem_Add,rightBarButtonItem_Search]
    }
    
    
    // MARK: - 右上角点击事件
    func rightBarButtonItem_AddAction(barItem:UIBarButtonItem){
        print("添加")
        let menu:MLKMenuPopover = MLKMenuPopover(frame: CGRectMake(Constants.App.screenWidth - 250.., CGFloat(Constants.Measure.top)-11, 230.., 200..), menuItems: ["发料","流程"],images:["bl_faliao","bl_liucheng"])
        menu.menuPopoverDelegate = self
        menu.showInView(UIApplication.sharedApplication().keyWindow)
    }
    
    func rightBarButtonItem_SearchAction(barItem:UIBarButtonItem){
        print("查找")
        self.pushNext(XianbieQueryVc())
    }
    
    // MARK: - 右上角点击回调
    func menuPopover(menuPopover: MLKMenuPopover!, didSelectMenuItemAtIndex selectedIndex: Int) {
        switch(selectedIndex){
        case 0:
            self.pushNext(FaliaoVc())
        case 1:
            self.pushNext(WebVc())
            print("流程");
        default:
            print("no selected")
        }
    }
    
    // MARK: - IndexTableViewDelegate
    func IndexTableViewCellLeftSilde(type: swipeLeftButtonType, indexPath: NSIndexPath, model: FatFeed){
        print("title:\(type),index:\(indexPath)")
        switch(type){
        case .swipeLeftButtonTypeEidt:
            self.swipe_edit(indexPath, model: model)
        case .swipeLeftButtonTypeCancle:
            self.swipe_cancle(indexPath, model: model)
        case .swipeLeftButtonTypeBeiliao:
            self.swipe_beiliao(indexPath, model: model)
        }
    }
    //编辑
    func swipe_edit(index:NSIndexPath,model:FatFeed){
        showAlertWithTextField("编辑", buttons: ["确定","取消"],  text: model.sfs05) {[unowned self] (title, txt) -> Void in
            print("title:\(title);txt:\(txt)")
            guard let user = DataHelper.getUser() else{
                
                return
            }
            if title == "确定"{
                let form = WSFormConfirm(sourceFormNum1: model.sfs01,cnt1: String(model.sfs02),number1:txt)
                let issue = WSCreateFormAppissue(plantID: user.CompanyCodeSel!, profitID: model.sfpud06, type: FormType.UPDATE.rawValue, id: user.empCode!, num: "1",form: [form])
                
                self.invoke(issue){
                    res in
                    
                    if res{
                        self.tableView.tableView?.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Automatic)
                    }
                    
                    print("result is \(res)")
                    
                }
                
            }
        }
    }
    //取消备料
    func swipe_cancle(index:NSIndexPath,model:FatFeed){
        guard let user = DataHelper.getUser() else{
            
            return
        }
        
        let form = WSFormConfirm(sourceFormNum1: model.sfs01,cnt1: String(model.sfs02),number1:model.sfs05)
        let issue = WSCreateFormAppissue(plantID: user.CompanyCodeSel!, profitID: model.sfpud06, type: FormType.CANCEL.rawValue, id: user.empCode!, num: model.sfs05!,form: [form])
        
        invoke(issue){
            
            res in
            
            if res{
                self.tableView.tableView?.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
            
            print("result is \(res)")
        }
    }
    
    func invoke(req:WebserviceProtocol,finishClosure:((result:Bool)->())={_ in }){
        
        self.pp_hudShow(self.view)
        
        HttpHelper.invokeWebService(req, completionHandler: { [weak self](result) -> Void in
            
            self?.pp_hudHide((self?.view)!)
            
            switch result{
            case let .Success(value):
                self?.showAlert("提示", message: "操作结果:\(value)")
                let res = HttpHelper.SUCCESS == value
                finishClosure(result: res)
                
            case let .Failure(err):
                self?.showAlert("出错了", message: "\(err.userInfo)")
                finishClosure(result: false)
            }
            
        })
    }
    //备料
    func swipe_beiliao(index:NSIndexPath,model:FatFeed){
        
        guard let user = DataHelper.getUser() else{
            
            return
        }
        
        let form = WSFormConfirm(sourceFormNum1: model.sfs01,cnt1: String(model.sfs02),number1:model.sfs05)
        let issue = WSCreateFormAppissue(plantID: user.CompanyCodeSel!, profitID: model.sfpud06, type: FormType.CONFIRM.rawValue, id: user.empCode!, num: model.sfs05!,form: [form])
        
        invoke(issue){
            
            res in
            
            if res{
                self.tableView.tableView?.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
            
            print("result is \(res)")
        }
    }
}
