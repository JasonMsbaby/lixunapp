//
//  QrCodeProtocol.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/17.
//  Copyright © 2016年 com.hexin. All rights reserved.
//
// 扫描二维码组件
import UIKit
import AVFoundation

protocol QrCodeProtocol{
    
    func scanQrCode(scanClosure:((str:String)->()))
}

extension QrCodeProtocol where Self:UIViewController{
    
    func scanQrCode(scanClosure:((str:String)->())){
        
        let vc = QRCodeController()
        vc.setDidReceiveBlock({ (str) -> Void in
            
            scanClosure(str: str)
        })
        
        let del = UIApplication.sharedApplication().delegate as? AppDelegate;
        del?.window?.rootViewController?.addChildViewController(vc)
        del?.window?.rootViewController?.view.addSubview(vc.view)
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: { () -> Void in
            vc.view.alpha = 1
            }, completion: { (result) -> Void in
                
        })
    }
    
    private func check()->Bool{
        
        let mediaType = AVMediaTypeVideo;
        let authStatus = AVCaptureDevice.authorizationStatusForMediaType(mediaType)
        if(authStatus == .Denied){
            let alert = UIAlertController(title: "相机权限受限", message: "请在iPhone的\"设置->隐私->相机\"选项中,允许\"自游邦\"访问您的相机.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "好", style: .Cancel){ (action) -> Void in
                
            })
            
//            [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            if ([self canOpenSystemSettingView]) {
//            [self systemSettingView];
//            }
//            }]];
            self.presentViewController(alert, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
}
