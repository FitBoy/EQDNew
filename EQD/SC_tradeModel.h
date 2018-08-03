//
//  SC_tradeModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SC_tradeModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* OrderBody;
@property (nonatomic,copy) NSString* OrderCode;
@property (nonatomic,copy) NSString* OrderType;
@property (nonatomic,copy) NSString* amountMondy;
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* createTime;
/// 开通的功能
@property (nonatomic,copy) NSString* funcType;
///
@property (nonatomic,copy) NSString* status;
-(NSString*)status;
-(NSString*)createTime;
// 支付类型  微信  支付宝
@property (nonatomic,copy) NSString* type;
//开通年限
@property (nonatomic,copy) NSString* years;
@property (nonatomic,assign) float cell_height;
@end
