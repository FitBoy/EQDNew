//
//  FBWifiManager.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBWifiManager.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
@implementation FBWifiManager

+ (NSArray *)getWifiName{
    
    NSString *wifiName = nil;
    NSString *wifiAddress =nil;
    NSMutableArray *arr_wifi=[NSMutableArray arrayWithCapacity:0];
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        
        return @[@"未知",@"未知"];
        
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            wifiAddress =[networkInfo objectForKey:(__bridge NSString*)kCNNetworkInfoKeyBSSID];
            [arr_wifi addObject:wifiName];
            [arr_wifi addObject:wifiAddress];
            CFRelease(dictRef);
            
        }
        
    }
    
    CFRelease(wifiInterfaces);
    
    return arr_wifi;
    
}




@end
