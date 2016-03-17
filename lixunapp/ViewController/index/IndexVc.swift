//
//  IndexVc.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit
import SDCycleScrollView

class IndexVc: BaseVc,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,AlertProtocol,SDCycleScrollViewDelegate,CheckLoginProtocol{
    
    struct collectionViewInfo {
        static let identify = "default_cv"
    }
    
    var collectV:UICollectionView?
    var models:[IndexM]?
    var picArray:[GetCarouselPhotoBean]?
    var scrollImg:SDCycleScrollView?
    
    lazy var cellSize:CGSize = {
        
        let width = (self.collectV?.frame.width)!/4
        
        return CGSize(width: width, height: 295..)
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = Constants.Str.index
        self.view.backgroundColor = Constants.Color.white
        models = defaultModels()
        setupViews()
        updateModels(queryModels())
    }
    
    private func defaultModels()->[IndexM]{
        
        let totalCount = 16
        let rowCell = 4
        
        var ms:[IndexM] = []
        
        for i in 0..<totalCount{
            
            ms.append(IndexM(cellType:.None,lines:hasBorderLine(i, total: totalCount, rowCell: rowCell)))
        }
        
        return ms
    }
    
    private func setupViews(){
        
        setupScrollView()
        setupCollectionV()
    }
    
    private func setupCollectionV(){
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        collectV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectV?.dataSource = self
        collectV?.delegate = self
        collectV?.backgroundColor = UIColor.whiteColor()
        collectV?.registerClass(IndexCC.classForCoder(), forCellWithReuseIdentifier: collectionViewInfo.identify)
        
        let margin = 20..
        
        self.view.addSubview(collectV!)
        collectV?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo((scrollImg?.snp_bottom)!).offset(margin)
            make.left.equalTo(self.view).offset(margin)
            make.right.equalTo(self.view).offset(-margin)
            make.bottom.equalTo(self.view).offset(-Constants.Measure.tabbarHeight)
        })
    }
    
    private func setupScrollView(){
    
        scrollImg = SDCycleScrollView()
        self.view.addSubview(scrollImg!)
        scrollImg?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(self.view).offset(Constants.Measure.top)
            make.left.width.equalTo(self.view)
            make.height.equalTo(600..)
        })
        scrollImg?.placeholderImage = UIImage(named: "me_placeholder")
//        scrollImg?.titlesGroup = ["感谢您的支持，如果下载的",
//            "如果代码在使用过程中出现问题"]
        scrollImg?.autoScrollTimeInterval = 4
        scrollImg?.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        scrollImg?.delegate = self
    }
    
    private func queryModels()->[IndexCellType]{
        
        let ms:[IndexCellType] = [
            .Beiliao,.Faliao,.Zafa
        ]
        
        return ms
    }
    
    private func updateModels(types:[IndexCellType]){
        
        for(var i=0;i<models?.count;i++){
            
            if(i<types.count){
                
                models![i].type = types[i]
            }else{
                
                models![i].type = .None
            }
        }
        
        self.collectV?.reloadData()
    }
    
    //MARK: collection view datasource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return models?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewInfo.identify, forIndexPath: indexPath)
        
        if let a = cell as? IndexCC{
            
            a.presentModel(models![indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return cellSize
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let m = models![indexPath.row]
        
        switch m.type {
            
        case .Beiliao:
            self.pushNext(BeiliaoVc())
        case .Faliao:
            self.pushNext(FaliaoVc())
        case .Zafa:
            
            doAfterLogin{ [unowned self] in
                self.showAlert(m.type.info().name, button: "确定")
            }
        default:
            print("do nothing")
        }
    }
    
    //MARK: scroll img click delegate
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
        guard let pics = picArray where picArray?.count > index else{
            
            return
        }
        
        guard let toUrl = pics[index].JumpPath where pics[index].JumpPath != "" else{
            
            return
        }
        
        let webVc = WebVc()
        webVc.url = toUrl
        
        pushNext(webVc)
        
    }
    
    //MARK: view will appear
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        updateCarouselPhoto()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        doAfterLogin()
    }
    
    private func updateCarouselPhoto(){
        
        if(picArray != nil){
            
            return
        }
        
        let req = GetCarouselPhotoReq()
        HttpHelper.invokeJson(req){[weak self]
            result in
            switch result{
                
            case let .Success(value):
                let respArray = try? GetCarouselPhotoBean.arrayOfModelsFromString(value)
                self?.doAfterCarouse(respArray)
            case let .Failure(err):
                print("is failure:\(err)")
            }
        }
    }
    
    private func doAfterCarouse(respArray:NSMutableArray?){
        
        if(respArray == nil){
            
            return
        }
        
        var array:[GetCarouselPhotoBean] = []
        
        for obj in respArray! {
        
            if let oo = obj as? GetCarouselPhotoBean{
                
                array.append(oo)
            }
        }
        
        picArray = array
        
        var picA:[String] = []
        
        picArray?.forEach{
            
            if let img = $0.ImagePath{
            
                picA.append(img)
            }
        }
        
        scrollImg?.imageURLStringsGroup = picA
        
    }
    
    private func testData(){
        
        if DataHelper.isLogin(){
            
            DataHelper.delUser()
        } else{
            
            let newUser = DataUser(empCode: "empCode", pwd: "pwd")
            
            DataHelper.saveUser(newUser)
        }
    }
    
    private func testWebService(){
        
        let formConfirm = WSFormConfirm(sourceFormNum1: "E551D-140700072", cnt1: "1", number1: "60")
        let appissue = WSCreateFormAppissue(plantID: "LXXT", profitID: "SEE-D", type: "B", id: "100266", num: "1",form: [formConfirm])
        
        HttpHelper.invokeWebService(appissue) { (result) -> Void in
            
            switch result{
                
            case let .Success(value):
                print("is success \(value)")
            case let .Failure(err):
                print("is failure:\(err)")
            }
        }
    }
    
}