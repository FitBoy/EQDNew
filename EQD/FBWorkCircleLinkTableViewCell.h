//
//  FBWorkCircleLinkTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/31.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 60 固定死的 

#import <UIKit/UIKit.h>

@interface FBWorkCircleLinkTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong)  UILabel *L_name;
-(void)setimg:(NSString*)img name:(NSString*)name  placehoderImage:(NSString*)imgname;

@end
