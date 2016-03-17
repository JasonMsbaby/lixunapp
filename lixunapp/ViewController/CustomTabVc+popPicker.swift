//
//  CustomTabVc+popPicker.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/16.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit

extension CustomTabVc:UIPickerViewDataSource,PresentProtocol,UIPickerViewDelegate{
    
    func showExchange(){
        
        print("this is show exchange")
        
        queryProfitList()
        
    }
    
    func showHasData(){
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.showsSelectionIndicator = true
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle:.ActionSheet)
        let ok = UIAlertAction(title: "确认", style: .Default) {[unowned self] (alertAction) -> Void in
            
            if let showBean = self.profitArray?.array[picker.selectedRowInComponent(0)]{
                
                let selCom = showBean.name
                let selProfit = showBean.profits[picker.selectedRowInComponent(1)].Profit
                
                guard let user = DataHelper.getUser() else{
                    
                    self.showAlert(message:"用户未登录，请重新登录")
                    return;
                }
                
                user.CompanyCodeSel = selCom
                user.ProfitSel = selProfit
                
                DataHelper.saveUser(user)
            }
            
        }
        alert.view.addSubview(picker)
        alert.addAction(ok)
        
        alert.popoverPresentationController?.permittedArrowDirections = .Up
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 3.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true) { [weak self]() -> Void in
            
            self?.changeToOldSelect(picker)
        }
    }
    
    private func changeToOldSelect(picker:UIPickerView){
        
        guard let array = profitArray else{
            
            return
        }
        
        guard let user = DataHelper.getUser() else{
            
            return
        }
        
        guard let selCom = user.CompanyCodeSel else{
            
            return
        }
        
        let (showBean,index) = array[selCom]
        
        guard let bean = showBean else{
            
            return
        }
        
        picker.selectRow(index, inComponent: 0, animated: false)
        picker.reloadComponent(1)
        // find 2 row
        for i in 0..<bean.profits.count{
            
            if (bean.profits[i].Profit == user.ProfitSel){
                
                picker.selectRow(i, inComponent: 1, animated: false)
                break;
            }
        }
        
    }
    
    func handlerData(data:[GetProfitListBean]){
        
        var beanArray = ProfitShowBeanArray(array: [])
        
        data.forEach {
            
            beanArray.addProfit($0)
        }
        
        profitArray = beanArray
    }
    
    private func queryProfitList(){
        
        let req = GetProfitListReq()
        
        pp_hudShow(self.view)
        
        if let user = DataHelper.getUser(){
            
            req.empCode = user.empCode!
            
            HttpHelper.invokeJson(req){[unowned self] (result) -> Void in
                
                self.pp_hudHide(self.view)
                
                switch result{
                    
                case let .Success(value):
                    
                    let array = try? GetProfitListBean.arrayOfModelsFromString(value)
                    self.doReceiveResp(array)
                    
                case let .Failure(err):
                    
                    self.showAlert(message:"获取利润中心失败\(err)")
                }
            }
        }
    }
    
    private func doReceiveResp(array:NSMutableArray?){
        
        guard (array != nil) else{
            
            self.showAlert(message:"获取利润中心失败，转换失败")
            return
        }
        
        var data:[GetProfitListBean] = []
        
        for obj in array! {
            
            if let oo = obj as? GetProfitListBean{
                
                data.append(oo)
            }
        }
        
        handlerData(data)
        showHasData()
    }
    
    func findTitleFromPickerView(pickerView: UIPickerView,row: Int, forComponent component: Int)->String?{
    
        let arrayIndex = component == 0 ? row : pickerView.selectedRowInComponent(0)
        
        let showBean = profitArray?.array[arrayIndex]
        
        if(component == 0){
            
            return showBean?.name
        } else if(component == 1){
            
            return showBean?.profits[row].Name
        }
        
        return "title \(row) \(component)"
    }
    
    //MARK picker view delegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(component == 0){
            
            return profitArray?.array.count ?? 0
        }
        
        if(component == 1){
            
            let showBean = profitArray?.array[pickerView.selectedRowInComponent(0)]
            let count = showBean?.profits.count ?? 0
//            print("name:\(showBean?.name) count \(count)")
            return count
        }
        
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(component == 0){
            
            pickerView.reloadComponent(1)
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        if(component == 0){
            
            return 110
        }
        
        return 210
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        guard let string = findTitleFromPickerView(pickerView, row: row, forComponent: component) else{
            
            return nil
        }
        let attr = NSAttributedString(string: string, attributes: [NSFontAttributeName:Constants.Font.f18,NSForegroundColorAttributeName:Constants.Color.fontLight])
        return attr
    }
}