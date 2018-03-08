//
//  PhotoModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* imageCount;
@property (nonatomic,copy) NSString* imageUrl;
@property (nonatomic,copy) NSString* title;
/*
 {
 Id = 104;
 createTime = "2018-02-06T10:17:51.81";
 creater = 33c6bdfc281c48c3871d85a2718620e9;
 imageName = "Simulator Screen Shot - iPhone X - 2017-11-27 at 16.00.40.png";
 imageUrl = "https://www.eqid.top:8009/image/20180206/18020610175170690.png";
 menuId = 25;
 }
 */
@property (nonatomic,copy) NSString* imageName;
@property (nonatomic,copy) NSString* menuId;

@end
