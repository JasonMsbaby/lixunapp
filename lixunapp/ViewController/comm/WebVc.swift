//
//  File.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/16.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit

class WebVc:BaseVc,UIWebViewDelegate,PresentProtocol{
    
    var webVc:UIWebView?
    var url:String?
    var isInit:Bool = false
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        webVc = UIWebView(frame: self.view.bounds + CGRect(x: 0, y: Constants.Measure.top, width: 0, height: -Constants.Measure.top))
        
        webVc?.delegate = self
        self.view.addSubview(webVc!)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        guard !isInit else{
            
            return
        }
        
        guard url != nil else{
            
            return
        }
        
        pp_hudShow(self.view)
        
        webVc?.loadRequest(NSURLRequest(URL: NSURL(string: url!)!))
        
        isInit = true
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        pp_hudHide(self.view)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        pp_hudHide(self.view)
        
        if let title = webView.stringByEvaluatingJavaScriptFromString("document.title"){
            
            self.title = title
        }
    }
}
