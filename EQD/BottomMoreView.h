//
//  BottomMoreView.h
//  EQD
//
//  Created by 梁新帅 on 2018/8/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//  一定要先设计好view的frame  40的高度

#import <UIKit/UIKit.h>
#import "FBButton.h"
@interface BottomMoreView : UIView

@property (nonatomic,strong)  FBButton  *B_more;
@property (nonatomic,strong) FBButton  * B_right;
@property (nonatomic,strong) FBButton  * B_center;
-(void)setMorename:(NSString*)more right:(NSString*)right center:(NSString*)center;
@end
