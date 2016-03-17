//
//  DataHelper.swift
//  lixunapp
//
//  Created by shahuaitao on 16/3/15.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

import Foundation

class DataUser:NSObject,NSCoding{
    // 工号
    var empCode:String?
    var EmpName:String?
    // password
    var pwd:String?
    var CompanyCode:String?=""
    var CompanyName:String?=""
    var Profit:String?=""
    var EnglishName:String?=""
    var Gender:String?=""
    var Birthday:String?=""
    var Email:String?=""
    var Telephone:String?=""
    var DeptCode:String?=""
    var DeptName:String?=""
    var SalaryLevel:String?=""
    var WorkAge:Double=0
    var DirectBossEmpCode:String?=""
    var DirectBossEmpName:String?=""
    var SuperiorBossEmpCode:String?=""
    var SuperiorBossEmpName:String?=""
    var CompanyCodeSel:String?=""
    var ProfitSel:String?=""
    var HeadImg:String{
        
        get{
            
            return "http://dcs.luxshare-ict.com/Images/emp_photo/\(empCode!).jpg"
        }
    }
    
    init(empCode:String?,pwd:String?){
        self.empCode = empCode
        self.pwd = pwd
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.empCode = aDecoder.decodeObjectForKey("empCode") as? String
        self.EmpName = aDecoder.decodeObjectForKey("EmpName") as? String
        self.pwd = aDecoder.decodeObjectForKey("pwd") as? String
        self.CompanyCode = aDecoder.decodeObjectForKey("CompanyCode") as? String
        self.CompanyName = aDecoder.decodeObjectForKey("CompanyName") as? String
        self.Profit = aDecoder.decodeObjectForKey("Profit") as? String
        self.EnglishName = aDecoder.decodeObjectForKey("EnglishName") as? String
        self.Gender = aDecoder.decodeObjectForKey("Gender22") as? String
        self.Birthday = aDecoder.decodeObjectForKey("Birthday") as? String
        self.Email = aDecoder.decodeObjectForKey("Email") as? String
        self.Telephone = aDecoder.decodeObjectForKey("Telephone") as? String
        self.DeptCode = aDecoder.decodeObjectForKey("DeptCode") as? String
        self.DeptName = aDecoder.decodeObjectForKey("DeptName") as? String
        self.SalaryLevel = aDecoder.decodeObjectForKey("SalaryLevel") as? String
        self.WorkAge = aDecoder.decodeDoubleForKey("WorkAge")
        self.DirectBossEmpCode = aDecoder.decodeObjectForKey("DirectBossEmpCode") as? String
        self.DirectBossEmpName = aDecoder.decodeObjectForKey("DirectBossEmpName") as? String
        self.SuperiorBossEmpCode = aDecoder.decodeObjectForKey("SuperiorBossEmpCode") as? String
        self.SuperiorBossEmpName = aDecoder.decodeObjectForKey("SuperiorBossEmpName") as? String
        self.CompanyCodeSel = aDecoder.decodeObjectForKey("CompanyCodeSel") as? String
        self.ProfitSel = aDecoder.decodeObjectForKey("ProfitSel") as? String
    }
    
    func encodeWithCoder(aCoder:NSCoder){
        
        aCoder.encodeObject(empCode, forKey: "empCode")
        aCoder.encodeObject(EmpName, forKey: "EmpName")
        aCoder.encodeObject(pwd, forKey: "pwd")
        aCoder.encodeObject(CompanyCode, forKey: "CompanyCode")
        aCoder.encodeObject(CompanyName, forKey: "CompanyName")
        aCoder.encodeObject(Profit, forKey: "Profit")
        aCoder.encodeObject(EnglishName, forKey: "EnglishName")
        aCoder.encodeObject(Gender, forKey: "Gender22")
        aCoder.encodeObject(Birthday, forKey: "Birthday")
        aCoder.encodeObject(Email, forKey: "Email")
        aCoder.encodeObject(Telephone, forKey: "Telephone")
        aCoder.encodeObject(DeptCode, forKey: "DeptCode")
        aCoder.encodeObject(DeptName, forKey: "DeptName")
        aCoder.encodeObject(SalaryLevel, forKey: "SalaryLevel")
        aCoder.encodeDouble(WorkAge, forKey: "WorkAge")
        aCoder.encodeObject(DirectBossEmpCode, forKey: "DirectBossEmpCode")
        aCoder.encodeObject(DirectBossEmpName, forKey: "DirectBossEmpName")
        aCoder.encodeObject(SuperiorBossEmpCode, forKey: "SuperiorBossEmpCode")
        aCoder.encodeObject(SuperiorBossEmpName, forKey: "SuperiorBossEmpName")
        aCoder.encodeObject(CompanyCodeSel, forKey: "CompanyCodeSel")
        aCoder.encodeObject(ProfitSel, forKey: "ProfitSel")
    }
}

struct DataHelper {
    
    struct SaveKey{
    
        static let user:String = "data_user"
    }
    
    static func saveDataInUserDefaults(key:String,value:AnyObject?){
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setObject(value, forKey: key)
        
        userDefaults.synchronize()
        
    }
    
    static func getDataInUserDefaults(key:String)->AnyObject?{
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.objectForKey(key)
    }
    
    static func delDataInUserDefaults(key:String){
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.removeObjectForKey(key)
        
        userDefaults.synchronize()
    }
    
    static func delUser(){
        
        delDataInUserDefaults(SaveKey.user)
    }
    
    static func saveUser(user:DataUser){
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(user)
        saveDataInUserDefaults(SaveKey.user, value: data)
    }
    
    static func getUser()->DataUser?{
        
        if let data = getDataInUserDefaults(SaveKey.user){
            
            if let userData = data as? NSData{
                
                if let user = NSKeyedUnarchiver.unarchiveObjectWithData(userData) as? DataUser{
                    
                    return user
                }
            }
        }
        
        return nil
    }
    
    static func isLogin()->Bool{
        
        return getUser() != nil
    }
}
