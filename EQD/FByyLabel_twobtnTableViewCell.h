//
//  FByyLabel_twobtnTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/9/6.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "FBButton.h"
#import "PXNeedModel.h"
@interface FByyLabel_twobtnTableViewCell : UITableViewCell
@property (nonatomic,strong)  YYLabel *yy_tlabel;
@property (nonatomic,strong) FBButton *tbtn_left;
@property (nonatomic,strong)  FBButton *tbtn_right;
@property (nonatomic,strong)  PXNeedModel *model_need;
-(void)setModel_need:(PXNeedModel *)model_need;
@end
