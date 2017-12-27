//
//  FBMessageCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBMessageCell.h"
#import "FBGeRenCardMessageContent.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
@implementation FBMessageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)setDataModel:(RCMessageModel *)model
{
    [super  setDataModel:model];
    CGRect rect =self.messageContentView.frame;
    CGSize size =rect.size;
    
    //拉伸图片
    if (MessageDirection_RECEIVE == model.messageDirection) {
        
        [self.bubbleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.messageContentView);
            make.bottom.mas_equalTo(self.messageContentView.mas_bottom).mas_offset(-10);
        }];
        
        
//        self.bubbleBackgroundView.frame =CGRectMake(0, 0, size.width, size.height);
        [self.IV_headimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bubbleBackgroundView.mas_left).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.mas_equalTo(self.bubbleBackgroundView.mas_top).mas_offset(5);
        }];
        
//        self.IV_headimg.frame=CGRectMake(10, 5, 40, 40);
        [self.L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.left.mas_equalTo(self.IV_headimg.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.IV_headimg.mas_top);
            make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-5);
        }];
        
//        self.L_name.frame=CGRectMake(55, 5, size.width-65, 24);
        [self.L_company mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(self.IV_headimg.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.L_name.mas_bottom);
            make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-5);
        }];
        
//        self.L_company.frame=CGRectMake(55, 29, size.width-65, 15);
//        self.V_single.frame =CGRectMake(7, 49, size.width-10, 1);
        [self.V_single mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.mas_equalTo(self.IV_headimg.mas_left);
            make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-5);
            make.bottom.mas_equalTo(self.L_mingpian.mas_top).mas_offset(-2);
        }];
        
        [self.L_mingpian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(self.IV_headimg.mas_left);
            make.bottom.mas_equalTo(self.bubbleBackgroundView.mas_bottom).mas_offset(-5);
            make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-5);
        }];
        
//        self.L_mingpian.frame =CGRectMake(7, 53, size.width-7, 15);
        
        //        chat_from_bg_normal
        
        UIImage *image = [RCKitUtility imageNamed:@"chat_from_bg_normal"
                                         ofBundle:@"RongCloud.bundle"];
        self.bubbleBackgroundView.image = [image
                                           resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8,
                                                                                        image.size.width * 0.8,
                                                                                        image.size.height * 0.2,
                                                                                        image.size.width * 0.2)];
        [image stretchableImageWithLeftCapWidth:20 topCapHeight:20];
        
        
    } else {
        [self.bubbleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.messageContentView);
            make.bottom.mas_equalTo(self.messageContentView.mas_bottom).mas_offset(-10);

        }];
//        self.bubbleBackgroundView.frame =CGRectMake(0, 0, size.width, size.height);
        [self.IV_headimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bubbleBackgroundView.mas_left).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.mas_equalTo(self.bubbleBackgroundView.mas_top).mas_offset(5);
        }];

//        self.IV_headimg.frame=CGRectMake(10, 5, 40, 40);
        [self.L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.left.mas_equalTo(self.IV_headimg.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.IV_headimg.mas_top);
            make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-10);
        }];
//        self.L_name.frame=CGRectMake(55, 5, size.width-62, 24);
        [self.L_company mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(self.IV_headimg.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.L_name.mas_bottom);
            make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-10);
        }];
//        self.L_company.frame=CGRectMake(55, 30, size.width-62, 15);
        [self.V_single mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.mas_equalTo(self.IV_headimg.mas_left);
            make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-10);
            make.bottom.mas_equalTo(self.L_mingpian.mas_top).mas_offset(-2);
        }];
        
        [self.L_mingpian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(self.IV_headimg.mas_left);
            make.bottom.mas_equalTo(self.bubbleBackgroundView.mas_bottom).mas_offset(-5);
            make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).mas_offset(-10);
        }];
//        self.V_single.frame=CGRectMake(0, 49, size.width-10, 1);
//        self.L_mingpian.frame =CGRectMake(0,53, size.width-7, 15);
        
        
        //   chat_to_bg_normal
        UIImage *image = [RCKitUtility imageNamed:@"chat_to_bg_normal"
                                         ofBundle:@"RongCloud.bundle"];
        self.bubbleBackgroundView.image = [image
                                           resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8,
                                                                                        image.size.width * 0.2,
                                                                                        image.size.height * 0.2,
                                                                                        image.size.width * 0.8)];
        [image stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    }
    
    FBGeRenCardMessageContent *testMessage = (FBGeRenCardMessageContent *)self.model.content;
    if (testMessage) {
        NSDictionary *dic =testMessage.content;
        
            self.L_name.text =[NSString stringWithFormat:@"%@【%@-%@】",dic[@"name"],dic[@"bumen"],dic[@"gangwei"]];
            self.L_company.text = dic[@"company"];
        
    }

    
    
    
    
    
    
    FBGeRenCardMessageContent *model1 = (FBGeRenCardMessageContent*)model.content;
    NSDictionary *dic =model1.content;
    [self.IV_headimg sd_setImageWithURL:[NSURL URLWithString:dic[@"imgurl"]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    
}

+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight
{
    if(model.isDisplayMessageTime==NO)
    {
        return CGSizeMake(collectionViewWidth, 70+extraHeight) ;
    }else
    {
        return CGSizeMake(collectionViewWidth, 60+extraHeight) ;
    }
   }
- (void)initialize {
    self.bubbleBackgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.messageContentView addSubview:self.bubbleBackgroundView];
    if (!self.IV_headimg) {
        self.IV_headimg =[[UIImageView alloc]init];
        self.IV_headimg.layer.masksToBounds = YES;
        self.IV_headimg.layer.cornerRadius=20;
        [self.messageContentView addSubview:self.IV_headimg];
    }
    if (!self.V_single) {
        self.V_single =[[UIView alloc]init];
        [self.messageContentView addSubview:self.V_single];
        self.V_single.backgroundColor =[UIColor grayColor];
    }
    
    if (!self.L_name) {
         self.L_name = [[UILabel alloc]init];
        self.L_name.font=[UIFont systemFontOfSize:13];
        [self.messageContentView addSubview:self.L_name];
    }
   
    if (!self.L_company) {
        self.L_company=[[UILabel alloc]init];
        [self.messageContentView addSubview:self.L_company];
        self.L_company.font=[UIFont systemFontOfSize:12];
    }
    if (!self.L_mingpian) {
        self.L_mingpian =[[UILabel alloc]init];
        self.L_mingpian.font=[UIFont systemFontOfSize:12];
        self.L_mingpian.textColor = [UIColor grayColor];
        [self.messageContentView addSubview:self.L_mingpian];
    }
    
    
    self.L_mingpian.text = @" 易企点名片";
  
    
    self.bubbleBackgroundView.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc]
     initWithTarget:self
     action:@selector(longPressed:)];
    [self.bubbleBackgroundView addGestureRecognizer:longPress];
    
    UITapGestureRecognizer *textMessageTap = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(tapTextMessage:)];
    textMessageTap.numberOfTapsRequired = 1;
    textMessageTap.numberOfTouchesRequired = 1;
    [self.bubbleBackgroundView addGestureRecognizer:textMessageTap];
    
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
