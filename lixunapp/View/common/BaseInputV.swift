//
//  BaseInputView.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/10.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit

class BaseInputV: UIView {
    
    override init(frame:CGRect){
        
        super.init(frame:frame)
        
        print("try init view")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
