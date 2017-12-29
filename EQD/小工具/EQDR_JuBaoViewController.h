//
//  EQDR_JuBaoViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
/*
LYvc.providesPresentationContextTransitionStyle = YES;
LYvc.definesPresentationContext = YES;
LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
*/

#import <UIKit/UIKit.h>

@interface EQDR_JuBaoViewController : UIViewController
/// 0 默认全的   1  减少一个 抄袭或转载 
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,weak) id delegate;
@end
@protocol EQDR_JuBaoViewControllerdelegate <NSObject>
-(void)getJuBaoType:(NSString*)type  text:(NSString*)text;
@end

