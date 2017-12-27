//
//  RWListTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
//35 + 图片+20
@interface RWListTableViewCell : UITableViewCell
///任务名称
@property (nonatomic,strong) UILabel* L_rwname;
///责任人
@property (nonatomic,strong) UIButton* B_name;
///任务状态  未接受 进行中 完成 延误
@property (nonatomic,strong) UILabel* L_status;
///任务编码
@property (nonatomic,strong) UILabel* L_bianMa;
///任务完成的图片
@property (nonatomic,strong) NSArray <UIImage*>* imgs;
///留言
@property (nonatomic,strong) UIButton *B_liuyan;
///留言数
@property (nonatomic,strong)  UILabel *L_numliuyan;
///点赞
@property (nonatomic,strong)  UIButton *B_zan;
///点赞数  可以点击查看全部点赞的人
@property (nonatomic,strong)  UIButton *B_numzan;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
