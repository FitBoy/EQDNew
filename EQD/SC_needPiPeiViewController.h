//
//  SC_needPiPeiViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 匹配的产品

#import "FBBaseViewController.h"

@interface SC_needPiPeiViewController : FBBaseViewController
///  2 == 企业id
@property (nonatomic,copy) NSString* Id;
/// 0 供方需求的匹配  1 买方需求的匹配 2收藏的产品
@property (nonatomic,assign) NSInteger temp;

@end
