//
//  GZQ_PingLunModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GZQ_PingLunModel : NSObject
///被评论人的昵称
@property (nonatomic,copy) NSString* before;
///被评论人的真实姓名
@property (nonatomic,copy) NSString* beforeName;
@property (nonatomic,copy) NSString*Id;
@property (nonatomic,strong)  NSArray *children;
@property (nonatomic,copy) NSString* WorkCircleId;
@property (nonatomic,copy) NSString* CompanyId;
@property (nonatomic,copy) NSString* ParentId;
@property (nonatomic,copy) NSString* Message;
@property (nonatomic,copy) NSString* Creater;
@property (nonatomic,copy) NSString* CreateTime;
@property (nonatomic,copy) NSString* PostId;
@property (nonatomic,copy) NSString* DepartId;
@property (nonatomic,copy) NSString* upname;
@property (nonatomic,copy) NSString* departName;
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* staffName;

@end
