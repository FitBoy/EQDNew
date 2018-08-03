//
//  FX_MyRiZhiViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/4/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 我的日志

#import "FBBaseViewController.h"

@interface FX_MyRiZhiViewController : FBBaseViewController
/// 0 我的日志  1 查看日志动态 2查看别人的日志 需要别人的guid
@property (nonatomic,assign) NSInteger temp;

@property (nonatomic,copy) NSString* otherGuid;
@end
