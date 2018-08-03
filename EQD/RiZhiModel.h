//
//  RiZhiModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/4/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RiZhiModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* TimeSlot;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* result;

@property (nonatomic,copy) NSString* DailyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* isdel;
@property (nonatomic,assign) float cellHeight;

-(NSString*)createTime;
@end
