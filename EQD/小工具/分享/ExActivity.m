//
//  ExActivity.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ExActivity.h"

@implementation ExActivity
-(NSString*)activityTitle{
    //分享图标的标题
    return @"易企点";
}
-(UIImage*)activityImage{
    //分享上面显示的图标的 名字
    return [UIImage  imageNamed:@"eqd.png"];
}
//-(UIImage*)__activityImage{
// 编辑下面的图片名字显示
//    return [UIImage  imageNamed:@"eqd.png"];
//}
+ (UIActivityCategory)activityCategory{
    //设置在分享栏上显示  不写是在编辑栏显示
    return UIActivityCategoryShare;
}
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    //如果不实现，不会在分享栏显示图标与名字
    if(activityItems.count>0)
    {
        return YES;
    }
    return NO;
}

//-(void)prepareWithActivityItems:(NSArray *)activityItems
//{
//     //RC:FileMsg  RC:VcMsg RC:ImgMsg RC:TxtMsg  RCJrmf:RpMsg
//    
//    
//}

- (nullable UIViewController *)activityViewController{
    
    FBShareViewController *Svc =[[FBShareViewController alloc]init];
    Svc.messageContent =self.messageContent;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Svc];
    return nav;
}

@end
