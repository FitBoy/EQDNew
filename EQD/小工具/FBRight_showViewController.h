//
//  FBRight_showViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/4/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//右上角的弹出框
/*
 LYvc.providesPresentationContextTransitionStyle = YES;
 LYvc.definesPresentationContext = YES;
 LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
 */
#import <UIKit/UIKit.h>

@interface FBRight_showViewController : UIViewController
@property (nonatomic,strong)  NSArray *arr_names;
@property (nonatomic,weak) id delegate_right;
@end
@protocol FBRight_showViewControllerDelegate <NSObject>
-(void)getSlectedindex:(NSInteger)index;
@end
