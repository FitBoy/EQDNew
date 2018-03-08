//
//  EQDS_CourseModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/2/26.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQDS_CourseModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* lectCourseId;
@property (nonatomic,copy) NSString* lectCourseTitle;
@property (nonatomic,copy) NSString* lectCourseType;
@property (nonatomic,copy) NSString* lecture;
@property (nonatomic,copy) NSString* lectureName;
@property (nonatomic,assign) float cell_height;
@end
