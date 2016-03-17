//
//  WebServiceModel.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/14.
//  Copyright © 2016年 com.hexin. All rights reserved.
//
import AEXML
import Foundation

extension AEXMLDocument{
    
    public var xmlNoheadString: String {
        
        var xml = ""
        for child in children {
            xml += child.xmlString
        }
        return xml
    }
}

protocol WebserviceProtocol{
    
    func convertXml()->String;
}

protocol WebserviceFormAble{
    
    func addForm(parent:AEXMLElement,index:Int);
}

struct LogOnInfo{
    
    var senderIP:String? = "192.168.20.161"
    var receiverIP:String?
    var eFSiteName:String? = "NaNaWeb"
    
    func addContent(parent:AEXMLElement){
        
        parent.addChild(name: "SenderIP", value: senderIP ?? "")
        parent.addChild(name: "ReceiverIP", value: receiverIP ?? "")
        parent.addChild(name: "EFSiteName", value: eFSiteName ?? "")
    }
}

class WSRequest:WebserviceProtocol{
    
    let requestMethod:String
    var logOnInfo:LogOnInfo
    
    init(requestMethod:String,logOnInfo:LogOnInfo? = nil){
    
        self.requestMethod = requestMethod
        self.logOnInfo = logOnInfo ?? LogOnInfo()
    }
    
    func convertXml() -> String {
        
        let doc = AEXMLDocument()
        let root = doc.addChild(name: "Request")
        root.addChild(name: "RequestMethod",value: requestMethod)
        let logEle = root.addChild(name: "LogOnInfo")
        logOnInfo.addContent(logEle)
        // body
        let bodyEle = root.addChild(name: "RequestContent")
        addBody(bodyEle)
        
        let dd = doc as AEXMLDocument
        
        return dd.xmlNoheadString
    }
    
    func addBody(parent: AEXMLElement) {
        
    }
}

class WSCreateFormAppissue:WSRequest{
    
    let language:String = "GB"
    // 营运中心
    let plantID:String?
    // 利润中心
    let profitID:String?
    let programID:String = "Appissue"
    let type:String
    let id:String
    let num:String
    var form:[WebserviceFormAble]?
    
    init(plantID:String?,profitID:String?,type:String,id:String,num:String,form:[WebserviceFormAble]?=nil){
        
        self.plantID = plantID
        self.profitID = profitID
        self.type = type
        self.id = id
        self.num = num
        self.form = form
        super.init(requestMethod: "CreateFormAppissue")
    }
    
    override func addBody(parent: AEXMLElement) {
        
        parent.addChild(name: "Language", value: language ?? "")
        parent.addChild(name: "PlantID", value: plantID ?? "")
        parent.addChild(name: "ProfitID", value: profitID ?? "")
        parent.addChild(name: "ProgramID", value: programID ?? "")
        parent.addChild(name: "Type", value: type ?? "")
        parent.addChild(name: "Id", value: id ?? "")
        parent.addChild(name: "Num", value: num ?? "")
        
        if(form != nil){
            
            let formEle = parent.addChild(name: "Form")
            guard let forms = form else{
                return
            }
            for i in 0..<forms.count{
                forms[i].addForm(formEle, index: i)
            }
        }
    }
    
}

// 备料确认
struct WSFormConfirm:WebserviceFormAble {
    
    var sourceFormNum:String?
    var cnt:String?
    var number:String?
    
    init(sourceFormNum1:String?=nil,cnt1:String?=nil,number1:String?=nil){
        self.sourceFormNum = sourceFormNum1
        self.cnt = cnt1
        self.number = number1
    }
    
    func addForm(parent: AEXMLElement,index:Int) {
        
        parent.addChild(name: "SourceFormNum\(index+1)", value: sourceFormNum ?? "")
        parent.addChild(name: "Cnt\(index+1)", value: cnt ?? "")
        parent.addChild(name: "Number\(index+1)", value: number ?? "")
    }
    
}

enum FormType:String{
    
    case CONFIRM="A",CANCEL="B",UPDATE="C",GUOZHANG="D"
}


