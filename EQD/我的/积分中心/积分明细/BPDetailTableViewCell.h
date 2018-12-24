//
//  BPDetailTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/11/10.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "BPModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BPDetailTableViewCell : UITableViewCell
@property (nonatomic,strong)  YYLabel  *YL_label;
@property (nonatomic,strong)  UILabel *L_jifen;
@property (nonatomic,strong) BPModel *BP_model;
-(void)setBP_model:(BPModel * _Nonnull)BP_model;
@end

NS_ASSUME_NONNULL_END
