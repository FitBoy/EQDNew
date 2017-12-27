//
//  YGShanXuanViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface YGShanXuanViewController : FBBaseViewController
@property (nonatomic,assign) id delegate;
@end
@protocol  YGShanXuanViewControllerDelegate <NSObject>
-(void)bumen:(NSString*)bumen startTime:(NSString*)startTime endTime:(NSString*)endTime;
@end

