//
//  ScanCodeVc.swift
//  lixunapp
//  扫描二维码控制器
//  Created by Jason_Msbaby on 16/3/14.
//  Copyright © 2016年 com.hexin. All rights reserved.
//
import AVFoundation
import UIKit
////四个角的位置枚举
//enum HornPosition:Int{
//    case HornPositionTopLeft = 0 ,HornPositionTopRight ,HornPositionBottomLeft ,HornPositionBottomRight
//}

class ScanCodeVc: BaseVc,AVCaptureMetadataOutputObjectsDelegate,AlertProtocol{
    
    enum ScanCodeType:String{
        case OTHER,ERWEIMA,TIAOXINGMA
    }
    
    typealias ScanClosure=(content:String,codeType:ScanCodeType)->Void
    
    var scanClosure:ScanClosure?
    // MARK: - 组件属性
    private var captureDevice:AVCaptureDevice? //捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    private var captureDeviceInput:AVCaptureDeviceInput? //输入流
    private var captureMetaOuput:AVCaptureMetadataOutput?//输出流
    private var captureSession:AVCaptureSession?//会话
    private var previewLayer:AVCaptureVideoPreviewLayer?//预览图层
    // MARK: - 视图属性
    private let containView:UIView = UIView(frame: Constants.App.mainBounds)
    private let btn_back:UIButton = UIButton(frame: CGRectMake(0,CGFloat(Constants.Measure.statusBarHeight),50,50))
    private let scanView:UIView = UIView()
    private let scanLine = UIImageView(image: UIImage(named: "me_scanface_line"))
    // MARK: - 方法
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        //        print("will dis appear")
        self.navigationController?.navigationBarHidden = false
        
        if ((captureSession?.running) != nil && captureSession?.running == true){
            captureSession?.stopRunning()
        }
        
    }
    
    override func viewDidLoad() {
        title = "扫一扫";
        setupView()
        initCom()
//        lineScroll()
    }
    // MARK: - 界面绘制
    func setupView(){
        
        self.containView.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.containView)
        self.navigationController?.navigationBarHidden = true;
        btn_back.setImage(UIImage(named: "me_icon_back"), forState: .Normal);
        btn_back.addTarget(self, action: "back", forControlEvents: .TouchUpInside)
        self.containView.addSubview(btn_back)
        //添加四个扫描区域的拐角
        scanView.backgroundColor = self.scanView.backgroundColor?.colorWithAlphaComponent(0);
        //        scanView.backgroundColor = UIColor.whiteColor();
        self.containView.addSubview(scanView);
        
        scanView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.containView)
            make.width.height.equalTo(self.containView.snp_width).multipliedBy(0.8);
        }
        self.view.layoutIfNeeded()
        
        //角 图片的大小
        let size_img:CGFloat = 30;
        //底座的宽
        let size_scan:CGFloat = scanView.bounds.size.width - size_img;
        
        for(var i:Int = 0; i < 4; i++){
            let img:UIImageView = UIImageView(image: UIImage(named: "me_guaijiao\(i+1)"))
            var frame:CGRect = CGRectMake(0, 0, 0, 0);
            
            switch (i){
            case 0:
                frame = CGRectMake(0,0,size_img,size_img)
                break
            case 1:
                frame = CGRectMake(size_scan, 0, size_img, size_img)
                break
            case 2:
                frame = CGRectMake(0, size_scan, size_img, size_img)
                break
            case 3:
                frame = CGRectMake(size_scan, size_scan, size_img, size_img)
                break
            default:break
            }
            img.frame = frame;
            scanView.addSubview(img)
        }
        
        //添加底部的标示文本
        let lbl_view:UILabel = UILabel()
        self.containView.addSubview(lbl_view)
        lbl_view.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.containView)
            make.top.equalTo(self.scanView.snp_bottom).offset(30)
            make.width.equalTo(self.containView).multipliedBy(0.5)
            make.height.equalTo(35)
        }
        lbl_view.layer.cornerRadius = 20;
        lbl_view.clipsToBounds = true;
        lbl_view.text = "条形码·二维码"
        lbl_view.textColor = UIColor.blackColor()
        lbl_view.backgroundColor = Constants.Color.navColor
        lbl_view.textAlignment = .Center
        lbl_view.font = Constants.Font.f20
        
    }
    //界面扫描动画
    func lineScroll(){
        scanView.addSubview(scanLine)
        scanLine.frame = CGRectMake(0, 10, scanView.bounds.size.width, 5)
        
        UIView.animateWithDuration(1.5,delay: 0,options: [UIViewAnimationOptions.CurveEaseIn,UIViewAnimationOptions.Repeat], animations: { [unowned self]() -> Void in
            
            self.scanLine.transform = CGAffineTransformMakeTranslation(0, self.scanView.bounds.size.height-20);
            
            }, completion: { [weak self](flag) -> Void in
                var rect = CGRectZero
                if let v = self?.scanView.bounds {
                    rect = CGRectMake(0, 10, v.size.width, 5)
                }
                self?.scanLine.frame = rect
            })
    }
    
    //返回
    func back(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - 功能
    //初始化组件
    func initCom(){
        do{
            //创建捕捉设备
            captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            
            //创建输入流
            try captureDeviceInput = AVCaptureDeviceInput(device: captureDevice)
            //创建输出流
            captureMetaOuput = AVCaptureMetadataOutput()
            //创建会话
            captureSession = AVCaptureSession()
            
            //将输入输出流添加到会话
            captureSession!.addInput(captureDeviceInput!)
            captureSession!.addOutput(captureMetaOuput)
            
            //创建串行队列，并加媒体输出流添加到队列当中
            var queue:dispatch_queue_t?
            queue = dispatch_queue_create("scanCodeQueue", nil)
            //设置代理
            captureMetaOuput!.setMetadataObjectsDelegate(self, queue: queue)
            //设置输出媒体数据类型为QRCode
            captureMetaOuput!.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
            //设置预览图层
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            //设置预览图层填充方式
            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            //设置预览图层的frame
            previewLayer?.frame = CGRectMake(0, 0, Constants.App.screenWidth, Constants.App.screenHeight)
            //将图层添加到视图上
            //            self.containView.layer.addSublayer(previewLayer!)
            self.containView.layer.insertSublayer(previewLayer!, atIndex: 0)
            self.view.layoutIfNeeded()
            //设置扫描范围
            let x = scanView.frame.origin.y/containView.bounds.height
            let y = scanView.frame.origin.x/containView.bounds.width
            let width = scanView.frame.size.height/containView.bounds.height
            let height = scanView.frame.size.width/containView.bounds.width;
            let inset = CGRectMake(x,y,width,height)
            captureMetaOuput!.rectOfInterest = inset;
            //开始扫描
            captureSession!.startRunning()
        }catch{
            print("没有摄像头 扫描个屁")
        }
    }
    
    // MARK: - 扫描结果返回代理方法
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects != nil && metadataObjects.count > 0{
            let metaDataObject:AVMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject;
            
            if ((captureSession?.running) != nil && captureSession?.running == true){
                captureSession?.stopRunning()
            }
            //判断回传的数据类型
            switch metaDataObject.type{
                // 二维码
            case AVMetadataObjectTypeQRCode:
                handlerReceiveContent(metaDataObject.stringValue, qrType: .ERWEIMA)
                // 条形码
            case AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code:
                handlerReceiveContent(metaDataObject.stringValue, qrType: .TIAOXINGMA)
            default:
                handlerReceiveContent(metaDataObject.stringValue, qrType: .OTHER)
            }
            
        }
    }
    
    func handlerReceiveContent(content:String,qrType:ScanCodeType){
        
        print("scan \(qrType) content:\(content)")
        
//        if let closure = scanClosure{
//            
//            closure(content: content, codeType: qrType)
//        }
        
//        showAlert("123", message: "扫描到数据")
        selfRemoveFromSuperview()
        
//        print(self.navigationController)
//        self.navigationController?.popToRootViewControllerAnimated(false)
//        NSNotificationCenter.defaultCenter().postNotificationName("close aa", object: nil)
    }
    
    /**
    *  @author Whde
    *
    *  从父视图中移出
     */
    func selfRemoveFromSuperview(){
        
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: { () -> Void in
            
            self.view.alpha = 0;
            }) { (result) -> Void in
                
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        }
    }
}
