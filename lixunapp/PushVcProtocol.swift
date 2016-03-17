//
//  Protocol.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit

protocol PushVcProtocol{
    
    func pushNext(vc:UIViewController,animated:Bool)
}

extension PushVcProtocol where Self:UIViewController{
    
    func pushNext(vc:UIViewController,animated:Bool = true){
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    
}