//
//  FBJobViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "JobModel.h"
#import "AllModel.h"
@interface FBJobViewController : FBBaseViewController
@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,assign) id delegate;

@end
@protocol FBJobViewControllerDelegate <NSObject>

-(void)model:(AllModel*)model indexPath:(NSIndexPath*)indexpath;

@end
