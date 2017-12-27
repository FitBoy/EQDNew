//
//  GZQ_PingLunViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "GongZuoQunModel.h"
@interface GZQ_PingLunViewController : FBBaseViewController
@property (nonatomic,strong) GongZuoQunModel *model;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,weak) id delegate;
@end
@protocol GZQ_PingLunViewControllerDelegate <NSObject>
///删除
-(void)deleteModelWithindexpath:(NSIndexPath*)indexPath;
///点赞
-(void)zanwithIndexPath:(NSIndexPath*)indexPath;
///更新留言数
-(void)liuyanWithIndexpath:(NSIndexPath*)indexPath Withnumber:(NSString*)number;
@end
