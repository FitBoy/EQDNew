//
//  BQ_AddViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "HaoYouModel.h"

@interface BQ_AddViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSArray *arr_old;
@end
@protocol BQ_AddViewControllerDelegate <NSObject>

-(void)haoyouArr:(NSArray*)arr;

@end
