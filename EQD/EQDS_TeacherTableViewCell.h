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
#import "EQDS_courseNewModel.h"
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
-(void)setModel3:(EQDS_teacherInfoModel *)model;\

// 搜索到的课程
@property (nonatomic,strong)  EQDS_courseNewModel *model_course;
-(void)setModel_course:(EQDS_courseNewModel *)model_course;
@end
@protocol EQDS_TeacherTableViewCellDelegate <NSObject>
-(void)getlable:(NSString*)label Withmodel:(id)model;
@end
