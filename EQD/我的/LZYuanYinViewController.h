//
//  LZYuanYinViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface LZYuanYinViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSIndexPath *indexpath;
@end
@protocol LZYuanYinViewControllerDelegate <NSObject>

-(void)reason:(NSString*)reason indexpath:(NSIndexPath*)indexPath;

@end
