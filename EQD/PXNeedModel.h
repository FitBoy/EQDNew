//
//  PXNeedModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/2/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXNeedModel : NSObject
@property (nonatomic,copy) NSString* betrainedPostId;
@property (nonatomic,copy) NSString* budgetedExpense;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* keywords;
@property (nonatomic,copy) NSString* otherDemand;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* theCategory;
@property (nonatomic,copy) NSString* thecategory;
@property (nonatomic,copy) NSString *Id; //最新更改的搜索结果返回的

@property (nonatomic,copy) NSString* theTheme;
@property (nonatomic,copy) NSString* thetheme;
@property (nonatomic,copy) NSString* thedateEnd;
@property (nonatomic,copy) NSString* thedateStart;
@property (nonatomic,copy) NSString* theplace;
@property (nonatomic,copy) NSString* trainees;
@property (nonatomic,assign) float cellHeight;
@property (nonatomic,copy) NSString* type;

-(NSString*)createTime;
-(NSString*)thedateStart;
-(NSString*)thedateEnd;
/*查看培训需求
 {
 Id = 24;
 betrainedPostId = "103,102,104,105,123";
 budgetedExpense = 3080;
 comName = "\U6613\U4f01\U70b9";
 createTime = "2018/3/8 17:31:45";
 demandStatus = 1;
 keywords = 3080;
 otherDemand = "\U5e74\U524d\U57f9\U8bad \Uff0c\U5e74\U540e\U57f9\U8bad\Uff0c\U3002\U3002\U3002\U3002\U968f\U4fbf\U5199";
 status = 0;
 theCategory = "\U6536\U6b3e\U6280\U5de7,\U6e20\U9053\U9500\U552e,\U751f\U4ea7\U6210\U672c";
 theTheme = "\U5e74\U540e\U7b2c\U4e00\U6b21\U57f9\U8bad \Uff0c\U9700\U8981\U627e\U4e00\U4e2a\U8bb2\U5e08";
 thedateEnd = "2018/4/9 0:00:00";
 thedateStart = "2018/3/9 0:00:00";
 theplace = "\U90d1\U5ddeCBD1\U697c\U5927\U5385";
 trainees = ".net\U540e\U53f0,\U8d1f\U8d23\U4eba,\U5b89\U5353,web\U524d\U7aef,UI";
 comid = 46;
 company = "\U90d1\U5dde\U6613\U4f"
 }
 */
@property (nonatomic,copy) NSString* comName;
@property (nonatomic,copy) NSString* demandStatus;

/*需求详情*/
@property (nonatomic,copy) NSString* applyId;
@property (nonatomic,copy) NSString* lecturerIndustry;
@property (nonatomic,copy) NSString* lecturerAddress;
@property (nonatomic,copy) NSString* lecturerEducation;
@property (nonatomic,copy) NSString* lecturerJinJIShuXiang;
@property (nonatomic,copy) NSString* lecturerLanguages;
@property (nonatomic,copy) NSString* lecturerMagor;
@property (nonatomic,copy) NSString* lecturerMaxAge;
@property (nonatomic,copy) NSString* lecturerMinAge;
@property (nonatomic,copy) NSString* lecturerPost;
@property (nonatomic,copy) NSString* lecturerSex;
@property (nonatomic,copy) NSString* lecturerShuXiang;
@property (nonatomic,copy) NSString* lecturerWorkBackground;
@property (nonatomic,copy) NSString* lecturerZhiCheng;
@property (nonatomic,copy) NSString* lecturerSexdes;
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* companyId;
-(NSString*)lecturerSexdes;

/*
 {
 applyId = 54;
 budgetedExpense = 5000;
 contacts = 4f47e8c7e40541d4a2f03c3c72304252;
 createTime = "2018-09-04T14:01:00.957";
 demandStatus = 1;
 id = 2;
 keywords = 5000;
 lecturerAddress = "\U5e38\U4f4f\U5730\U8981\U6c42 \U90d1\U5dde\Uff0c\U5317\U4e0a\U5e7f";
 lecturerEducation = "\U672c\U79d1\U4ee5\U4e0a\Uff0c\U5176\U4ed6\U52ff\U6270";
 lecturerIndustry = "\U57f9\U8bad\U7ba1\U7406,\U6559\U7ec3\U6280\U672f,\U6c99\U76d8\U6280\U672f,\U884c\U52a8\U5b66\U4e60,\U6f14\U8bb2\U53e3\U624d";
 lecturerJinJIShuXiang = "\U9a6c  \U7f8a";
 lecturerLanguages = "\U5fb7\U8bed\U6388\U8bfe \U82f1\U8bed\U4f18\U5148 \U6c49\U8bed\U66f4\U597d\U3002\U76ae\U4e00\U4e0b";
 lecturerMagor = "\U4e0d\U9650";
 lecturerMaxAge = 33;
 lecturerMinAge = 17;
 lecturerPost = "\U62c5\U4efb\U804c\U52a1 \U8981\U6c42";
 lecturerSex = 0;
 lecturerShuXiang = "\U9f99  \U86c7";
 lecturerWorkBackground = "\U5de5\U4f5c\U5317\U4eac\U8981\U6c42";
 lecturerZhiCheng = "\U804c\U79f0\U8981\U6c42\U3002\U7ecf\U7406 \U4ee5\U4e0a";
 otherDemand = "\U90d1\U5dde \U57f9\U8bad\Uff0c \U51c6\U65f6";
 status = 0;
 theCategory = "\U4e16\U754c\U5496\U5561,\U5bf9\U516c\U8425\U9500,\U6d3b\U52a8\U7b56\U5212,\U73b0\U573a\U7ba1\U7406,\U8206\U60c5\U7ba1\U7406";
 theTheme = "asp.net";
 thedateEnd = "2018-12-04T00:00:00";
 thedateStart = "2018-11-04T00:00:00";
 theplace = "\U90d1\U5dde CBD \U751f\U6d3b\U5e7f\U573a";
 };
 */

@end
