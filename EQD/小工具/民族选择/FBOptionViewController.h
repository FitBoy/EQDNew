//
//  FBOptionViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
/**
 0：area，
 1:岗位，
 2：行业，
 3：公司经营模式
 4：公司员工规模
 5：公司体系认证
 :6：公司类型
 7：公司年营业额
 8：合同有效期
 9：合同形式
 10：文化程度
 11：社保种类
 12：合同性质
 13：工作性质
 14：民族
 15：政治面貌
 16：职业资格
 17：合同续签次数
 18：终止合同原因
 19：合同类型
 20：户口类型
 21：生肖
 22：婚配   23.和联系人的关系 24 英语水平 25 宗教信仰 26 离职原因 27 离职类型*/
#import "FBBaseViewController.h"
@interface FBOptionViewController : FBBaseViewController
@property (nonatomic,assign) NSInteger option;
@property (nonatomic,copy) NSString* contentTitle;
@property (nonatomic,assign) id delegate;
@property (nonatomic,strong)  NSIndexPath *indexPath;

@end
@protocol FBOptionViewControllerDelegate <NSObject>

-(void)option:(NSString*)option indexPath:(NSIndexPath*)indexPath;

@end
