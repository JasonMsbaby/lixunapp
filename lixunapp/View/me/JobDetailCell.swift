//
//  JobDetailCell.swift
//  lixunapp
//
//  Created by Jason_Msbaby on 16/3/10.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit

class JobDetailCell: UITableViewCell {

    
    // MARK: - 属性
    var lbl_info:UILabel = UILabel()
    // MARK: - init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - 初始化视图
    func setupView(){
        let line:UIImageView = UIImageView()
        self.addSubview(line)
        line.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(248..)
            make.right.equalTo(-248..)
            make.height.equalTo(1)
            make.bottom.equalTo(self).offset(0)
        }
        line.backgroundColor = Constants.Color.bottomLine
        
        
        self.addSubview(lbl_info)
        lbl_info.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(20..)
            make.left.equalTo(self).offset(248..)
            make.right.equalTo(self).offset(-248..)
        }
        lbl_info.appendAttr("直接主管:    ", font: Constants.Font.f24, color: Constants.Color.fontDeep)
        .appendAttr("LLX立讯精密", font: Constants.Font.f20, color: Constants.Color.fontLight)
        
        
        
    }
   

}
