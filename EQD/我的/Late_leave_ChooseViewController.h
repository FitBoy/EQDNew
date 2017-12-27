//
//  Late_leave_ChooseViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "DaKaJiLu.h"

@interface Late_leave_ChooseViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
///迟到早退 1； 漏打卡 2
@property (nonatomic,assign) NSInteger isLater;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@end

@protocol Late_leave_ChooseViewControllerDelegate <NSObject>

-(void)dakaModelArr:(NSArray*)modelArr indexPath:(NSIndexPath*)indexPath dateStr:(NSString*)date;

@end

