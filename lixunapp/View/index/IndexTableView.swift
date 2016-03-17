//
//  IndexTableView.swift
//  lixunapp
//
//  Created by Jason_Msbaby on 16/3/16.
//  Copyright © 2016年 com.hexin. All rights reserved.
//
import MJRefresh
import MGSwipeTableCell
import UIKit
import MBProgressHUD

protocol IndexTableViewDelegate{
    //左滑点击后触发
    func IndexTableViewCellLeftSilde(type:swipeLeftButtonType,indexPath:NSIndexPath,model:FatFeed);
}
//表格的类型
enum IndexTableViewType:Int32{
    case IndexTableViewTypeBeiliao = 0,IndexTableViewTypeFaliao = 1
}
//侧滑的类型
enum swipeLeftButtonType{
    case swipeLeftButtonTypeEidt,swipeLeftButtonTypeCancle,swipeLeftButtonTypeBeiliao
}

class IndexTableView: UIView,UITableViewDataSource,UITableViewDelegate,MGSwipeTableCellDelegate{
    // MARK: - 属性
    var tableView:UITableView?
    var delegate:IndexTableViewDelegate?
    var dataSource:NSMutableArray?
    private var currentPage:Int32 = 1
    var indexTableType:IndexTableViewType?
    
    // MARK: - 初始化
    init(frame: CGRect,type:IndexTableViewType) {
        super.init(frame: frame);
        self.setupView()
        indexTableType = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        let headerView = BeiliaoHeaderView(frame: CGRectMake(0,0,Constants.App.screenWidth,200..))
        self.addSubview(headerView)
        
        tableView = UITableView(frame: CGRectMake(20.., 200.., Constants.App.screenWidth-40.., Constants.App.screenHeight-CGFloat(Constants.Measure.top)-200..), style: .Plain)
        self.addSubview(self.tableView!)
        
        self.tableView!.backgroundColor = Constants.Color.navColor
        self.tableView!.separatorStyle = .None
        self.tableView!.dataSource = self
        self.tableView!.delegate = self
        self.addMJRefresh()
        self.tableView!.registerClass(BeiliaoCell.self, forCellReuseIdentifier: "cell")
        
    }
    // MARK: - 添加上拉刷新下拉加载更多
    func addMJRefresh(){
        tableView?.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [unowned self]() -> Void in
            self.currentPage = 1;
            self.requestData()
        })
        
        tableView?.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: { () -> Void in
            self.currentPage++
            self.requestData()
        })
        
        
    }
    // MARK: - 请求网络数据
    func requestData(let line:String? = "",let objectLine:String? = ""){
        let req = GetFatFeedListReq()
        let currentUser:DataUser = DataHelper.getUser()!
        req.type = (self.indexTableType?.rawValue)!
        req.page = currentPage
//        req.type = 0
        req.orderByEnum = "1"
        req.companyCode = currentUser.CompanyCodeSel
        req.profit = currentUser.ProfitSel
        req.empCode = (currentUser.empCode)!
        req.line = line
        req.objectLine = objectLine
        MBProgressHUD.showHUDAddedTo(self, animated: true)
        HttpHelper.invokeJson(req) {[unowned self] (result) -> Void in
            MBProgressHUD.hideAllHUDsForView(self, animated: true)
            switch (result){
            case let .Success(value):
                print("---------\(value)")
                let arr:NSMutableArray? = try? FatFeed.arrayOfModelsFromString(value)
                guard arr != nil else{
                    
                    print("exception.")
                    return
                }
                
                if(self.currentPage == 1){
                    self.dataSource = arr;
                }else{
                    self.dataSource?.addObjectsFromArray(arr! as [AnyObject])
                }
                self.tableView?.reloadData()
            case let .Failure(err):
                print("is failure:\(err)")
            }
            self.tableView?.reloadData()
            self.tableView?.mj_header.endRefreshing()
            self.tableView?.mj_footer.endRefreshing()
        }
    }

    
    
    
    
    // MARK: - tableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataSource == nil{
            return 0;
        }
        return (self.dataSource?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BeiliaoCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! BeiliaoCell
        cell.selectionStyle = .None
        cell.tableViewType = self.indexTableType
        cell.delegate = self
        if(indexPath.row > 0){
            cell.btn_check.tag = indexPath.row
            cell.model = self.dataSource![indexPath.row] as? FatFeed
        }else{
            cell.setupLabel()
        }
        return cell
    }
    
    // MARK: - tableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 380..
    }
    
    
    //左滑
    func swipeTableCell(cell: MGSwipeTableCell!, swipeButtonsForDirection direction: MGSwipeDirection, swipeSettings: MGSwipeSettings!, expansionSettings: MGSwipeExpansionSettings!) -> [AnyObject]! {
        
        swipeSettings.transition = .Static
        
        if (direction == .LeftToRight){
            return []
        }
        
        
        let index:Int = (tableView?.indexPathForCell(cell)?.row)!
        
        if(index == 0){
            return []
        }
        
        let model = dataSource![index] as! FatFeed
        
        let edit = MGSwipeButton(title: "", icon: UIImage(named: "bl_bianji-1")?.transformWidth(Int(150..), height: 350), backgroundColor: Constants.Color.navColor, insets: UIEdgeInsets(top: 30.., left: 0, bottom: 0, right: 0))
        
        let beiliao = MGSwipeButton(title: "", icon: UIImage(named: "bl_beiliao-1")?.transformWidth(Int(150..), height: 350), backgroundColor: Constants.Color.navColor, insets: UIEdgeInsets(top: 30.., left:0, bottom: 0, right: 0))
        
        let cancle = MGSwipeButton(title: "", icon: UIImage(named: "bl_quxiao")?.transformWidth(Int(150..), height: 350), backgroundColor: Constants.Color.navColor, insets: UIEdgeInsets(top: 30.., left: 0, bottom: 0, right:0))
        
        
        guard let viewT = indexTableType else{
            
            return []
        }
        
        
        switch(viewT){
        case .IndexTableViewTypeBeiliao:
            
            if model.sfsud06 == "true"{
                
                return [cancle,edit]
                
            }else{
                
                return [beiliao,edit]
                
            }
        case .IndexTableViewTypeFaliao:
            
            if model.sfsud06 == "true"{
                
                return [cancle]
                
            }else{
                
                return [beiliao]
            }
        }
        
        
        
    }
    
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        
        let indexpath:NSIndexPath = (tableView?.indexPathForCell(cell))!
        let model:FatFeed = self.dataSource![indexpath.row] as! FatFeed
        
        
        if indexTableType == IndexTableViewType.IndexTableViewTypeBeiliao{//备料界面
            
            switch(index){
            case 0:
                if(model.sfsud06 == "true"){
                    if(self.delegate != nil){
                        self.delegate?.IndexTableViewCellLeftSilde(.swipeLeftButtonTypeCancle,indexPath: indexpath,model: model)
                    }
                }else{
                    if(self.delegate != nil){
                        self.delegate?.IndexTableViewCellLeftSilde(.swipeLeftButtonTypeBeiliao,indexPath: indexpath,model: model)
                    }
                }
            case 1:
                if(self.delegate != nil){
                    self.delegate?.IndexTableViewCellLeftSilde(.swipeLeftButtonTypeEidt,indexPath: indexpath,model: model)
                }
            default:
                print("no selected")
            }

            
        }else{//发料界面
            if model.sfsud06 == "true"{
                if(self.delegate != nil){
                    self.delegate?.IndexTableViewCellLeftSilde(.swipeLeftButtonTypeCancle,indexPath: indexpath,model: model)
                }
            }else{
                if(self.delegate != nil){
                    self.delegate?.IndexTableViewCellLeftSilde(.swipeLeftButtonTypeBeiliao,indexPath: indexpath,model: model)
                }
            }
        }
        
        return true
    }
}
