//
//  Need_searchTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/12/24.
//  Copyright © 2018 FitBoy. All rights reserved.
// 培训需求的cell

#import <UIKit/UIKit.h>
#import "PXNeedModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Need_searchTableViewCell : UITableViewCell
@property (nonatomic,strong)  UILabel *L_left;
@property (nonatomic,strong)  UILabel *L_right;

@property (nonatomic,strong)  PXNeedModel *model_need;
-(void)setModel_need:(PXNeedModel * _Nonnull)model_need;




@end

NS_ASSUME_NONNULL_END
