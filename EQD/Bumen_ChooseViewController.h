//
//  Bumen_ChooseViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 部门的选择

#import "FBBaseViewController.h"
#import "ZUZhi_ExpandTableViewCell.h"
@interface Bumen_ChooseViewController : FBBaseViewController
@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,weak) id delegate;
@end
@protocol Bumen_ChooseViewControllerDelegate <NSObject>

-(void)getBumenModel:(ZuZhiModel*)model  indexPath:(NSIndexPath*)indexPath;

@end
