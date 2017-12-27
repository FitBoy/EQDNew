//
//  FBSocketTool.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBSocketTool.h"

@implementation FBSocketTool
+(FBSocketTool *) sharedInstance
{
    
    static FBSocketTool *sharedInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstace = [[self alloc] init];
    });
    
    return sharedInstace;
}

// socket连接
-(void)socketConnectHost{
    self.socket    =[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    
    NSError *error = nil;
    
//    [self.socket connectToUrl:[NSURL URLWithString:@"ws:http://47.94.173.253:8008/MyTask/Handler2.ashx?user=1"] withTimeout:3 error:nil];
//    [self.socket connectToAddress:[@"http://47.94.173.253:8008/MyTask/Handler2.ashx?user=1" dataUsingEncoding:NSUTF8StringEncoding] error:nil];
    [self.socket connectToHost:@"http://47.94.173.253" onPort:8008 withTimeout:3 error:&error];
    
}
// 连接成功回调
#pragma mark  - 连接成功回调
-(void)socket:(GCDAsyncSocket *)sock didConnectToUrl:(NSURL *)url
{
    
}
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"socket连接成功");
    sock.userData=@{@"key":@"value"};
    NSString *str =@"你|好";
    NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
    [sock writeData:data withTimeout:-1 tag:1];
    
    //全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //定时循环执行事件
    
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timer) {
            [self.socket readDataWithTimeout:30 tag:2];
        }
    });
    
    dispatch_resume(timer);
    
}


// 切断socket
-(void)cutOffSocket{
    if (timer) {
        dispatch_source_set_cancel_handler(timer, ^{
            NSLog(@"Cancel Handler");
        });
    }
    
    [self.socket disconnect];
}
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"连接失败");
//    [self socketConnectHost];

}
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"tag==%ld",tag);
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"=收到的消息==%@=你好=",str);
    // 对得到的data值进行解析与转换即可
//    [self.socket readDataWithTimeout:30 tag:0];
    

}

@end
