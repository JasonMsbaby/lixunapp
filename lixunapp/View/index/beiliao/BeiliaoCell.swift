//
//  BeiliaoCell.swift
//  lixunapp
//
//  Created by Jason_Msbaby on 16/3/15.
//  Copyright © 2016年 com.hexin. All rights reserved.
//
import MGSwipeTableCell
import UIKit

class BeiliaoCell:  MGSwipeTableCell{
    // MARK: - 属性
    var model:FatFeed?{
        didSet{
            self.setupData()
        }
    }
    var tableViewType:IndexTableViewType?{
        didSet{
            if(self.tableViewType == IndexTableViewType.IndexTableViewTypeFaliao){
                btn_check.setImage(UIImage(named: "bl_unchecked"), forState: .Selected)
                btn_check.setImage(UIImage(named: "bl_checked"), forState: .Normal)
                btn_check.addTarget(self, action: "btn_check_action:", forControlEvents: .TouchUpInside)
            }else{
                btn_check.setImage(UIImage(named: "bl_sanjiao"), forState: .Normal)
            }
        }
    }
    private let containView:UIView = UIView()
    let btn_check = UIButton()
    let lbl_order = UILabel()
    let lbl_date = UILabel()
    let lbl_product = UILabel()
    let lbl_kucun = UILabel()
    let lbl_yingfa = UILabel()
    let lbl_yifa = UILabel()
    let lbl_faliaoliang = UILabel()
    var lbl_cangku:UILabel?
    var lbl_cunchu:UILabel?
    var lbl_pici:UILabel?
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){
        self.backgroundColor = Constants.Color.navColor
        self.containView.backgroundColor = Constants.Color.white
        self.contentView.addSubview(self.containView)
        containView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(30..)
            make.bottom.equalTo(self.contentView).offset(0)
        }
        //下料单号
        containView.addSubview(btn_check)
        btn_check.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(self.containView).offset(40..)
            make.width.height.equalTo(40..)
        }
        containView.addSubview(lbl_order)
        lbl_order.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(btn_check)
            make.left.equalTo(btn_check.snp_right).offset(40..)
        }
        lbl_order.font = Constants.Font.f19
        lbl_order.textColor = Constants.Color.red
        lbl_order.text = "下料单号"
        //需求日期
        containView.addSubview(lbl_date)
        lbl_date.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.containView).offset(36..)
            make.right.equalTo(self.containView).offset(-40..)
            make.size.equalTo(CGSizeMake(200.., 50..))
        }
        lbl_date.font = Constants.Font.f18
        lbl_date.textColor = Constants.Color.white
        lbl_date.text = "需求日期"
        lbl_date.backgroundColor = Constants.Color.orange
        lbl_date.textAlignment = .Center
        lbl_date.layer.cornerRadius = 25..
        lbl_date.clipsToBounds = true
        //品名规格
        containView.addSubview(lbl_product)
        lbl_product.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.containView).offset(120..)
            make.left.equalTo(self).offset(40..)
            make.right.equalTo(self).offset(-60..)
            make.height.equalTo(70..)
        }
        lbl_product.backgroundColor = Constants.Color.gray
        lbl_product.textColor = Constants.Color.white
        lbl_product.font = Constants.Font.f17
        lbl_product.text = "  品名/规格  品名/规格  品名/规格"
        //仓库 存储 批次
        var lbl_temp1:UILabel?
        for(var i = 0; i < 3; i++){
            
            let img_temp = UIImageView()
            self.containView.addSubview(img_temp)
            img_temp.snp_makeConstraints(closure: { (make) -> Void in
                if lbl_temp1 == nil{
                    make.left.equalTo(self.containView).offset(40..)
                }else{
                    make.left.equalTo(lbl_temp1!.snp_right).offset(100..)
                }
                make.top.equalTo(lbl_product.snp_bottom).offset(30..)
                make.size.equalTo(CGSizeMake(40.., 36..))
            })
            
            
            let lbl_temp = UILabel()
            self.containView.addSubview(lbl_temp)
            lbl_temp.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(img_temp.snp_right).offset(38..)
                make.centerY.equalTo(img_temp)
            })
            lbl_temp.font = Constants.Font.f19
            lbl_temp.textColor = Constants.Color.fontLight
            lbl_temp1 = lbl_temp
            
            switch(i){
            case 0:
                img_temp.image = UIImage(named: "bl_cangku")
                lbl_temp.text = "仓库"
                lbl_cangku = lbl_temp
            case 1:
                img_temp.image = UIImage(named: "bl_cunchu")
                lbl_temp.text = "存储"
                lbl_cunchu = lbl_temp
            case 2:
                img_temp.image = UIImage(named: "bl_pici")
                lbl_temp.text = "批次"
                lbl_pici = lbl_temp
            default:
                print("没有分支")
                
            }
        }
        //库存量 采购批量
        self.containView.addSubview(lbl_kucun)
        lbl_kucun.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.containView).offset(118..)
            make.top.equalTo(self.containView).offset(294..)
        }
        lbl_kucun.font = Constants.Font.f18
        lbl_kucun.textColor = Constants.Color.orange
        lbl_kucun.text = "库存/采购批量"
        
        //应发
        containView.addSubview(lbl_yingfa)
        lbl_yingfa.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView).offset(570..)
            make.centerY.equalTo(lbl_kucun)
        }
        lbl_yingfa.font = Constants.Font.f24
        lbl_yingfa.textColor = Constants.Color.orange
        lbl_yingfa.text = "应发"
        
        //已发
        containView.addSubview(lbl_yifa)
        lbl_yifa.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView).offset(870..)
            make.centerY.equalTo(lbl_kucun)
        }
        lbl_yifa.font = Constants.Font.f24
        lbl_yifa.textColor = Constants.Color.fontDeep
        lbl_yifa.text = "已发"
        
        //发料量
        containView.addSubview(lbl_faliaoliang)
        lbl_faliaoliang.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView).offset(1230..)
            make.centerY.equalTo(lbl_kucun)
        }
        lbl_faliaoliang.font = Constants.Font.f36
        lbl_faliaoliang.textColor = Constants.Color.red
        lbl_faliaoliang.text = "发料量"
        
    }
    
    //装载数据
    func setupData(){
        lbl_order.text = model?.sfs01
        lbl_product.text = "  " + (model!.ima02 ?? "")+"/"+(model!.ima021 ?? "")
        lbl_cangku?.text = model?.sfs07
        lbl_cunchu?.text = model?.sfs08
        lbl_pici?.text = model?.sfs09
        lbl_kucun.text = (model!.img10 ?? "")+"/"+(model!.imaud10 ?? "")
        lbl_yingfa.text = model?.sfa05
        lbl_yifa.text = model?.sfa06
        lbl_faliaoliang.text = model?.sfs05
        lbl_date.text = model?.sfp02?.formatDate("yyyy-MM-dd'T'HH:mm:ss", toFormat: "yy-MM-dd")
    }
    //装载标签固定标题数据
    func setupLabel(){
        lbl_order.text = "订单号"
        lbl_product.text = "  品名/规格  品名/规格  品名/规格"
        lbl_cangku?.text = "仓库"
        lbl_cunchu?.text = "存储"
        lbl_pici?.text = "批次"
        lbl_kucun.text = "库存/采购批量"
        lbl_yingfa.text = "应发"
        lbl_yifa.text = "已发"
        lbl_faliaoliang.text = "发料量"
        lbl_date.text = "时间"
    }
    
    func btn_check_action(button:UIButton){
        print(button.selected)
        button.selected = !button.selected
    }
    
    
    
}
