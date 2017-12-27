//
//  FBOneChoose_TongShiViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBOneChoose_TongShiViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSIndexPath *indexpath;
@end
@protocol FBOneChoose_TongShiViewControllerDelegate <NSObject>

-(void)chooseModel:(Com_UserModel*)model indexpath:(NSIndexPath*)indepPath;

@end
