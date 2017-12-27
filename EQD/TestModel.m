//
//  TestModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel
-(void)setName:(NSString *)name{
    _name =name;
    self.left0 =name;
}
-(void)setTitle:(NSString *)title{
    _title=self.right1=title;
}
-(void)setDate:(NSString *)date
{
    _date=self.right0=date;
}
@end
