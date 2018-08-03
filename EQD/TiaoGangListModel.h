//
//  TiaoGangListModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TiaoGangListModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* changeDepartment;
@property (nonatomic,copy) NSString* changePost;
@property (nonatomic,copy) NSString* changer;
@property (nonatomic,copy) NSString* changerName;
@property (nonatomic,copy) NSString* code;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,assign) float cell_height;
-(NSString*)createTime;

/*详情多出来的字段*/
@property (nonatomic,copy) NSString* ApprovedChecker;
@property (nonatomic,copy) NSString* allChecker;
@property (nonatomic,copy) NSString* changeDepartmentId;
@property (nonatomic,copy) NSString* changePostId;
@property (nonatomic,copy) NSString* changerPhoto;
@property (nonatomic,copy) NSString* changerPost;
@property (nonatomic,copy) NSString* changerStaffName;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* createrDepartment;
@property (nonatomic,copy) NSString* createrPhoto;
@property (nonatomic,copy) NSString* createrPost;
@property (nonatomic,copy) NSString* createrStaffName;
@property (nonatomic,copy) NSString* createruName;
@property (nonatomic,copy) NSString* departmentId;
@property (nonatomic,copy) NSString* implementTime;
-(NSString*)implementTime;
@property (nonatomic,copy) NSString* nextChecker;
@property (nonatomic,copy) NSString* nextCheckerName;
@property (nonatomic,copy) NSString* postId;
@property (nonatomic,copy) NSString* reason;
@property (nonatomic,copy) NSString* salary;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* step;

@end
