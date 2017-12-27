//
//  FBLoadingEffectView.h
//  TianHuaWenZhong
//
//  Created by 梁新帅 on 2017/1/11.
//  Copyright © 2017年 Rowling-Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBLoadingEffectView : UIVisualEffectView
@property (nonatomic,strong)  UIActivityIndicatorView *AIV_loading;
@property (nonatomic,strong)  UILabel *L_title;
///默认 UIActivityIndicatorViewStyleWhiteLarge
@property (nonatomic,assign) UIActivityIndicatorViewStyle  AIVS_style;
///加载的这个view的大小不能小于 100 * 100
-(instancetype)initWithFrame:(CGRect)frame AndTitle:(NSString*)title;
-(void)cancelView;

///默认加载在视图的中间 且标题是加载中>>
-(instancetype)init;

@end
