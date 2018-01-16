//
//  FBShareUrlMessageCollectionViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBShareUrlMessageCollectionViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FBShareUrlMessageCollectionViewCell
-(void)setDataModel:(RCMessageModel *)model
{
    [super  setDataModel:model];
    CGRect rect =self.messageContentView.frame;
    CGSize size =rect.size;
    FBShareMessageContent *content = (FBShareMessageContent*)model.content;
    NSDictionary  *contentDic = content.content;
    NSString *title = contentDic[@"title"];
    CGSize  sizeTitle = [title boundingRectWithSize:CGSizeMake(size.width-35, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
    self.L_title.text = title;
    self.L_content.text = contentDic[@"content"];
    self.L_Source.text =contentDic[@"source"];
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:contentDic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:@"eqd"]];
    [self.bubbleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self.messageContentView);
    }];
    
     if (MessageDirection_RECEIVE == model.messageDirection) {
         UIImage *image = [RCKitUtility imageNamed:@"chat_from_bg_normal"
                                          ofBundle:@"RongCloud.bundle"];
         self.bubbleBackgroundView.image = [image
                                            resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8,
                                                                                         image.size.width * 0.8,
                                                                                         image.size.height * 0.2,
                                                                                         image.size.width * 0.2)];
         [image stretchableImageWithLeftCapWidth:20 topCapHeight:20];
         
         [self.L_title  mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(self.bubbleBackgroundView.mas_left).mas_offset(15);
             make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-10);
             make.top.mas_equalTo(self.bubbleBackgroundView.mas_top).mas_offset(5);
             make.height.mas_equalTo(sizeTitle.height);
         }];
         [self.IV_img mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.size.mas_equalTo(CGSizeMake(50, 50));
             make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-5);
             make.top.mas_equalTo(self.L_title.mas_bottom).mas_offset(5);
         }];
         [self.L_content mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(50);
             make.left.mas_equalTo(self.bubbleBackgroundView.mas_left).mas_offset(15);
             make.top.mas_equalTo(self.IV_img.mas_top);
             make.right.mas_equalTo(self.IV_img.mas_left).mas_offset(-10);
         }];
         [self.V_view mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(1);
             make.top.mas_equalTo(self.IV_img.mas_bottom).mas_offset(5);
             make.left.mas_equalTo(self.bubbleBackgroundView.mas_left).mas_offset(15);
             make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-10);
         }];
         [self.L_Source mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.size.mas_equalTo(CGSizeMake(100, 16));
             make.left.mas_equalTo(self.bubbleBackgroundView.mas_left).mas_equalTo(20);
             make.top.mas_equalTo(self.V_view.mas_bottom).mas_offset(1);
         }];
         
     }else
     {
         UIImage *image = [RCKitUtility imageNamed:@"chat_to_bg_normal"
                                          ofBundle:@"RongCloud.bundle"];
         self.bubbleBackgroundView.image = [image
                                            resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8,
                                                                                         image.size.width * 0.2,
                                                                                         image.size.height * 0.2,
                                                                                         image.size.width * 0.8)];
         [image stretchableImageWithLeftCapWidth:20 topCapHeight:20];
         
         [self.L_title  mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(self.bubbleBackgroundView.mas_left).mas_offset(10);
             make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-15);
             make.top.mas_equalTo(self.bubbleBackgroundView.mas_top).mas_offset(5);
             make.height.mas_equalTo(sizeTitle.height);
         }];
         [self.IV_img mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.size.mas_equalTo(CGSizeMake(50, 50));
             make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-10);
             make.top.mas_equalTo(self.L_title.mas_bottom).mas_offset(5);
         }];
         [self.L_content mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(50);
             make.left.mas_equalTo(self.bubbleBackgroundView.mas_left).mas_offset(10);
             make.top.mas_equalTo(self.IV_img.mas_top);
             make.right.mas_equalTo(self.IV_img.mas_left).mas_offset(-15);
         }];
         [self.V_view mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(1);
             make.top.mas_equalTo(self.IV_img.mas_bottom).mas_offset(5);
             make.left.mas_equalTo(self.bubbleBackgroundView.mas_left).mas_offset(10);
             make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-15);
         }];
         [self.L_Source mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.size.mas_equalTo(CGSizeMake(100, 16));
             make.left.mas_equalTo(self.bubbleBackgroundView.mas_left).mas_equalTo(25);
             make.top.mas_equalTo(self.V_view.mas_bottom).mas_offset(1);
         }];
     }
    
    
    
}
-(UIImageView*)bubbleBackgroundView
{
    if (!_bubbleBackgroundView) {
        _bubbleBackgroundView = [[UIImageView alloc]init];
        [self.contentView addSubview:_bubbleBackgroundView];
    }
    return _bubbleBackgroundView;
}
-(UILabel*)L_content
{
    if (!_L_content) {
        _L_content = [[UILabel alloc]init];
        _L_content.font = [UIFont systemFontOfSize:12];
        _L_content.numberOfLines=0;
        _L_content.textColor = [UIColor grayColor];
        [self.bubbleBackgroundView addSubview:_L_content];
    }
    return _L_content;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        _IV_img.userInteractionEnabled=YES;
        _IV_img.layer.masksToBounds =YES;
        _IV_img.layer.cornerRadius =4;
        [self.bubbleBackgroundView addSubview:_IV_img];
    }
    return _IV_img;
}
-(UIView*)V_view
{
    if (!_V_view) {
        _V_view = [[UIView alloc]init];
        [self.bubbleBackgroundView addSubview:_V_view];
        _V_view.backgroundColor = [UIColor grayColor];
    }
    return _V_view;
}
-(UILabel*)L_Source
{
    if (!_L_Source) {
        _L_Source = [[UILabel alloc]init];
        _L_Source.font = [UIFont systemFontOfSize:13];
        _L_Source.textColor = [UIColor grayColor];
        [self.bubbleBackgroundView addSubview:_L_Source];
    }
    return _L_Source;
}
-(UILabel*)L_title
{
    if (!_L_title) {
        _L_title = [[UILabel alloc]init];
        _L_title.numberOfLines=2;
        _L_title.font = [UIFont systemFontOfSize:19];
//        _L_title.textAlignment = NSTextAlignmentCenter;
        [self.bubbleBackgroundView addSubview:_L_title];
    }
    return _L_title;
}
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight
{
   
    FBShareMessageContent *content = (FBShareMessageContent*)model.content;
    NSDictionary  *contentDic = content.content;
    NSString *title = contentDic[@"title"];
    CGSize  sizeTitle = [title boundingRectWithSize:CGSizeMake(collectionViewWidth-35, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21]} context:nil].size;
    if(model.isDisplayMessageTime==NO)
    {
        return CGSizeMake(collectionViewWidth, 75+extraHeight+sizeTitle.height) ;
    }else
    {
        return CGSizeMake(collectionViewWidth, 65+extraHeight+sizeTitle.height) ;
    }
}
- (void)tapTextMessage:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(didTapMessageCell:)]) {
        [self.delegate didTapMessageCell:self.model];
    }
}




- (void)longPressed:(id)sender {
    UILongPressGestureRecognizer *press = (UILongPressGestureRecognizer *)sender;
    if (press.state == UIGestureRecognizerStateEnded) {
        return;
    } else if (press.state == UIGestureRecognizerStateBegan) {
        [self.delegate didLongTouchMessageCell:self.model
                                        inView:self.bubbleBackgroundView];
    }
}
@end
