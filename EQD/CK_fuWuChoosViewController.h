//
//  CK_fuWuChoosViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/8/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface CK_fuWuChoosViewController : FBBaseViewController
@property (nonatomic,weak) id delegate_fuwu;
@end
@protocol CK_fuWuChoosViewControllerDelegate <NSObject>
-(void)getFuwu:(NSString*)fuwu dayTime:(NSString*)dayTime hourTime:(NSString*)hourTime index:(NSString*)index;

@end
