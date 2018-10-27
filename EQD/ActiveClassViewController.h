//
//  ActiveClassViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/10/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 活动的类别

#import "FBBaseViewController.h"

@interface ActiveClassViewController : FBBaseViewController
@property (nonatomic,weak) id delegate_activity;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end
@protocol ActiveClassViewControllerDelegate <NSObject>
-(void)getClass:(NSString*)activeClass withIndexPath:(NSIndexPath*)indexPath;
@end
