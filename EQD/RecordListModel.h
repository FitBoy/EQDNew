//
//  RecordListModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/4/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordListModel : NSObject
@property (nonatomic,copy) NSString* CreateName;
@property (nonatomic,copy) NSString* CreateTime;
@property (nonatomic,copy) NSString* Creater;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* Message;
-(NSString*)CreateTime;
@end
