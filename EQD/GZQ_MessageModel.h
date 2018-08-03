//
//  GZQ_MessageModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/4/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GZQ_MessageModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* commentContent;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* objectGuid;
@property (nonatomic,copy) NSString* parentId;
@property (nonatomic,copy) NSString* staffName;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* workCircleId;
@property (nonatomic,copy) NSString* workCircleImageUrl;
@property (nonatomic,assign) float cellHeight;
///日志的Id
@property (nonatomic,copy) NSString* dailyId;
-(NSString*)createTime;
@end
