//
//  WorkSpace_detailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/13.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 企业空间

#import "FBBaseViewController.h"

@interface WorkSpace_detailViewController : FBBaseViewController
/// 1是单个企业空间  0是全部的企业空间
@property (nonatomic,assign) NSInteger temp;
/// 只有temp ==1 的时候 才有值
@property (nonatomic,copy) NSString *comId;
@end
