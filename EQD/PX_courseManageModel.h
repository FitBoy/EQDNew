//
//  PX_courseManageModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PX_courseManageModel : NSObject
@property (nonatomic,copy) NSString* PageView;
@property (nonatomic,copy) NSString* courseCode;
@property (nonatomic,copy) NSString* courseTheme;
@property (nonatomic,copy) NSString* courseType;
@property (nonatomic,copy) NSString* createName;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* objecter;
///预算费用
@property (nonatomic,copy) NSString* Costbudget;
@property (nonatomic,copy) NSString* posts;
///推荐讲师的guid
@property (nonatomic,copy) NSString* lecture;

///推荐讲师的姓名
@property (nonatomic,copy) NSString* lectureName;
@property (nonatomic,copy) NSString* postIds;
-(NSString*)createTime;
@property (nonatomic,assign) float cell_height;
@end
