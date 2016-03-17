//
//  AlertExchangeProtocol.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/16.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit

protocol AlertExchangeProtocol{
    
    func showExchange()
}

extension AlertExchangeProtocol where Self:UIViewController{
    
    func showExchange(){
        
        print("this is show exchange")
        
        let picker = UIDatePicker()
        picker.datePickerMode = .Date
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle:.ActionSheet)
        let ok = UIAlertAction(title: "ok", style: .Default) { (alertAction) -> Void in
            
            print("select data is \(picker.date)")
        }
        alert.view.addSubview(picker)
        alert.addAction(ok)
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true) { () -> Void in
            print("is end")
        }
        
    }
}