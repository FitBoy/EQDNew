//
//  PX_courseManageModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
/*最新课程
 {
 Id = 70;
 courseTheme = "\U8bfe\U7a0b\U5185\U5bb9";
 courseTimes = 3;
 courseType = "\U5fae\U8bfe,\U6c99\U9f99\U8425\U9500,\U5916\U62d3\U8425\U9500,\U793e\U533a\U8425\U9500";
 createTime = "2018-02-26T14:07:17.31";
 creater = 33c6bdfc281c48c3871d85a2718620e9;
 lectureName = "\U6881\U65b0\U5e05";
 objecter = "\U6388\U8bfe\U5bf9\U8c61iang";
 }
 */
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
@property (nonatomic,copy) NSString* coursePrice;
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
@property (nonatomic,copy) NSArray* posts2;
/* 课程详情
 {
 Id = 72;
 commentCount = 0;
 courseBackground = "sdf sdfh ";
 courseImage =         (
 );
 courseImages = "";
 courseMethod = undefined;
 courseObjecter = sdf;
 courseOutlint = "<p>sfdh&nbsp;</p>";
 coursePrice = 25;
 courseTarget = "sdf ";
 courseTheme = rtsy;
 courseTimes = 3;
 courseType = "\U6c99\U76d8\U6280\U672f";
 courseWareName = "";
 coursewares = "";
 createTime = "2018-03-07T13:38:32.42";
 isdel = "<null>";
 lectureName = "\U6881\U65b0\U5e05";
 status = 0;
 updateTime = "<null>";
 updater = "<null>";
 userGuid = 33c6bdfc281c48c3871d85a2718620e9;
 videoIds = "<null>";
 }
 */
@property (nonatomic,copy) NSString* commentCount;
@property (nonatomic,copy) NSString* courseBackground;
@property (nonatomic,strong) NSArray *courseImage;
@property (nonatomic,copy) NSString* courseImages;
@property (nonatomic,copy) NSString* courseMethod;
@property (nonatomic,copy) NSString* courseObjecter;
//@property (nonatomic,copy) NSString* courseOutlint;
//@property (nonatomic,copy) NSString* coursePrice;
@property (nonatomic,copy) NSString* courseTarget;
//@property (nonatomic,copy) NSString* courseTheme;
//@property (nonatomic,copy) NSString* courseTimes;
//@property (nonatomic,copy) NSString* courseType;
@property (nonatomic,copy) NSString* courseWareName;
@property (nonatomic,copy) NSString* coursewares;
//@property (nonatomic,copy) NSString* createTime;
//@property (nonatomic,copy) NSString* lectureName;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* updateTime;
@property (nonatomic,copy) NSString* updater;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* videoIds;







@end
