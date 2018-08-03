//
//  ZhiBiao_SearchViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface ZhiBiao_SearchViewController : FBBaseViewController
@property (nonatomic,weak) id delegate_zhiBiao;
@end
@protocol ZhiBiao_SearchViewControllerDelegate <NSObject>
-(void)getZhibiao:(NSString*)zhiBiao;
@end
