//
//  Com_dongTanModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZanModel.h"
#import "GZQ_PingLunModel.h"
@interface Com_dongTanModel : NSObject
@property (nonatomic,copy) NSString* DepartId;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* PostId;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* departName;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* location;
@property (nonatomic,strong)  NSArray *imageUrls;
/// 后台返回的字段说明
@property (nonatomic,copy) NSString* message;
/// 所有的对象id
@property (nonatomic,copy) NSString* objectId;
/// 0 发日志 1 发任务  2接收任务 3 完成任务
@property (nonatomic,copy) NSString* options;
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* staffName;
@property (nonatomic,copy) NSString* title;

/// 0 是日志
@property (nonatomic,copy) NSString* type;

///扩展部门
@property (nonatomic,assign) float height_cell;
@property (nonatomic,strong)  NSIndexPath *indexPath_cell;

@property (nonatomic,strong)  NSArray *Comment;
@property (nonatomic,strong)  NSArray *UserZan;
@property (nonatomic,copy) NSString* isZan;
@property (nonatomic,strong)  NSArray *taskComment;
@property (nonatomic,copy) NSString* zanCount;
@property (nonatomic,copy) NSString* commentCount;


-(NSString*)createTime;
@end
