//
//  MyUUIDManager.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MyUUIDManager.h"
#import "MyKeyChainManager.h"
@implementation MyUUIDManager
static NSString * const KEY_IN_KEYCHAIN = @"com.myuuid.uuid";


+(void)saveUUID:(NSString *)uuid{
    if (uuid && uuid.length > 0) {
        [MyKeyChainManager save:KEY_IN_KEYCHAIN data:uuid];
    }
}


+(NSString *)getUUID{
    //先获取keychain里面的UUID字段，看是否存在
    NSString *uuid = (NSString *)[MyKeyChainManager load:KEY_IN_KEYCHAIN];
    
    //如果不存在则为首次获取UUID，所以获取保存。
    if (!uuid || uuid.length == 0) {
    
//        CFUUIDRef puuid = CFUU<a class="keylink" href="http://www.honhei.com/" target="_blank">IDC</a>reate( nil );
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        CFStringRef uuidString = CFUUIDCreateString( nil, uuidRef );
        
        uuid = [NSString stringWithFormat:@"%@", uuidString];
        
        [self saveUUID:uuid];
    }
    
    return uuid;
}



+(void)deleteUUID{
    [MyKeyChainManager delete:KEY_IN_KEYCHAIN];
}
@end
