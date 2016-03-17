//
//  IndexCC.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class IndexCC: UICollectionViewCell,PresentProtocol{
    // 分割线的宽度
    let lineWidth = 1
    var lines:[UIView] = []
    // titleview
    var nameL:UILabel
    // imgview
    var imgV:UIImageView
    
    override init(frame: CGRect) {
        
        nameL = Helper.label(Constants.Font.f20,textColor:Constants.Color.fontLight)
        imgV = UIImageView()
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        // top line
        let topLine = addLine()
        topLine.snp_makeConstraints { (make) -> Void in
            make.top.right.left.equalTo(self)
            make.height.equalTo(lineWidth)
        }
        // right
        let rightLine = addLine()
        rightLine.snp_makeConstraints { (make) -> Void in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(lineWidth)
        }
        // bottom
        let bottomLine = addLine()
        bottomLine.snp_makeConstraints { (make) -> Void in
            make.width.bottom.left.equalTo(self)
            make.height.equalTo(lineWidth)
        }
        // left
        let leftLine = addLine()
        leftLine.snp_makeConstraints { (make) -> Void in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(lineWidth)
        }
        // img view 
        self.addSubview(imgV)
        imgV.contentMode = .ScaleAspectFit
        imgV.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(50..)
            make.height.equalTo(132..)
            make.centerX.equalTo(self)
        }
        // name lable
        self.addSubview(nameL)
        nameL.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(imgV.snp_bottom).offset(32..)
            make.centerX.equalTo(self)
        }
    }
    
    private func addLine() -> UIView{
        
        let line = pp_lineV()
        lines.append(line)
        self.addSubview(line)
        return line
    }
    
    func presentModel(m:IndexM){
        
        let contentHidden = m.type == .None
        
        nameL.hidden = contentHidden
        imgV.hidden = contentHidden
        
        if(!contentHidden){
            nameL.text = m.title
            imgV.image = UIImage(named: m.img!)
        }
        
        
        presentLine(m)
        
    }
    
    func presentLine(m:IndexM){
        
        for i in 0..<4 {
            
            let line = BorderLine(rawValue: 1 << i)
            
            if line != nil{
                let hasLine = m.lines.contains(line!)
                
                lines[i].hidden = !hasLine
            }
        }
    }
}
