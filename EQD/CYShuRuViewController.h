//
//  CYShuRuViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface CYShuRuViewController : FBBaseViewController
@property (nonatomic,assign) id delegate;
@property (nonatomic,strong) NSMutableArray *arr_pre;
@property (nonatomic,strong)  NSArray *arr_shoudong;
@end

@protocol CYShuRuViewControllerDelegate <NSObject>

-(void)numberarr:(NSArray *)numberArr shoudong:(NSArray*)shoudong;

@end
