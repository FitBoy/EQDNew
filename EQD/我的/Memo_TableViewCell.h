//
//  Memo_TableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/12/5.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "Memo_DetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Memo_TableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong) UIView *V_line;
@property (nonatomic,strong) UIImageView *IV_time;
@property (nonatomic,strong) UILabel *L_time;
@property (nonatomic,strong)  UILabel *L_type;
@property (nonatomic,strong)  UIView *V_contents;
@property (nonatomic,strong)  YYLabel *yl_contents;
@property (nonatomic,strong)  UIImageView  *IV_location;
@property (nonatomic,strong) UILabel *L_address;
@property (nonatomic,strong)  Memo_DetailModel *model;
-(void)setModel:(Memo_DetailModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
