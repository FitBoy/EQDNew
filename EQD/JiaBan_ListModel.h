//
//  JiaBan_ListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface JiaBan_ListModel : FBBaseModel
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* endTime;
@property (nonatomic,copy) NSString* overTimeCode;
@property (nonatomic,copy) NSString* startTime;
@property (nonatomic,copy) NSString* ID;
-(NSString*)createTime;
-(NSString*)endTime;
-(NSString*)startTime;
@end
