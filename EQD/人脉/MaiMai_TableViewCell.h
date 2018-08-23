//
//  MaiMai_TableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/8/21.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaiMaiModel.h"
#import <YYText.h>
#import "FBButton.h"
@interface MaiMai_TableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *IV_head;
@property (nonatomic,strong)  YYLabel *L_contents;
@property (nonatomic,strong)  FBButton *B_add;

@property (nonatomic,strong)  MaiMaiModel  *model_maimai;
-(void)setModel_maimai:(MaiMaiModel *)model_maimai;

@end
