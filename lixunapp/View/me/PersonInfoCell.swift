//
//  PersonInfoCell.swift
//  lixunapp
//
//  Created by Jason_Msbaby on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//
import SceneKit
import UIKit

class PersonInfoCell: UITableViewCell {
    
    var info:UILabel = UILabel()
    let width:CGFloat = Constants.App.screenWidth

    // MARK: - 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 初始化页面
    func setupView(){
        
        let line = UIImageView()
        line.backgroundColor = Constants.Color.bottomLine
        addSubview(line)
        line.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(248..)
            make.right.equalTo(self).offset(-248..);
            make.bottom.equalTo(self).offset(0)
            make.height.equalTo(1)
        }
        
        self.addSubview(info)
        info.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(line)
            make.top.equalTo(self).offset(20..)
            make.bottom.equalTo(self).offset(-20..)
        }
        info.appendAttr("地址:        ",font: Constants.Font.f22,color: Constants.Color.fontDeep)
        .appendAttr("LX11立讯精密",font: Constants.Font.f20,color: Constants.Color.fontLight)
        
        
    }
    // MARK: - 加载数据

}
