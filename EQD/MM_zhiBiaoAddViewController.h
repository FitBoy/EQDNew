//
//  MM_zhiBiaoAddViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface MM_zhiBiaoAddViewController : FBBaseViewController
@property (nonatomic,weak) id delegate_zhibiao;
@end

@protocol MM_zhiBiaoAddViewControllerDelegate <NSObject>

-(void)getZhibiao:(NSString*)zhibiao valueZhibiao:(NSString*)valuezhibiao imageUrl:(NSString*)imageUrl;
@end

