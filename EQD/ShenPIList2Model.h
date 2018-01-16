//
//  ShenPIList2Model.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShenPIList2Model : NSObject
@property (nonatomic,copy) NSString* checkTime;
@property (nonatomic,copy) NSString* checkerGuid;
@property (nonatomic,copy) NSString* checkerName;
@property (nonatomic,copy) NSString* remark;
@property (nonatomic,copy) NSString* theOperation;
@property (nonatomic,assign) float  cellHeight;
-(NSString*)checkTime;
@end
