//
//  PersonInfoVc.swift
//  lixunapp
//
//  Created by Jason_Msbaby on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit
import Static
class PersonInfoVc: BaseVc,UITableViewDelegate,UITableViewDataSource {
    
    var table:UITableView = UITableView(frame: CGRectMake(0, CGFloat(Constants.Measure.top), Constants.App.screenWidth, Constants.App.screenHeight), style: .Plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    /*!
    加载视图
    */
    func setupView(){
        title = Constants.Str.person_info_title
        self.automaticallyAdjustsScrollViewInsets = false
        self.setupTableView()
    }
    /*!
    加载表格
    */
    func setupTableView(){
        table.delegate = self
        table.dataSource = self
        table.registerClass(PersonInfoCell.self, forCellReuseIdentifier: "cell")
        table.separatorStyle = .None
        table.tableHeaderView = PersonInfoHeader(frame: CGRectMake(0,0,Constants.App.screenWidth,752..))
        view.addSubview(self.table)
        
    }
    // MARK: - tableViewDatasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.selectionStyle = .None
        return cell
    }
    // MARK: - tableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80..
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20..
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headview = UIView()
        headview.backgroundColor = Constants.Color.navColor
        return headview
    }
    

}
