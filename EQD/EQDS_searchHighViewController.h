//
//  EQDS_searchHighViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/1.
//  Copyright © 2018年 FitBoy. All rights reserved.
//  易企学的高级搜索

#import "FBBaseViewController.h"

@interface EQDS_searchHighViewController : FBBaseViewController
///0 讲师，1 课程，2视频，3 文章
@property (nonatomic,assign) NSInteger temp;
@property (nonatomic,copy) NSString* searchKey;
@end
