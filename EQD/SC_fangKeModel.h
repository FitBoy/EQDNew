//
//  SC_fangKeModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/28.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SC_fangKeModel : NSObject
@property (nonatomic,copy) NSString* DepartId;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* PostId;
@property (nonatomic,copy) NSString* com_name;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* departName;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* mudularName;
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* staffName;
@property (nonatomic,copy) NSString* userCompanyId;

@property (nonatomic,copy) NSString* useroption;
@property (nonatomic,copy) NSString* makerGuid;
@property (nonatomic,assign) NSInteger cell_height;
-(NSString*)createTime;
-(NSString*)iphoto;

@end
