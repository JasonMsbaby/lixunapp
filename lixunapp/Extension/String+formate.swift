//
//  String+formate.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/16.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation

extension String{
    
    func formatDate(oldFormat:String,toFormat:String)->String{
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = oldFormat
        
        let date = formatter.dateFromString(self)
        
        if(date == nil){
            
            return self
        }
        
        formatter.dateFormat = toFormat
        return formatter.stringFromDate(date!)
    }
}