//
//  WS_liuYanModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/30.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WS_liuYanModel : NSObject
@property (nonatomic,copy) NSString* DepartId;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* Message;
@property (nonatomic,copy) NSString* ParentId;
@property (nonatomic,copy) NSString* PostId;
@property (nonatomic,copy) NSString* com_name;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* departName;
@property (nonatomic,copy) NSString* firstId;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* parentCompany;
@property (nonatomic,copy) NSString* parentCompanyId;
@property (nonatomic,copy) NSString* parentDepartId;
@property (nonatomic,copy) NSString* parentDepartment;
@property (nonatomic,copy) NSString* parentPost;
@property (nonatomic,copy) NSString* parentPostId;
@property (nonatomic,copy) NSString* parentStaffName;
@property (nonatomic,copy) NSString* parentUserGuid;
@property (nonatomic,copy) NSString* parentiphoto;
@property (nonatomic,copy) NSString* parentupname;
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* staffName;
@property (nonatomic,copy) NSString* upname;
@property (nonatomic,copy) NSString* userCompanyId;
@property (nonatomic,strong) NSArray *childList;
@property (nonatomic,assign)float cell_height;
-(NSString*)createTime;
@end
