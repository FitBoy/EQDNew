//
//  FBOneImg_yyLabelTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
@interface FBOneImg_yyLabelTableViewCell : UITableViewCell
@property (nonatomic,strong)   UIView *V_bg;
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong)  YYLabel  *yyL_context;
@property (nonatomic,strong)  UIImageView *IV_choose;
@property (nonatomic,strong) UILabel  *L_status;
///无选择框的
-(void)setStatusImg:(NSString*)img context:(NSMutableAttributedString*)context statusName:(NSString*)StatusName;
///有选择框的
-(void)setImg:(NSString*)img Context:(NSMutableAttributedString*)context isChoose:(BOOL)isChoose isShow:(BOOL)isshow;
@end
