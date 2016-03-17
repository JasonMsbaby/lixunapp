//
//  BaseVc.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit

class BaseVc: UIViewController,PushVcProtocol{
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = Constants.Color.defaultBg
        // 设置非自动计算scrollview的位置
        self.automaticallyAdjustsScrollViewInsets = false;
    }
}
