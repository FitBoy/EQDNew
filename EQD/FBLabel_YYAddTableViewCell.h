//
//  FBLabel_YYAddTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/2/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "SC_needModel.h"
@interface FBLabel_YYAddTableViewCell : UITableViewCell
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  YYLabel *YL_content;

@property (nonatomic,strong) SC_needModel  *model_need;
-(void)setModel_need:(SC_needModel *)model_need;


@end
