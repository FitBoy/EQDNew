//
//  EQDR_HeadView.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 易企阅的首页的头  320 *40  tag值 9000 - 9003

#import <UIKit/UIKit.h>
#import "FBButton.h"
@interface EQDR_HeadView : UIView
{
    FBButton *PreBtn;
}
@property (nonatomic,strong)  FBButton  *B_title0;
@property (nonatomic,strong)  FBButton  *B_title1;
@property (nonatomic,strong)  FBButton  *B_title2;
@property (nonatomic,strong)  FBButton  *B_title3;
//小红条
@property (nonatomic,strong)   UIView *V_red;
///每一个上面的标题
-(void)setTitleArr:(NSArray*)arr_title;
///设置选中的按钮
-(void)setBtn:(FBButton*)tbtn;

@end
