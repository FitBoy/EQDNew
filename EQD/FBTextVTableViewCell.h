//
//  FBTextVTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBTextVTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_content;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
