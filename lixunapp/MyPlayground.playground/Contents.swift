//: Playground - noun: a place where people can play

import Cocoa

func | (lhs:BorderLine,rhs:BorderLine) -> Int{
    
    return lhs.rawValue | rhs.rawValue
}

func | (lhs:Int,rhs:BorderLine) -> Int{
    
    return lhs | rhs.rawValue
}

func hasBorderLine(value:Int) -> [BorderLine]{
    
    let all:[BorderLine] = [.left,.top,.bottom,.right]
    var result:[BorderLine] = []
    
    all.forEach{
        
        if(value & $0.rawValue > 0){
            result.append($0)
        }
    }
    
    return result
}

enum BorderLine:Int,CustomStringConvertible{
    
    case top = 0b1,right = 0b10,bottom = 0b100,left = 0b1000
    var description:String{
        
        switch self{
            
        case .top:
            return "top"
        case .right:
            return "this is right"
        case .bottom:
            return "bottom"
        case .left:
            return "left"
        }
    }
}

let line = 0

let lines = hasBorderLine(line)

let aa = BorderLine.right
print(aa)

struct Xmla{
    var name:String?
    var time:String?
}

let xmla = Xmla(name: "name1", time: nil)
let mir = Mirror(reflecting: xmla)

for (key,value) in mir.children{
    
    let mir2 = Mirror(reflecting: value)
//    print(mir2.subjectType)
    print("key \(key) value:\(value)")
}

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
    
    func formatDate(format:String)->NSDate?{
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        
        let date = formatter.dateFromString(self)
        
        return date
    }
}

let dateStr = "2015-06-07T22:59:59"

let date = dateStr.formatDate("yyyy-MM-dd'T'HH:mm:ss")

