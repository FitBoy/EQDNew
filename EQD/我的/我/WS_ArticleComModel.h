//
//  WS_ArticleComModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/2.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 企业文化

#import <Foundation/Foundation.h>
#import "SC_TeamModel.h"
#import "Image_textModel.h"
@interface WS_ArticleComModel : NSObject
@property (nonatomic,copy) NSString* companyId;
///核心价值
@property (nonatomic,strong)  NSArray *ComCoreValues;
///领导活动
@property (nonatomic,strong) NSArray *ComActitivies;
///先进事迹
@property (nonatomic,strong)  NSArray *ComEvent;
///荣誉墙
@property (nonatomic,strong)  NSArray *ComGoodStaff;

@end
