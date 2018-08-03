//
//  TongShiModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Com_UserModel.h"
@interface TongShiModel : NSObject
@property (nonatomic,copy) NSString* CompanyId;
@property (nonatomic,strong) NSArray*  UserInfo;
@property (nonatomic,strong)  NSArray *childs;
@property (nonatomic,copy) NSString* deac;
@property (nonatomic,copy) NSString* departId;
@property (nonatomic,copy) NSString* departName;
@property (nonatomic,copy) NSString* parentId;

@property (nonatomic,assign) NSInteger  cengJi;
@property (nonatomic,assign) BOOL isZheDie;

@property (nonatomic,assign) BOOL isQuanXuan;
@end
