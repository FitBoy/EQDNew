//
//  FBTwo_SwitchTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
#import "FBindexPathSwitch.h"
@interface FBTwo_SwitchTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView  *V_bg;
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_left1;
@property (nonatomic,strong)  FBindexPathSwitch *S_kai;
@property (nonatomic,strong)  FBBaseModel *model ;
-(void)setModel:(FBBaseModel *)model;
@end
