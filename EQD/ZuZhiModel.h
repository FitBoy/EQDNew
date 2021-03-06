//
//  ZuZhiModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZuZhiModel : NSObject
///部门名称
@property (nonatomic,copy) NSString* departName;
///部门id
@property (nonatomic,copy) NSString* departId;
///父级id
@property (nonatomic,copy) NSString* parentId;
///部门简称
@property (nonatomic,copy) NSString* deac;
///企业id
@property (nonatomic,copy) NSString* CompanyId;
///子级部门
@property (nonatomic,strong)  NSArray *childs;
///记录部门的级别 0,1，2，3，4，5
@property (nonatomic,assign) NSInteger flag;
///记录是否被选中0 没有被选中 1 被选中
@property (nonatomic,assign) NSInteger isChoose;
/// 0 全体员工 1 部门
@property (nonatomic,copy) NSString* type;

///记录是否有选中的功能
@property (nonatomic,assign) BOOL isShow;
@end
