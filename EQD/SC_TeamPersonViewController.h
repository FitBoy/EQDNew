//
//  SC_TeamPersonViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 团队介绍

#import "FBBaseViewController.h"

@interface SC_TeamPersonViewController : FBBaseViewController
///1 是荣誉墙  2 单纯的查看
@property (nonatomic,assign) NSInteger temp;
@property (nonatomic,copy) NSString* comId;
@end
