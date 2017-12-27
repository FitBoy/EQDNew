//
//  FBNewFriendTableViewCell.h
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
/*
 好友申请 
 入驻邀请
 
 */
#import <UIKit/UIKit.h>
#import "FBindexpathButton.h"
@interface FBNewFriendTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *IV_headimg;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_date;
@property (nonatomic,strong)  FBindexpathButton *B_btn;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
