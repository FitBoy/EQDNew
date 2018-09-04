//
//  Person_caiGouViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/8/28.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 设置采购人员 或者 销售人员


#import "FBBaseViewController.h"

@interface Person_caiGouViewController : FBBaseViewController
/// 0 销售 1 采购
@property (nonatomic,copy) NSString* type;
@end
