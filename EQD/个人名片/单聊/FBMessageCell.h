//
//  FBMessageCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import "FBGeRenCardMessageContent.h"
@interface FBMessageCell : RCMessageCell
@property (nonatomic,strong)  UIImageView *IV_headimg;
@property (nonatomic,strong) UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_company;
@property (nonatomic,strong)  UILabel *L_mingpian;
@property (nonatomic,strong)  UIView *V_single;
-(void)setDataModel:(RCMessageModel *)model;
@property(nonatomic, strong) UIImageView *bubbleBackgroundView;
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight;
@end
