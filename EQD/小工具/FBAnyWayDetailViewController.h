//
//  FBAnyWayDetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/15.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
/*
 全部都是文字的详情
 1 text

 */

#import "FBBaseViewController.h"
#import "AnyWayModel.h"
@interface FBAnyWayDetailViewController : FBBaseViewController
@property (nonatomic,strong) NSArray *arr_json;
@property (nonatomic,copy) NSString* Dtitle;
@end
