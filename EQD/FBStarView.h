//
//  FBStarView.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/12.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBStarView : UIView
{
    NSMutableArray *arr_iviews;
}
///设置星星的数量   初始化 
-(void)setViewWithnumber:(NSInteger)number selected:(NSInteger)index;
/// 这个参数是针对在同一个 view 上出现多个星星点评，用来区分点击的是哪个星星
@property (nonatomic,assign) NSInteger selected_index;
/// 星星的协议代理
@property (nonatomic,weak) id delegate_number;
@end
@protocol FBStarView <NSObject>
///获取星星的评级数
-(void)getNumber:(NSInteger)number selected:(NSInteger)selected;
@end
