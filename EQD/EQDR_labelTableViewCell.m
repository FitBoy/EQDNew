//
//  EQDR_labelTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#define EQDCOLOR   [UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1]

#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
@implementation EQDR_labelTableViewCell

-(void)setModel_base:(EQDS_BaseModel *)model_base
{
    _model_base = model_base;
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"【%@】%@",model_base.staffName,model_base.title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    name.yy_lineSpacing =6;
    CGSize size = [name boundingRectWithSize:CGSizeMake(self.frame.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_base.cellHeight = size.height+20;
    self.YL_label.attributedText =name;
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.height.mas_equalTo(size.height+15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
}

-(void)setModel_base2:(EQDS_BaseModel *)model_base
{
    _model_base = model_base;
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"【%@】%@",model_base.lectureName,model_base.courseTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    name.yy_lineSpacing =6;
    CGSize size = [name boundingRectWithSize:CGSizeMake(self.frame.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_base.cellHeight = size.height+20;
    self.YL_label.attributedText =name;
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.height.mas_equalTo(size.height+15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}
-(void)setModel_RiZhiPingLun:(GZQ_PingLunModel *)model_RiZhiPingLun
{
    _model_RiZhiPingLun = model_RiZhiPingLun;
    NSDictionary *tdic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    NSMutableAttributedString  *name1 =[[NSMutableAttributedString alloc]initWithString:model_RiZhiPingLun.createStaffName attributes:tdic];
    [name1 yy_setTextHighlightRange:name1.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([self.delegate  respondsToSelector:@selector(getPingLunRiZhiModel:Withtemp:)]) {
            [self.delegate getPingLunRiZhiModel:model_RiZhiPingLun Withtemp:0];
        }
    }];
    NSMutableAttributedString *huifu = [[NSMutableAttributedString alloc]initWithString:@"回复" attributes:tdic];
    [name1 appendAttributedString:huifu];
    
    NSMutableAttributedString *name2 = [[NSMutableAttributedString alloc]initWithString:model_RiZhiPingLun.parentStaffName attributes:tdic];
    [name2 yy_setTextHighlightRange:name2.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([self.delegate  respondsToSelector:@selector(getPingLunRiZhiModel:Withtemp:)]) {
            [self.delegate getPingLunRiZhiModel:model_RiZhiPingLun Withtemp:1];
        }
    }];
    [name1 appendAttributedString:name2];
    
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@",model_RiZhiPingLun.content] attributes:tdic];
    [contents yy_setTextHighlightRange:contents.yy_rangeOfAll color:[UIColor blackColor] backgroundColor:[UIColor whiteColor] userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([self.delegate  respondsToSelector:@selector(getPingLunRiZhiModel:Withtemp:)]) {
            [self.delegate getPingLunRiZhiModel:model_RiZhiPingLun Withtemp:2];
        }
    } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([self.delegate  respondsToSelector:@selector(getPingLunRiZhiModel:Withtemp:)]) {
            [self.delegate getPingLunRiZhiModel:model_RiZhiPingLun Withtemp:12];
        }
    }];
    
   
    [name1 appendAttributedString:contents];
    name1.yy_lineSpacing =6;
    self.YL_label.attributedText = name1;
    CGSize size = [name1 boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_RiZhiPingLun.cellHeight = size.height+10;
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.left.mas_equalTo(self.mas_left).mas_offset(55);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
    
    
}

-(void)setModel_rizhi:(RiZhiModel *)model_rizhi
{
    _model_rizhi = model_rizhi;
    NSMutableAttributedString  *title = [[NSMutableAttributedString alloc]initWithString:@""];
    NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:@"时间："  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    NSMutableAttributedString *time1 =[[NSMutableAttributedString alloc]initWithString:model_rizhi.TimeSlot attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [time appendAttributedString:time1];
    [title appendAttributedString:time];
    NSMutableAttributedString  *jihua =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n今日计划："] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    NSMutableAttributedString *jihua2 =[[NSMutableAttributedString alloc]initWithString:model_rizhi.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [jihua appendAttributedString:jihua2];
    [title appendAttributedString:jihua];
    
    NSMutableAttributedString  *result = [[NSMutableAttributedString alloc]initWithString:@"\n完成结果：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    NSString *Tstr = model_rizhi.result == nil?@"等待结果":model_rizhi.result;
    NSMutableAttributedString  *result1 =[[NSMutableAttributedString alloc]initWithString:Tstr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [result appendAttributedString:result1];
    [title appendAttributedString:result];
    
    title.yy_lineSpacing =6;
    CGSize size = [title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.YL_label.attributedText = title;
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+30);
        make.left.equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    model_rizhi.cellHeight =size.height+30;
}
-(void)setArr_json:(NSArray *)arr_json{
    _arr_json = arr_json;
    NSMutableAttributedString  *title = [[NSMutableAttributedString alloc]initWithString:@""];
    NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:@"时间："  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    for (int i=0; i<arr_json.count; i++) {
        GNmodel *model =arr_json[i];
        if (model.biaoji ==3 && i==0) {
            NSMutableAttributedString  *tstr =[[NSMutableAttributedString alloc]initWithString:model.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [time appendAttributedString:tstr];
        }else if (model.biaoji ==3 && i>0)
        {
            NSMutableAttributedString  *tstr =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" ~ %@\n",model.content]  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [time appendAttributedString:tstr];
            [title appendAttributedString:time];
        }else
        {
            NSMutableAttributedString *other = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：",model.name] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
            NSMutableAttributedString *other2 =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.content] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [other appendAttributedString:other2];
            [title appendAttributedString:other];
        }
    }
    
    title.yy_lineSpacing =8;
    CGSize size = [title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.YL_label.attributedText = title;
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+40);
        make.left.equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
}

-(void)setAddress:(NSString *)address
{
    if (address ==nil) {
        address =@"您拒绝了位置请求";
    }
    _address =address;
    NSMutableAttributedString *con = [[NSMutableAttributedString alloc]initWithString:address attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    con.yy_lineSpacing =6;
    self.YL_label.attributedText = con;
  
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.left.equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}
-(void)setContents:(NSString *)contents
{
    _contents = contents;
    NSMutableAttributedString *con = [[NSMutableAttributedString alloc]initWithString:contents attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    con.yy_lineSpacing =6;
    self.YL_label.attributedText = con;
    CGSize size = [con boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+40);
        make.left.equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
}
-(void)setModel_baoxiao:(My_BaoXiaoModel *)model_baoxiao
{
    
    _model_baoxiao = model_baoxiao;
    NSDictionary *dic =@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]};
    NSDictionary *dic2 =@{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    
    NSMutableAttributedString *money = [[NSMutableAttributedString alloc]initWithString:@"报销总金额(元):" attributes:dic];
    NSMutableAttributedString *money2 =[[NSMutableAttributedString alloc]initWithString:model_baoxiao.totalMoney attributes:dic2];
    [money appendAttributedString:money2];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:@"\n报销名称:" attributes:dic];
    [money appendAttributedString:name];
    NSMutableAttributedString *name2 =[[NSMutableAttributedString alloc]initWithString:model_baoxiao.remibursetitle attributes:dic2];
    [money appendAttributedString:name2];
    
    NSMutableAttributedString *person = [[NSMutableAttributedString alloc]initWithString:@"\n报销人:" attributes:dic];
    [money appendAttributedString:person];
    NSMutableAttributedString *person2 =[[NSMutableAttributedString alloc]initWithString:model_baoxiao.createName attributes:dic2];
    [money appendAttributedString:person2];
    NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n报销时间:%@",model_baoxiao.createTime] attributes:dic];
    [money appendAttributedString:time];
    money.yy_lineSpacing =4;
    CGSize size = [money boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-45, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_baoxiao.cellHeight = size.height+20;
    self.YL_label.attributedText = money;
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-30);
    }];
    
    self.layer.masksToBounds =YES;
    self.layer.cornerRadius=6;
    self.layer.borderWidth=3;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
}
-(void)setModel_gonggao:(GongGao_ListModel *)model_gonggao
{
    _model_gonggao = model_gonggao;
    
    NSMutableAttributedString  *gonggao = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"【%@】%@",model_gonggao.name,model_gonggao.theme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model_gonggao.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    time.yy_alignment = NSTextAlignmentRight;
    [gonggao appendAttributedString:time];
    gonggao.yy_lineSpacing =6;
    CGSize  size = [gonggao boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_gonggao.cellHeight = size.height+10;
    self.YL_label.attributedText = gonggao;
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.height.mas_equalTo(size.height+10);
    }];
    
}
-(void)setModel_notification:(PX_NotificationListModel *)model_notification
{
    NSMutableAttributedString  *thethem = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"培训主题：%@",model_notification.theTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    NSMutableAttributedString *place = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n培训地点：%@",model_notification.theplace] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [thethem appendAttributedString:place];
    
    NSMutableAttributedString *person =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n讲师：%@",model_notification.teacherName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [thethem appendAttributedString:person];
    
    NSMutableAttributedString *ttime =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n发布时间：%@",model_notification.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [thethem appendAttributedString:ttime];
    thethem.yy_lineSpacing =6;
    CGSize size =[thethem boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.YL_label.attributedText = thethem;
    model_notification.cellHeight = size.height+10;
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
}

-(YYLabel*)YL_label
{
    if (!_YL_label) {
        _YL_label = [[YYLabel alloc]init];
        [self addSubview:_YL_label];
        _YL_label.numberOfLines =0;
        
    }
    return _YL_label;
}
-(void)setModel_course:(PX_courseManageModel *)model_course
{
    _model_course =model_course;
    NSMutableAttributedString  *courseTheme = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_course.courseTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    NSArray *tarr = [model_course.courseType componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString  *type = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor]}];
        [type yy_setTextBackgroundBorder:[YYTextBorder borderWithFillColor:[UIColor grayColor] cornerRadius:6] range:type.yy_rangeOfAll];
        
//        [type yy_setTextBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor blackColor]] range:type.yy_rangeOfAll];
        NSAttributedString  *kong = [[NSAttributedString alloc]initWithString:@"   "];
        [type appendAttributedString:kong];
        [courseTheme appendAttributedString:type];
    }
    
    courseTheme.yy_lineSpacing = 6;
    self.YL_label.attributedText = courseTheme;
    CGSize size = [courseTheme boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_course.cell_height = size.height+20;
    [self.YL_label  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
    
}
-(void)setModel_tuijian:(EQDS_CourseModel *)model_tuijian
{
    _model_tuijian = model_tuijian;
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"【%@】",model_tuijian.lectureName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [name yy_setTextHighlightRange:name.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([self.delegate respondsToSelector:@selector(getTapNameWithname:Guid:model:)]) {
            [self.delegate getTapNameWithname:model_tuijian.lectureName Guid:model_tuijian.lecture model:model_tuijian];
        }
    }];
    NSMutableAttributedString *courseTheme = [[NSMutableAttributedString alloc]initWithString:model_tuijian.lectCourseTitle attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [name appendAttributedString:courseTheme];
    
    NSMutableAttributedString  *type = [[NSMutableAttributedString alloc]initWithString:@"\n" attributes:@{}];
    NSArray *tarr = [model_tuijian.lectCourseType componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString *ttype= [[NSMutableAttributedString alloc]initWithString:tarr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [ttype yy_setTextHighlightRange:ttype.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate respondsToSelector:@selector(getTapTypeWithtype:model:)]) {
                [self.delegate getTapTypeWithtype:tarr[i] model:model_tuijian];
            }
        }];
        [ttype yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:ttype.yy_rangeOfAll];
        [type appendAttributedString:ttype];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [type appendAttributedString:kong];
        
        
    }
    [name appendAttributedString:type];
    name.yy_lineSpacing =6;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_tuijian.cell_height = size.height+10;
    self.YL_label.attributedText =name;
    
    [self.YL_label  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
}
-(void)setModel_pipei:(EQDS_CourseModel *)model_pipei
{
    _model_tuijian = model_pipei;
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"【%@】%@",model_pipei.lectureName,model_pipei.courseTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    name.yy_lineSpacing =6;
    self.YL_label.attributedText =name;
    
    CGSize size = [name boundingRectWithSize:CGSizeMake(self.frame.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_pipei.cell_height = size.height+20;
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(size.height+15);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
}
-(void)setModel_courseMin:(PX_courseManageModel *)model_courseMin
{
    _model_courseMin = model_courseMin;
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"【%@】",model_courseMin.lectureName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [name yy_setTextHighlightRange:name.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([self.delegate respondsToSelector:@selector(getTapNameWithname:Guid:model:)]) {
            [self.delegate getTapNameWithname:model_courseMin.lectureName Guid:model_courseMin.creater model:model_courseMin];
        }
    }];
    NSMutableAttributedString *courseTheme = [[NSMutableAttributedString alloc]initWithString:model_courseMin.courseTheme attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [name appendAttributedString:courseTheme];
    
    NSMutableAttributedString  *type = [[NSMutableAttributedString alloc]initWithString:@"\n" attributes:@{}];
    NSArray *tarr = [model_courseMin.courseType componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString *ttype= [[NSMutableAttributedString alloc]initWithString:tarr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [ttype yy_setTextHighlightRange:ttype.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate respondsToSelector:@selector(getTapTypeWithtype:model:)]) {
                [self.delegate getTapTypeWithtype:tarr[i] model:model_courseMin];
            }
        }];
        [ttype yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:ttype.yy_rangeOfAll];
        [type appendAttributedString:ttype];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [type appendAttributedString:kong];
        
        
    }
    [name appendAttributedString:type];
    
    NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@天(%ld小时)   %@",model_courseMin.courseTimes,[model_courseMin.courseTimes integerValue]*6,model_courseMin.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    time.yy_alignment =NSTextAlignmentRight;
    [name appendAttributedString:time];
    name.yy_lineSpacing =6;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_courseMin.cell_height = size.height+10;
    self.YL_label.attributedText =name;
    
    [self.YL_label  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
}

-(void)setModel_need:(PXNeedModel *)model_need
{
    _model_need = model_need;
    NSMutableAttributedString *need = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"[%@]%@",model_need.comName,model_need.theTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    NSMutableAttributedString  *type = [[NSMutableAttributedString alloc]initWithString:@"\n"];
    NSArray *tarr = [model_need.theCategory componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString *ttype = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor orangeColor]}];
        [ttype yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:ttype.yy_rangeOfAll];
        [type appendAttributedString:ttype];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [type appendAttributedString:kong];
    }
    type.yy_alignment =NSTextAlignmentCenter;
    [need appendAttributedString:type];
    
    NSMutableAttributedString *times = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n预计培训时间：%@ ~ %@       预算:",model_need.thedateStart,model_need.thedateEnd] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    times.yy_alignment =NSTextAlignmentRight;
    [need appendAttributedString:times];
    
    NSMutableAttributedString *money = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",model_need.budgetedExpense] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor redColor]}];
    money.yy_alignment = NSTextAlignmentRight;
    [need appendAttributedString:money];
    need.yy_lineSpacing = 6;
    
    CGSize size = [need boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_need.cellHeight = size.height+10;
    self.YL_label.attributedText = need;
    [self.YL_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
}

-(void)setModel_need2:(PXNeedModel *)model_need
{
    _model_need = model_need;
    NSMutableAttributedString *need = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_need.thetheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:3]}];
    NSMutableAttributedString  *type = [[NSMutableAttributedString alloc]initWithString:@" "];
    NSArray *tarr = [model_need.theCategory componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString *ttype = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor orangeColor]}];
        [ttype yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:ttype.yy_rangeOfAll];
        [type appendAttributedString:ttype];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [type appendAttributedString:kong];
    }
    type.yy_alignment =NSTextAlignmentCenter;
    [need appendAttributedString:type];
    
    NSMutableAttributedString *times = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n预计培训时间：%@ ~ %@",model_need.thedateStart,model_need.thedateEnd] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    times.yy_alignment =NSTextAlignmentRight;
    [need appendAttributedString:times];
    
    need.yy_lineSpacing = 6;
    
    CGSize size = [need boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_need.cellHeight = size.height+15;
    self.YL_label.attributedText = need;
    [self.YL_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}


-(void)setModel_GN:(GNmodel *)model_GN
{
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：",model_GN.name] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:model_GN.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
//    contents.yy_alignment = NSTextAlignmentRight;
    [name appendAttributedString:contents];
    
    CGSize size  =[name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_GN.cellHeight = size.height+40;
    self.YL_label.attributedText = name;
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+40);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
}

-(void)setModel_trum:(TrumModel *)model_trum
{
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:model_trum.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    NSMutableAttributedString  *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model_trum.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    content.yy_alignment = NSTextAlignmentRight;
    [name appendAttributedString:content];
    name.yy_lineSpacing =6;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.YL_label.attributedText = name;
    model_trum.cellHeight = size.height+30;
    [self.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(size.height+30);
    }];
    
}

@end
