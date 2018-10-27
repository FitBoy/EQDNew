//
//  KeHuChooseViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/9/14.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
/*
 LYvc.providesPresentationContextTransitionStyle = YES;
 LYvc.definesPresentationContext = YES;
 LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
 */

#import "FBBaseViewController.h"
#import "KeHu_ListModel.h"
@interface KeHuChooseViewController : FBBaseViewController
@property (nonatomic,weak) id delegate_kehu;
@end
@protocol KeHuChooseViewControllerDelegate <NSObject>
-(void)getKeHuModel:(KeHu_ListModel*)tmodel;
@end
