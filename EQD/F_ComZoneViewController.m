//
//  F_ComZoneViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "F_ComZoneViewController.h"
#import <GCDAsyncSocket.h>
#import "FBSocketTool.h"
@interface F_ComZoneViewController ()
{
    
}

@end

@implementation F_ComZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [FBSocketTool sharedInstance].socketHost =@"192.168.1.118";
    [FBSocketTool sharedInstance].socketPort =8080;
    [[FBSocketTool sharedInstance] cutOffSocket];
    [[FBSocketTool sharedInstance] socketConnectHost];
    
   
    
}





@end
