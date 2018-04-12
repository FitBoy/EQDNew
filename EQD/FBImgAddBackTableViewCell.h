//
//  FBImgAddBackTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/28.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FBImgAddBackTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *IV_add;
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong)  UILabel *L_label;
/// imgurl 可以为空
-(void)setdataWithtitle:(NSString*)title  img:(UIImage*)imgurl;
@end
