//
//  AlertProtocol.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit

protocol AlertProtocol{
    
    func showAlert(title:String?,message:String?,button:String)
}

extension AlertProtocol where Self:UIViewController {
    
    func showAlert(title: String? = "提示", message: String? = "You tapped it. Good work.", button: String = "确认") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: button, style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func showSheet(title: String? = nil, message: String? = "You tapped it. Good work.", button: String = "Thanks"){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alert.addAction(UIAlertAction(title: title, style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
        }))
    }
    
    // MARK: - 弹出带文本框的弹出层
    func showAlertWithTextField(title: String? = nil, message: String? = "", buttons: NSArray,placeholder:String? = "",text:String? = "",callback:(title:String,txt:String)->Void){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (txt) -> Void in
            txt.placeholder = placeholder
            txt.layer.cornerRadius = 3
            txt.clipsToBounds = true
            txt.text = text
            txt.font = Constants.Font.f24
        }
        for button in buttons{
            alert.addAction(UIAlertAction(title: String(button), style: .Default, handler: { (action) -> Void in
                let txt:UITextField = alert.textFields![0]
                callback(title: action.title!,txt: txt.text!)
            }))
        }
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
//    func showActionSheet(title:String,cancleButtonTitle:String? = "取消",destructiveButtonTitle:String? = "确定",otherButtonTitles:String ...){
//        let sheet:UIActionSheet = UIActionSheet(title: title, delegate:Self, cancelButtonTitle: cancleButtonTitle, destructiveButtonTitle: destructiveButtonTitle,otherButtonTitles: otherButtonTitles);
//        sheet.showInView(self.view)
//    }
    
    
    
}