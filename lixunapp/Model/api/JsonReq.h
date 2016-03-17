//
//  JsonReq.h
//  lixunapp
//
//  Created by shahuaitao on 16/3/15.
//  Copyright © 2016年 com.hexin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JsonReq : JSONModel

@property (nonatomic,copy,nonnull) NSString* uri;

-(nonnull NSString*) formatParams;

@end

@interface JsonResp : JSONModel

@end

#pragma mark - 获取备料或者发料信息
@interface GetFatFeedListReq : JsonReq

@property (nonatomic,copy,nonnull) NSString* empCode;
@property (nonatomic,copy,nonnull) NSString* orderByEnum;
@property (nonatomic,copy,nullable) NSString* line;
@property (nonatomic,copy,nullable) NSString* objectLine;
@property (nonatomic,copy,nullable) NSString* companyCode;
@property (nonatomic,copy,nullable) NSString* profit;
// 0 发料  1 备料
@property (assign) int type;
@property (assign) int page;

@end

@interface FatFeed : JSONModel

@property (nonatomic, copy, nullable) NSString *tc_imc02;

@property (nonatomic, copy, nullable) NSString *gen021;

@property (nonatomic, copy, nullable) NSString *sfpud15;

@property (nonatomic, copy, nullable) NSString *sfs03;

@property (nonatomic, copy, nullable) NSString *ima02;

@property (nonatomic, copy, nullable) NSString *sfs08;

@property (nonatomic, copy, nullable) NSString *sfp02;

@property (nonatomic, copy, nullable) NSString *sfp07;

@property (nonatomic, assign) NSInteger sfs02;

@property (nonatomic, copy, nullable) NSString *sfs07;

@property (nonatomic, copy, nullable) NSString *sfpuser;

@property (nonatomic, copy, nullable) NSString *sfsud06;

@property (nonatomic, copy, nullable) NSString *imaud10;

@property (nonatomic, copy, nullable) NSString *sfs01;

@property (nonatomic, copy, nullable) NSString *sfa06;

@property (nonatomic, copy, nullable) NSString *gen022;

@property (nonatomic, copy, nullable) NSString *sfpud06;

@property (nonatomic, copy, nullable) NSString *ima021;

@property (nonatomic, copy, nullable) NSString *ima23;

@property (nonatomic, copy, nullable) NSString *sfa05;

@property (nonatomic, copy, nullable) NSString *sfs05;

@property (nonatomic, copy, nullable) NSString *img10;

@property (nonatomic, copy, nullable) NSString *sfs04;

@property (nonatomic, copy, nullable) NSString *sfs09;

@end




//登录校验并返回人员资料和菜单与权限
@interface GetLoginSessionReq : JsonReq
@property (nonatomic,copy,nonnull) NSString* empCode;
@property (nonatomic,copy,nonnull) NSString* pwd;
@end


@interface GetLoginPermission : JSONModel

@property (nonatomic,copy,nonnull) NSString* Name;
@property (nonatomic,copy,nullable) NSString* Url;

@end

@protocol GetLoginPermission <NSObject>

@end

@interface GetLoginAppSession : JSONModel

@property (nonatomic,copy,nullable) NSString* EmpCode;
@property (nonatomic,copy,nullable) NSString* EmpName;
@property (nonatomic,copy,nullable) NSString* DeptCode;
@property (nonatomic,copy,nullable) NSString* DeptName;
@property (nonatomic,copy,nullable) NSString* CompanyCode;
@property (nonatomic,copy,nullable) NSString* CompanyName;
@property (nonatomic,copy,nullable) NSString* Email;
@property (nonatomic,copy,nullable) NSString* Telephone;
@property (nonatomic,copy,nullable) NSString* EnglishName;
@property (nonatomic,copy,nullable) NSString* Gender;
@property (nonatomic,copy,nullable) NSString* Profit;
@property (nonatomic,copy,nullable) NSString* Birthday;
@property (nonatomic,copy,nullable) NSString* SalaryLevel;
@property (nonatomic,strong,nullable) NSArray<GetLoginPermission,ConvertOnDemand>* Permissions;

@end

@interface GetLoginSessionResp : JsonResp

@property (nonatomic,strong,nullable) GetLoginAppSession* AppSession;
@property (assign) bool IsSuccess;
@property (nonatomic,copy,nullable) NSString* ErrMsg;


@end

#pragma mark 获取营运中心和利润中心
@interface GetProfitListReq : JsonReq

@property (nonatomic,copy,nonnull) NSString* empCode;

@end

@interface GetProfitListBean : JSONModel

@property (nonatomic,copy,nonnull) NSString* CompanyCode;
@property (nonatomic,copy,nullable) NSString* Profit;
@property (nonatomic,copy,nullable) NSString* Name;

@end

#pragma mark 获取轮播图
@interface GetCarouselPhotoReq : JsonReq

@end

@interface GetCarouselPhotoBean : JSONModel

@property (nonatomic,copy,nullable) NSString* PictureName;
@property (nonatomic,copy,nullable) NSString* ImagePath;
@property (nonatomic,copy,nullable) NSString* JumpPath;

@end

