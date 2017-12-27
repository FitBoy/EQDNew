//
//  FBTwo_Button12TableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/17.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBPeople.h"
#import "FBIndexPathButton.h"
///右边带有一个按钮的cell
@interface FBTwo_Button12TableViewCell : UITableViewCell
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_number;
@property (nonatomic,strong)  FBIndexPathButton *B_add;
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  FBPeople *model;
-(void)setModel:(FBPeople *)model;


@end
