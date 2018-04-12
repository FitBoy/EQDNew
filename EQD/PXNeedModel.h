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
@property (nonatomic,copy) NSString* theTheme;
@property (nonatomic,copy) NSString* thedateEnd;
@property (nonatomic,copy) NSString* thedateStart;
@property (nonatomic,copy) NSString* theplace;
@property (nonatomic,copy) NSString* trainees;
@property (nonatomic,assign) float cellHeight;
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
 }
 */
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* comName;
@property (nonatomic,copy) NSString* demandStatus;



@end
