//
//  CheckLoginProtocol.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/15.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit

protocol CheckLoginProtocol{

    func doAfterLogin(afterLogin:(()->())?)
}

extension CheckLoginProtocol{
    
    func doAfterLogin(afterLogin:(()->())?={}){
        
        func didAfter(){
            
            if let afterHandler = afterLogin{
                
                afterHandler()
            }
        }
        
        if(DataHelper.isLogin()){
            
            didAfter()
            return
        }
        
        print("user is not login")
        
        if let vc = self as? UIViewController{
            
            let loginVc = LoginVc()
            let navVc = UINavigationController(rootViewController: loginVc)
            loginVc.afterLogin = afterLogin
            navVc.hidesBottomBarWhenPushed = true
            vc.navigationController?.presentViewController(navVc, animated: true, completion: nil)
        }
        
    }
}