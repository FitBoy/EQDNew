//
//  SC_maiMaiAddViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface SC_maiMaiAddViewController : FBBaseViewController
@property (nonatomic,copy) NSString* productId;
/// 0 供方  1 买方  2 供方信息修改 3 买方信息修改  4需求  5 需求的修改
@property (nonatomic,assign) NSInteger temp;

///供方或者买方的Id
@property (nonatomic,copy) NSString* demandId;
@end
