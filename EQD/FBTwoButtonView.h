//
//  FBTwoButtonView.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 最小50的高度

#import <UIKit/UIKit.h>
#import "FBButton.h"
@interface FBTwoButtonView : UIView
@property (nonatomic,strong) FBButton *B_left;
@property (nonatomic,strong)  FBButton *B_right;
-(void)setleftname:(NSString*)leftname rightname:(NSString*)rightname;
@end
