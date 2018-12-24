//
//  BPCenterTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/11/12.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBButton.h"
#import "BP_renwuModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BPCenterTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *L_title;
@property (nonatomic,strong) UIImageView *IV_img;
@property (nonatomic,strong) UILabel *L_jifen;
@property (nonatomic,strong) FBButton *btn_right;

@property (nonatomic,strong) BP_renwuModel *model_renwu;
-(void)setModel_renwu:(BP_renwuModel * _Nonnull)model_renwu;
@end

NS_ASSUME_NONNULL_END
