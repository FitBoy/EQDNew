//
//  FBDaKa_TableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 上班打卡的cell

#import <UIKit/UIKit.h>
#import "FBButton.h"
#import <YYText.h>
#import "DaKaJiLu.h"
@interface FBDaKa_TableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_left1;
@property (nonatomic,strong) FBButton *B_right;
@property (nonatomic,strong)  YYLabel *L_right;
@property (nonatomic,strong)  NSArray *arr_jilu;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,weak) id delegate;

@property (nonatomic,strong)  DaKaJiLu *model;
-(void)setModel:(DaKaJiLu *)model;


@end
@protocol FBDaKa_TableViewCellDelegate <NSObject>
-(void)clocktime:(NSString*)clocktime indexpath:(NSIndexPath*)indexPath clockid:(NSString*)clockID;;

@end
