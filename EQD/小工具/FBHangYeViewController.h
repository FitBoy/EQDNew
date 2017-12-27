//
//  FBHangYeViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/17.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBHangYeViewController : FBBaseViewController
@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,assign) id delegate;

@end
@protocol FBHangYeViewControllerDelegate <NSObject>

-(void)hangye:(NSString*)hangye Withindexpath:(NSIndexPath*)indexpath;

@end
