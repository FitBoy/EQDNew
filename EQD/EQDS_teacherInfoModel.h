//
//  EQDS_teacherInfoModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQDS_teacherInfoModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* LecturerBackground;
@property (nonatomic,copy) NSString* PersonalProfile;
@property (nonatomic,copy) NSString* ResearchField;
@property (nonatomic,copy) NSString* WorkingMethod;
@property (nonatomic,copy) NSString* city;
@property (nonatomic,copy) NSString* courses;
@property (nonatomic,copy) NSString* headimage;
@property (nonatomic,copy) NSString* realname;
@property (nonatomic,copy) NSString* userGuid;

@property (nonatomic,assign) float cellHeight;
@end
