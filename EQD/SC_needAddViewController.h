//
//  SC_needAddViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/10.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 发布需求

#import "FBBaseViewController.h"

@interface SC_needAddViewController : FBBaseViewController
/// 0是添加  1 是详情
@property (nonatomic,assign) NSInteger temp;

//需求的Id
@property (nonatomic,copy) NSString* Id;

@end
