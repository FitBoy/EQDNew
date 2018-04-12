//
//  GZQ_messageTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/4/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZQ_MessageModel.h"
@interface GZQ_messageTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *IV_head;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_time;
@property (nonatomic,strong)  UILabel *L_contents;
@property (nonatomic,strong)  GZQ_MessageModel *model;
-(void)setModel:(GZQ_MessageModel *)model;
@end
