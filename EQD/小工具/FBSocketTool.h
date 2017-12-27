//
//  FBSocketTool.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 先手动断开再重新连接

#import <Foundation/Foundation.h>
#import <GCDAsyncSocket.h>


@interface FBSocketTool : NSObject<GCDAsyncSocketDelegate>
{
    dispatch_source_t  timer;
}
@property (nonatomic,strong)  GCDAsyncSocket  *socket;
@property (nonatomic, copy  ) NSString       *socketHost;   // socket的Host
@property (nonatomic, assign) UInt16         socketPort;    // socket的prot


+ (FBSocketTool *)sharedInstance;

-(void)socketConnectHost;// socket连接

-(void)cutOffSocket;// 断开socket连接


@end
