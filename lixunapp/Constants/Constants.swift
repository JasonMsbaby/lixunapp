//
//  Constants.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/9.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import UIKit

// 常量
struct Constants {
    // 基本配置
    struct Config{
        
        static let url = "http://www.baidu.com"
        // webservice
        // webservice
        static let webservice_url = "http://192.168.20.19/cgi-bin/fglccgi/ws/r/aws_efsrv?wsdl"
        
        static let webservice_xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><soapenv:Body><ns1:TIPTOPGateWay soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:ns1=\"http://tempuri.org/aws_efsrv\"><strxmlinput xsi:type=\"xsd:string\">#content#</strxmlinput></ns1:TIPTOPGateWay></soapenv:Body></soapenv:Envelope>";
        
        static let img_demo = "http://img1.touxiang.cn/uploads/20130518/18-031812_697.jpg"
        // json 请求的url地址
        static let json_url = "http://116.6.133.155:8088/api/FatFeed"
        
        static let empCode = "L025367"
        
        static let pwd = "stones"
    }
}

//MARK: 颜色相关
extension Constants{
    // 颜色config
    struct Color {
        // tab 选中字体颜色
        static let tabselColor = UIColor.init(hex:0x4b9bf9)
        // 导航栏颜色
        static let navColor = UIColor.init(hex:0xe8e8e8)
        // default background
        static let defaultBg = UIColor(hex: 0xf0f0f0)
        
        static let color1 = UIColor.init(hex: 0xdcdcdc)
        
        static let white = UIColor.whiteColor()
        // commit btn color
        static let commitBtn = UIColor.init(hex:0xffa522)
        
        static let navTitle = UIColor.init(hex:0x323232)
        
        static let red = UIColor(hex:0xe94a35)
        
        static let orange = UIColor(hex: 0xffa552)
        
        static let gray = UIColor(hex: 0x5d5d5d)
        
        static let lineDefault = UIColor(hex:0x909090)
        
        //tableviewCell底部下划线的颜色
        static let bottomLine = UIColor.init(hex: 0xd6d7dc)
        
        static let fontDeep = UIColor.init(hex: 0x323232)
        static let fontLight = UIColor.init(hex: 0x646464)
        
        static let buttonOrigin = UIColor.init(hex: 0xffa522)
        
    }
}

//MARK: app 相关属性
extension Constants{
    // app 属性
    struct App {
        
        static var mainBounds:CGRect{
            
            return UIScreen.mainScreen().bounds
        }
        
        static var screenWidth:CGFloat {
            
            return mainBounds.size.width
        }
        
        static var screenHeight:CGFloat {
            
            return mainBounds.size.height
        }
        
        static var frameBounds:CGRect{
            
            return UIScreen.mainScreen().applicationFrame
        }
        
        static var useFullBonus:CGRect{
            
            let y = CGFloat(Constants.Measure.navHeight + Constants.Measure.statusBarHeight)
            
            return CGRect(x: 0, y: y, width: screenWidth, height: screenHeight - y)
        }
        
        static var useFullBonusHasTabbar:CGRect{
            
            let y = CGFloat(Constants.Measure.navHeight + Constants.Measure.statusBarHeight)
            let bottom = CGFloat(Constants.Measure.tabbarHeight)
            
            return CGRect(x: 0, y: y, width: screenWidth, height: screenHeight - y - bottom)
        }
    }
}

//MARK: 高度等相关
extension Constants{
    
    struct Measure {
        // nav height
        static let navHeight = 44
        // status bar height
        static let statusBarHeight = 20
        
        static let top = navHeight + statusBarHeight
        
        static let tabbarHeight = 49
        
        static let margin = 5
        // btn按钮的高度
        static let btnH = 40
    }
}

//MARK: 字符串中文
extension Constants{
    
    struct Str {
        
        static let index = "首页"
        static let my = "我的"
        static let exchange = "切换"
        static let test = "测试"
        
        static let person_info_title = "个人资料明细"
        static let job_detail_title = "岗位说明"
    }
}

extension Constants{
    
    struct Font {
        
        static func common(var size:CGFloat)->UIFont{
            
            if(UIDevice.currentDevice().model != "iPad"){
                
                size = size/2
            }
            
            return UIFont.init(name: "Helvetica", size: size)!
        }
        
        static let f10:UIFont = Font.common(10)
        static let f11:UIFont = Font.common(11)
        static let f12:UIFont = Font.common(12)
        static let f13:UIFont = Font.common(13)
        static let f14:UIFont = Font.common(14)
        static let f15:UIFont = Font.common(15)
        static let f16:UIFont = Font.common(16)
        static let f17:UIFont = Font.common(17)
        static let f18:UIFont = Font.common(18)
        static let f19:UIFont = Font.common(19)
        static let f20:UIFont = Font.common(20)
        static let f21:UIFont = Font.common(21)
        static let f22:UIFont = Font.common(22)
        static let f23:UIFont = Font.common(23)
        static let f24:UIFont = Font.common(24)
        static let f25:UIFont = Font.common(25)
        static let f26:UIFont = Font.common(26)
        static let f27:UIFont = Font.common(27)
        static let f28:UIFont = Font.common(28)
        static let f29:UIFont = Font.common(29)
        static let f30:UIFont = Font.common(30)
        static let f31:UIFont = Font.common(31)
        static let f32:UIFont = Font.common(32)
        static let f33:UIFont = Font.common(33)
        static let f34:UIFont = Font.common(34)
        static let f35:UIFont = Font.common(35)
        static let f36:UIFont = Font.common(36)
        
        
        
        static let f40:UIFont = Font.common(40)
    }
}

extension Constants{
    // 用的多的图片
    struct imgStr{
    
        static let xianbie = "comm-xianbie"
        static let cangguan = "ic_people"
        static let user = "comm_user"
        static let mudixianbie = "comm-mudixianbie"
        static let saoyisao = "comm-saoyisao"
    }
}

extension Constants{
    
    struct Tag {
        // 线别
        static let xianbie = 1
        // 工号
        static let empCode = 2
        // 目的线别
        static let mudixianbie = 3
        // 扫一扫
        static let saoyisao = 4
        // 提交
        static let commit = 20
        // 登录
        static let login = 21
        // 名称
        static let name = 22
        // 密码
        static let pwd = 23
    }
}



