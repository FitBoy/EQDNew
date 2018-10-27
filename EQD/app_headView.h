//
//  app_headView.h
//  EQD
//
//  Created by 梁新帅 on 2018/10/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNmodel.h"
#import "IV_lableView.h"
@interface app_headView : UIView
@property (nonatomic,strong)  NSArray *arr_models;
@property (nonatomic,weak) id delegate_appHead;
/// 最多显示两行 如果model的数量超过8个，则显示更多
-(float)resetFrameWithArrModels:(NSArray<GNmodel*>*)arrModels;

@end
@protocol app_headViewDelegate <NSObject>
-(void)appHeadSelectedIndex:(NSInteger)index;

@end
