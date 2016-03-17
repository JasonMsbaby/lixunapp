//
//  ViewController.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import UIKit

class CustomTabVc: UITabBarController,UITabBarControllerDelegate,AlertProtocol{
    
    struct TabModel {
        let name:String
        let img:String
        let tapImg:String
        let vc:UIViewController
    }
    
    struct ProfitShowBean {
        let name:String
        var profits:[GetProfitListBean]
        
        mutating func addProfit(profit:GetProfitListBean){
            
            profits.append(profit)
        }
    }
    
    struct ProfitShowBeanArray {
        var array:[ProfitShowBean]
        
        mutating func addProfit(profit:GetProfitListBean){
            
            var (showBean,index) = self[profit.CompanyCode]
            
            if(showBean == nil){
                
                self.array.append(ProfitShowBean(name: profit.CompanyCode, profits: [profit]))
            } else{
                
                showBean?.addProfit(profit)
                array.removeAtIndex(index)
                array.append(showBean!)
            }
        }
        
        
        
        subscript(CompanyCode:String)->(ProfitShowBean?,Int){
            
            var index = 0
            
            for obj in array{
                
                if obj.name == CompanyCode{
                    
                    return (obj,index)
                }
                
                index++
            }
            
            return (nil,index)
        }
    }
    
    var profitArray:ProfitShowBeanArray?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupViews()
    }
    
    private func setupAppearance(){
        UINavigationBar.appearance().barTintColor = Constants.Color.navColor
        UINavigationBar.appearance().tintColor = Constants.Color.navTitle
        UINavigationBar.appearance().barStyle = .Default
        UITabBar.appearance().barStyle = .Default
        UITabBar.appearance().tintColor = UIColor.blackColor()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:Constants.Color.tabselColor], forState: .Selected)
    }
    
    private func setupViews(){
        
        let modelArr = [
            TabModel(name:Constants.Str.index, img: "tab_index", tapImg: "tab_index_sel", vc:IndexVc()),
            TabModel(name: Constants.Str.exchange, img: "tab_change", tapImg: "tab_change", vc: OtherVc()),
//            TabModel(name: Constants.Str.test, img: "ic_people", tapImg: "ic_star_half", vc: TestVc()),
            TabModel(name: Constants.Str.my, img: "tab_my", tapImg: "tab_my_sel", vc: MyVc()),
        ]
        
        var vcArr:[UINavigationController] = []
        
        modelArr.forEach {
            
            $0.vc.tabBarItem = UITabBarItem.init(title: $0.name, image: UIImage.init(named: $0.img), selectedImage: UIImage.init(named: $0.tapImg)?.imageWithRenderingMode(.AlwaysOriginal))
            
            let nagVc = UINavigationController.init(rootViewController: $0.vc)
            
            vcArr.append(nagVc)
        }
        
        self.viewControllers = vcArr
        self.delegate = self
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        if let title = viewController.tabBarItem.title where title == Constants.Str.exchange{
            
            showExchange()
            return false
        }
        
        return true
    }
    
}

