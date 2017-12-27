//
//  LeiBie_GangWeiViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/11/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "OptionModel.h"

@interface LeiBie_GangWeiViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@end
@protocol LeiBie_GangWeiViewControllerDelegate <NSObject>
-(void)leibieModel:(NSArray*)tarr  indexPath:(NSIndexPath*)indexPath;

@end
