//
//  JsonReq.m
//  lixunapp
//
//  Created by shahuaitao on 16/3/15.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

#import "JsonReq.h"

@implementation JsonReq

-(NSString *)formatParams{
    
    NSMutableString *str = [[NSMutableString alloc] init];
    
    NSDictionary* dict = [self toDictionary];
    
    for (NSString* key in dict) {
        
        if([key isEqualToString:@"uri"]){
            
            continue;
        }
        
        if([str length] >0){
            
            [str appendString:@"&"];
        }
        
        [str appendFormat:@"%@=%@",key,dict[key]];
    }
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return true;
}

@end

@implementation JsonResp

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return true;
}

@end

#pragma mark 获取备料或发料信息 start
@implementation GetFatFeedListReq

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        self.uri = @"/GetFatFeedList";
    }
    return self;
}

@end

@implementation FatFeed

+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return true;
}

@end

#pragma mark 登录校验并返回人员资料和菜单与权限 start
@implementation GetLoginSessionReq

-(instancetype)init{
    self = [super init];
    if(self){
        self.uri = @"/GetLoginSession";
    }
    return self;
}

@end

@implementation GetLoginPermission

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return true;
}

@end

@implementation GetLoginAppSession

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return true;
}

@end

@implementation GetLoginSessionResp

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return true;
}

@end

#pragma mark 获取营运中心和利润中心
@implementation GetProfitListReq

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        self.uri = @"/GetProfitList";
    }
    
    return self;
}

@end

@implementation GetProfitListBean

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return true;
}

@end

#pragma mark

@implementation GetCarouselPhotoReq

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        self.uri = @"/GetCarouselPhoto";
    }
    
    return self;
}

@end

@implementation GetCarouselPhotoBean

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return true;
}

@end

