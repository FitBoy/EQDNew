//
//  EQDS_VideoModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/2/27.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 易企学的视频  课程相关视频

#import <Foundation/Foundation.h>

@interface EQDS_VideoModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* describe;
@property (nonatomic,copy) NSString* label;
@property (nonatomic,copy) NSString* realName;
@property (nonatomic,copy) NSString* videoImage;
@property (nonatomic,copy) NSString* videoTitle;
@property (nonatomic,copy) NSString* videoUrl;
@property (nonatomic,copy) NSString* videoTime;
@property (nonatomic,assign) BOOL isChoose;

@property (nonatomic,copy) NSString* vid;
-(NSString*)vid;
/* 推荐视频
 {
 Id = 1;
 lectVideoId = 4;
 lectVideoImage = "https://vthumb.ykimg.com/054204085A73CD610000014A1E0AD6A1";
 lectVideoTitle = "\U300a\U8c08\U5224\U5b98\U300b\U201c\U950b\U8292\U521d\U9732\U201d\U9884\U544a\U7247\U66dd\U5149";
 lectVideoType = "\U6f14\U8bb2\U53e3\U624d";
 lecture = 2aadfbbf6fc54347aedef0751a286a59;
 lectureName = "\U91d1\U5b50";
 videoId = "XMzI0MDU1ODgwOA==";
 }
 */
@property (nonatomic,copy) NSString* lectVideoId;
@property (nonatomic,copy) NSString*lectVideoImage;
@property (nonatomic,copy) NSString* lectVideoTitle;
@property (nonatomic,copy) NSString* lectVideoType;
@property (nonatomic,copy) NSString* lecture;
@property (nonatomic,copy) NSString* lectureName;
@property (nonatomic,copy) NSString* videoId;

@end
