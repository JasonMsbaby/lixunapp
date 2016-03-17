//
//  FaliaoVc.swift
//  lixunapp
//
//  Created by Jason_Msbaby on 16/3/16.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit

class FaliaoVc: BaseVc,IndexTableViewDelegate {
    // MARK: - 属性
    let tableView:IndexTableView = IndexTableView(frame: CGRectMake(0,CGFloat(Constants.Measure.top),Constants.App.screenWidth,Constants.App.screenHeight),type:IndexTableViewType.IndexTableViewTypeFaliao)
    
    
    // MARK: - 生命周期
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.navigationBar.clipsToBounds = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.tableView.requestData()
        self.title = "发料"
    }
    
    func setupView(){
        self.view.backgroundColor = Constants.Color.navColor
        self.navigationController?.navigationBar.clipsToBounds = true
        self.view.addSubview(tableView)
        self.tableView.delegate = self;
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "过账", style: UIBarButtonItemStyle.Done, target: self, action: "guozhangAction")
        
    }
    
    // MARK: - IndexTableViewDelegate
    
    func IndexTableViewCellLeftSilde(type: swipeLeftButtonType, indexPath: NSIndexPath, model: FatFeed) {
        print("type:\(type),indexPath:\(indexPath)")
    }
    

}
