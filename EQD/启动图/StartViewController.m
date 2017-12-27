//
//  StartViewController.m
//  wenhua
//
//  Created by 梁新帅 on 2016/12/22.
//  Copyright © 2016年 FitBoy. All rights reserved.
//

#import "StartViewController.h"
#import "EQDLoginViewController.h"
@interface StartViewController ()<UIScrollViewDelegate>
{
    UIPageControl *pageControl;
    dispatch_source_t  timer;
}

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *StartScrollView =[[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:StartScrollView];
    NSArray *arr = @[@"E11",@"E12",@"E13",@"E14",@"E15",@"E16"];
    StartScrollView.contentSize=CGSizeMake(self.view.frame.size.width*arr.count, self.view.frame.size.height);
    
    for (int i=0; i<arr.count; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*i, (self.view.frame.size.height-self.view.frame.size.width*16/9.0)/2.0, self.view.frame.size.width, self.view.frame.size.width*16/9.0)];
        imageView.image = [UIImage imageNamed:arr[i]];
        [StartScrollView addSubview:imageView];
    }
    StartScrollView.pagingEnabled = YES;
    StartScrollView.showsHorizontalScrollIndicator=NO;
    StartScrollView.bounces=NO;
    StartScrollView.delegate=self;
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*0.91, self.view.frame.size.width, self.view.frame.size.height*0.03)];
    [self.view addSubview:pageControl];
    pageControl.numberOfPages = arr.count;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor=[UIColor grayColor];
    UIButton *JoinBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [JoinBtn addTarget:self action:@selector(JoinClick) forControlEvents:UIControlEventTouchUpInside];
    JoinBtn.frame = CGRectMake(self.view.frame.size.width*(arr.count-1)+((self.view.frame.size.width-138)/2.0), self.view.frame.size.height*0.801, 146.0, 41.0);
//    [JoinBtn setBackgroundColor:[UIColor greenColor]];
    
    [JoinBtn setTitle:@"进入应用" forState:UIControlStateNormal];
    JoinBtn.titleLabel.font = [UIFont systemFontOfSize:27];
    JoinBtn.layer.borderWidth=1;
    JoinBtn.layer.borderColor=[UIColor blackColor].CGColor;
    JoinBtn.layer.shadowOffset=CGSizeMake(5, 3);
    
    [StartScrollView addSubview:JoinBtn];
   
   
    //全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //主队列；属于串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    //定时循环执行事件
    __block NSInteger temp=1;
     timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (temp<6) {
//             [StartScrollView setContentOffset:CGPointMake(DEVICE_WIDTH*temp, 0)];
        }
        else
        {
            dispatch_cancel(timer);
        }
       
    });
    dispatch_source_set_cancel_handler(timer, ^{
        NSLog(@"Cancel Handler");
    });
    dispatch_resume(timer);
    
}
-(void)JoinClick{
    NSLog(@"我进入了主界面");
    NSUserDefaults  *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setBool:YES forKey:@"first_Start"];
    [userdefaults synchronize];
    
    
    EQDLoginViewController *Lvc =[[EQDLoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Lvc];
    
    self.view.window.rootViewController  = nav;
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (timer) {
        dispatch_source_cancel(timer);
    }
}
#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   pageControl.currentPage = scrollView.contentOffset.x/self.view.frame.size.width;
}

@end
