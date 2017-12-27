//
//  FBMutableChoose_TongShiViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBMutableChoose_TongShiViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSIndexPath *indePath;
///guid组成的数组
@property (nonatomic,strong)  NSArray *arr_Guid;

@end

@protocol FBMutableChoose_TongShiViewControllerDelegate <NSObject>

-(void)mutableChooseArr:(NSArray*)chooses  tarr:(NSArray*)tarr indexPath:(NSIndexPath*)indexPath;

@end
