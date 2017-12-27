//
//  FBTimeDayViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBTimeDayViewController : FBBaseViewController
@property (nonatomic,assign) id  delegate;
@property (nonatomic,copy) NSString* contentTitle;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,assign)  NSInteger  pikermode;
@property (nonatomic,strong)  NSDate *D_minDate;
@property (nonatomic,strong)  NSDate *D_MaxDate;
@end
@protocol FBTimeDayViewControllerDelegate <NSObject>

-(void)timeDay:(NSString*)time indexPath:(NSIndexPath*)indexPath;

@end
