//
//  FBImg_label_yyLabelTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/10/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 一张图片 100  + 最多两行的主题  40 +  富文本内容60   110 X 110   

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "CK_huoDongModel.h"
@interface FBImg_label_yyLabelTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView  *IV_img;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  YYLabel *yy_label;

//活动
@property (nonatomic,strong)  CK_huoDongModel *model_huodong;
-(void)setModel_huodong:(CK_huoDongModel *)model_huodong;

-(void)setIMgUrl:(NSString*)imgUrl name:(NSString*)name attrbuteName:(NSAttributedString*)attrbuteName;
@end
