//
//  SC_ComShoucangViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/30.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 收藏的企业

#import "FBBaseViewController.h"

@interface SC_ComShoucangViewController : FBBaseViewController
/// 0是企业  1是个人收藏的企业
@property (nonatomic,assign) NSInteger temp;
@property (nonatomic,copy) NSString* comId;

///个人收藏的企业 不为空
@property (nonatomic,copy) NSString* userGuid;

@end
