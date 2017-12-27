//
//  FBchengyuanTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/15.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBchengyuanTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *IV_headimg;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_date;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
