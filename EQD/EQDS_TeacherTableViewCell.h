//
//  EQDS_TeacherTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/2/26.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "eQDS_teacherAndSearchModel.h"
#import "EQDS_teacherInfoModel.h"
@interface EQDS_TeacherTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView  *IV_head;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_contents;
@property (nonatomic,strong) YYLabel *YL_label;
@property (nonatomic,strong)  eQDS_teacherAndSearchModel  *model;
@property (nonatomic,strong)  EQDS_teacherInfoModel *model_teacher;
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong) EQDS_teacherInfoModel *model2;
-(void)setModel:(eQDS_teacherAndSearchModel *)model;
-(void)setModel2:(EQDS_teacherInfoModel *)model2;
-(void)setModel3:(EQDS_teacherInfoModel *)model;
@end
@protocol EQDS_TeacherTableViewCellDelegate <NSObject>
-(void)getlable:(NSString*)label Withmodel:(id)model;
@end
