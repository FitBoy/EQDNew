//
//  FB_shuXiangViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/9/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FB_shuXiangViewController : FBBaseViewController

@property (nonatomic,weak) id delegate_shuxiang;
@property (nonatomic,copy) NSString* title_;
@property (nonatomic,strong)  NSIndexPath *indexpath;
@end
@protocol FB_shuXiangViewControllerDelegate <NSObject>
-(void)getShuXiangArr:(NSArray *)tarr_shuxiang  indexpath:(NSIndexPath*)indexPath;
@end
