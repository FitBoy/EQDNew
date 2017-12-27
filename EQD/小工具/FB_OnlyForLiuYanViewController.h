//
//  FB_OnlyForLiuYanViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
/*
 LYvc.providesPresentationContextTransitionStyle = YES;
 LYvc.definesPresentationContext = YES;
 LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
 */

#import <UIKit/UIKit.h>

@interface FB_OnlyForLiuYanViewController : UIViewController
//发送按钮的名称
@property (nonatomic,copy) NSString*  btnName;
@property (nonatomic,copy) NSString* placeHolder;
@property (nonatomic,weak) id delegate;
@end

@protocol FB_OnlyForLiuYanViewControllerDlegate <NSObject>
-(void)getPresnetText:(NSString*)text;

@end

