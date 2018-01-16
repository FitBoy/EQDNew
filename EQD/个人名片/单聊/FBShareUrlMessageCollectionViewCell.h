//
//  FBShareUrlMessageCollectionViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import "FBShareMessageContent.h"
@interface FBShareUrlMessageCollectionViewCell : RCMessageCell
@property (nonatomic,strong) UILabel *L_title;
@property (nonatomic,strong)  UILabel *L_content;
@property (nonatomic,strong)  UIImageView  *IV_img;
@property (nonatomic,strong)  UIView *V_view;
@property (nonatomic,strong)  UILabel *L_Source;

-(void)setDataModel:(RCMessageModel *)model;
@property(nonatomic, strong) UIImageView *bubbleBackgroundView;
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight;
@end
