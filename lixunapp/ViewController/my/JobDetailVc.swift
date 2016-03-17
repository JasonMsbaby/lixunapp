//
//  JobDetailVc.swift
//  lixunapp
//  岗位详情
//  Created by Jason_Msbaby on 16/3/10.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit

class JobDetailVc: BaseVc,UITableViewDataSource,UITableViewDelegate {
    // MARK: - 属性
    var headerView:UIView = UIView(frame: CGRectMake(0,0,Constants.App.screenWidth,864..))
    var img_head:UIImageView = UIImageView()
    var txt_userName:UILabel = UILabel()
    
    var tableView:UITableView = UITableView(frame: CGRectMake(0, CGFloat(Constants.Measure.top), Constants.App.screenWidth, Constants.App.screenHeight), style: .Plain)
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        title = Constants.Str.job_detail_title
        setupView()
    }
    // MARK: - 加载tableHeaderView
    func setupHeaderView(){
        tableView.tableHeaderView = headerView;
        headerView.addSubview(img_head)
        headerView.addSubview(txt_userName)
        img_head.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(headerView).offset(100..)
            make.centerX.equalTo(headerView)
            make.width.height.equalTo(356..)
        }
        txt_userName.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(img_head)
            make.top.equalTo(img_head.snp_bottom).offset(40..)
            make.width.equalTo(img_head)
        }
        //属性
        img_head.sd_setImageWithURL(NSURL(string: Constants.Config.img_demo))
        img_head.layer.cornerRadius = (356..)/2
        img_head.clipsToBounds = true
        txt_userName.text = "黄俊政"
        txt_userName.textAlignment = .Center
        txt_userName.font = Constants.Font.f24
        txt_userName.textColor = Constants.Color.fontLight
    }
    // MARK: - 加载视图
    func setupView(){
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
        tableView.separatorStyle = .None
        tableView.registerClass(JobDetailCell.self, forCellReuseIdentifier: "jobCell")
        tableView.dataSource = self
        tableView.delegate = self
        setupHeaderView()
        
    }
    // MARK: - tableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("jobCell")
        cell?.selectionStyle = .None
        return cell!;
    }
    // MARK: - tableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80..
    }

}
