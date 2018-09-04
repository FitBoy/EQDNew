//
//  FX_caigouTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/8/29.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "FBButton.h"
#import "SC_needModel.h"
@interface FX_caigouTableViewCell : UITableViewCell
@property (nonatomic,strong)  YYLabel *YL_contents;
@property (nonatomic,strong)  FBButton *B_btn;
@property (nonatomic,strong)  SC_needModel *model_caigou;
-(void)setModel_caigou:(SC_needModel *)model_caigou;
@end
