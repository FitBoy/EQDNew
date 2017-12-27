//
//  EQDR_leibieViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//   行业类别的选择

#import "FBBaseViewController.h"
#import "FBHnagYeModel.h"

@interface EQDR_leibieViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSArray *arr_se_hangye;
@end
@protocol EQDR_leibieViewControllerDelegate <NSObject>
-(void)getSelectedarr:(NSArray*)arr_hangye;
@end

