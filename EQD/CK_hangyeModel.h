//
//  CK_hangyeModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/8/15.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CK_hangyeModel : NSObject
///行业
@property (nonatomic,copy) NSString* Industry;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* createTime;

//岗位
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* type;

///服务方式
@property (nonatomic,copy) NSString* OneDayPrice;
@property (nonatomic,copy) NSString* OneHourPrice;

///服务时间
@property (nonatomic,copy) NSString* startTime;
@property (nonatomic,copy) NSString* endTime;

@end
