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

//收藏的课程
/*
 {
 Id = 43;
 courseId = 86;
 courseImg = "https://www.eqid.top:8009/LectureImage/20180814/2018081411544932118.jpg";
 courseName = "\U8bfe\U7a0b\U4e3b\U9898";
 courseType = "\U6559\U7ec3\U6280\U672f,\U57f9\U8bad\U7ba1\U7406,EXCEL";
 lectureName = "\U6881\U65b0\U5e05";
 }
 */

@property (nonatomic,copy) NSString* courseId;
@property (nonatomic,copy) NSString* courseImg;
@property (nonatomic,copy) NSString* courseName;
@property (nonatomic,copy) NSString* courseType;
//@property (nonatomic,copy) NSString* lectureName;


@end
