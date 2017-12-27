//
//  FBCreateQunZuTableViewCell.h
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FBCreateQunZuTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *IV_choose;
@property (nonatomic,strong)  UIImageView *IV_headimg;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,assign) BOOL isChoose;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
