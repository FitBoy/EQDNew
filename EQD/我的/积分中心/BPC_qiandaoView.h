//
//  BPC_qiandaoView.h
//  EQD
//
//  Created by 梁新帅 on 2018/11/14.
//  Copyright © 2018 FitBoy. All rights reserved.
// 高度 155

#import <UIKit/UIKit.h>
#import "FBButton.h"
#import "BPqiandaoShow.h"
NS_ASSUME_NONNULL_BEGIN

@interface BPC_qiandaoView : UIView
@property (nonatomic,strong)  FBButton *btn_qiandao;
@property (nonatomic,strong)  NSArray *arr_views;
/**{
BP = 10;
day = 1;
remark = "\U7b7e\U5230\U7b2c\U4e00\U5929";
}*/
-(void)setSenvenViewWitharrScole:(NSArray*)arr_scole;
-(void)updateViewWithindex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
