//
//  MyKeyChainManager.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyKeyChainManager : NSObject
+ (void)delete:(NSString *)service;
+ (id)load:(NSString *)service;
+ (void)save:(NSString *)service data:(id)data;
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service ;
@end
