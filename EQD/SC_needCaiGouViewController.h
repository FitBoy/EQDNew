//
//  SC_needCaiGouViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 发布的需求

#import "FBBaseViewController.h"
#import "SC_needModel.h"
@interface SC_needCaiGouViewController : FBBaseViewController

@property (nonatomic,weak) id delegate_choose;
@end

@protocol SC_needCaiGouViewControllerdelegate <NSObject>
-(void)getNeedModel:(SC_needModel*)tmodel;

@end
