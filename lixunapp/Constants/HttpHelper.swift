//
//  HttpHelper.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/10.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation
import Alamofire
import AEXML

struct HttpHelper {
    
    static let SUCCESS = "Go out for success"
    
    static func invokeJson(req:JsonReq,completionHandler: (Result<String, NSError> -> Void)? = nil){
        
        let url = "\(Constants.Config.json_url)\(req.uri)?\(req.formatParams())"
        
        print("try invoke url \(url)")
        
        Alamofire.request(.GET, url).responseString { (response) -> Void in
            
            if(completionHandler != nil){
                
                if let str = response.result.value {
                    
                    print("req:\(url) resp:\(str)")
                }
                
                completionHandler!(response.result)
            }
        }
    }
    
    static func invokeWebService(req:WebserviceProtocol,completionHandler: (Result<String, NSError> -> Void)? = nil){
        
        let xmlStr = req.convertXml()
        
        invokeWebService(xmlStr, completionHandler: completionHandler)
    }
    
    static func invokeWebService(xmlStr:String,completionHandler: (Result<String, NSError> -> Void)? = nil){
        
        print("req xml:\(xmlStr)")
        
        let xml = Constants.Config.webservice_xml.stringByReplacingOccurrencesOfString("#content#", withString: escapedString(xmlStr))
        
        let headers:[String:String] = [
            "Content-Type":"text/xml; charset=UTF-8",
            "SOAPAction":"\"\"",
        ];
        
        func createErr(failReason:String)->Result<String,NSError>{
            
            let failureReason = "failReason"
            let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
            return .Failure(error)
        }
        
        Alamofire.request(.POST, Constants.Config.webservice_url, parameters: ["xml":xml], encoding:ParameterEncoding.Custom(Request.contentEncode), headers: headers).responseString(completionHandler: { (response) -> Void in
            
            print("Response String: \(response.result.value)")
            
        }).responseXMLDocument { (response) -> Void in
            
            let result:Result<String,NSError>;
            
            switch response.result{
            
            case let .Success(value):
                
//                print("resp xml:\(value.xmlString)")
                
                if let respXml = value.root["SOAP-ENV:Body"]["fjs1:TIPTOPGateWayResponse"]["strxmloutput"].value {
                    
                    let xml2 = try? AEXMLDocument(xmlData: respXml.dataUsingEncoding(NSUTF8StringEncoding)!)
                    
                    if(xml2 != nil){
                        
                        if let str = xml2!.root.value{
                            
                            result = .Success(str)
                        } else{
                            
                            result = createErr("xml 解析失败")
                        }
                    }else{
                        
                        result = createErr("xml 解析失败")
                    }
                    
                } else{
                    
                    let failureReason = "Data could not be serialized. Input data was nil."
                    let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                    result = .Failure(error)
                }
                
            case let .Failure(err):
                print("err is \(err)")
                result = .Failure(err)
            }
            
            if(completionHandler != nil){
                
                completionHandler!(result)
            }
        };
    }
    
    static func query(url:String){
        
        Alamofire.request(.GET, "https://httpbin.org/get")
            .responseString { response in
                print("Response String: \(response.result.value)")
            }
            .responseJSON { response in
                print("Response JSON: \(response.result.value)")
        }
    }
}

extension HttpHelper{
    
    static func escapedString(stringValue:String)->String {
        // we need to make sure "&" is escaped first. Not doing this may break escaping the other characters
        var escapedString = stringValue.stringByReplacingOccurrencesOfString("&", withString: "&amp;", options: .LiteralSearch)
        
        // replace the other four special characters
        let escapeChars = ["<" : "&lt;", ">" : "&gt;", "'" : "&apos;", "\"" : "&quot;"]
        for (char, echar) in escapeChars {
            escapedString = escapedString.stringByReplacingOccurrencesOfString(char, withString: echar, options: .LiteralSearch)
        }
        
        return escapedString
    }
}

extension Request {
    
    static func contentEncode(URLRequest: URLRequestConvertible,parameters: [String: AnyObject]?)-> (NSMutableURLRequest, NSError?){
        
        let mutableURLRequest = URLRequest.URLRequest
        
        guard let parameters = parameters else { return (mutableURLRequest, nil) }
        
        let encodingError: NSError? = nil
        
        if let data:String = parameters["xml"] as? String{
            
            mutableURLRequest.HTTPBody = data.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        return (mutableURLRequest,encodingError)
    }
    
    public static func XMLResponseSerializer() -> ResponseSerializer<AEXMLDocument, NSError> {
        return ResponseSerializer { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            guard let validData = data else {
                let failureReason = "Data could not be serialized. Input data was nil."
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }
            
            do {
                let XML = try AEXMLDocument(xmlData: validData)
                return .Success(XML)
            } catch {
                return .Failure(error as NSError)
            }
        }
    }
    
    public func responseXMLDocument(completionHandler: Response<AEXMLDocument, NSError> -> Void) -> Self {
        return response(responseSerializer: Request.XMLResponseSerializer(), completionHandler: completionHandler)
    }
}