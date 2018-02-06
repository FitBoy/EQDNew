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
//@property (nonatomic,copy) NSString* posts;
///推荐讲师的guid
@property (nonatomic,copy) NSString* lecture;

///推荐讲师的姓名
@property (nonatomic,copy) NSString* lectureName;
@property (nonatomic,copy) NSString* postIds;
-(NSString*)createTime;
@property (nonatomic,assign) float cell_height;

/**课程详情*/
///讲师简介
@property (nonatomic,copy) NSString* LectureIntroduce;
//讲师的真实姓名
@property (nonatomic,copy) NSString* LectureRealName;
///职位的id集合
@property (nonatomic,copy) NSString* MatchIds;
/// 1 是职位  0是全体
@property (nonatomic,copy) NSString* MatchType;

@property (nonatomic,copy) NSString* PageViews;
/// 1 培训采购 2新增
@property (nonatomic,copy) NSString* SourceCourse;
///讲师来源 1,内部，2,外部-培训采购，3,网络

@property (nonatomic,copy) NSString* Sourcelecturer;

@property (nonatomic,copy) NSString* TrainingId;

@property (nonatomic,copy) NSString* companyId;
///课程大纲
@property (nonatomic,copy) NSString* courseOutlint;
///课程时长
@property (nonatomic,copy) NSString* courseTimes;
@property (nonatomic,copy) NSString* createrDepartName;
@property (nonatomic,copy) NSString* createrName;
@property (nonatomic,copy) NSString* createrPost;
@property (nonatomic,copy) NSString* createrPostId;
@property (nonatomic,copy) NSString* lectureDepartId;
@property (nonatomic,copy) NSString* lectureDepartName;
@property (nonatomic,copy) NSString* lecturePost;
@property (nonatomic,copy) NSString* lecturePostId;
/// 职位名称的数组
@property (nonatomic,copy) NSArray* posts;



@end
