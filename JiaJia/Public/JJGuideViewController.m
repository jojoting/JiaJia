//
//  JJGuideViewController.m
//  JiaJia
//
//  Created by jojoting on 16/6/2.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJGuideViewController.h"
#import "JJGlobal.h"

@interface JJGuideViewController ()<UIScrollViewDelegate>{
//    UIPageControl *pageControl; //指示当前处于第几个引导页
    UIScrollView *scrollView; //用于存放并显示引导页
    UIImageView *imageViewOne;
    UIImageView *imageViewTwo;
    UIImageView *imageViewThree;
}
@end

@implementation JJGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化UI控件
    scrollView=[[UIScrollView alloc]initWithFrame:SCREEN_FRAME];
    scrollView.pagingEnabled=YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT);
    [self.view addSubview:scrollView];
    
    
//    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 10)];
//    pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.0];
//    [self.view addSubview:pageControl];
//    pageControl.numberOfPages=3;
    
    [self createViewOne];
    [self createViewTwo];
    [self createViewThree];
    
    
}


-(void)createViewOne{
    
    UIView *view = [[UIView alloc] initWithFrame:SCREEN_FRAME];
    
    imageViewOne = [[UIImageView alloc] initWithFrame:SCREEN_FRAME];
    imageViewOne.contentMode = UIViewContentModeScaleAspectFit;
    imageViewOne.image = [UIImage imageNamed:@"launch_1"];
    [view addSubview:imageViewOne];
    
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress:)];
    imageViewOne.userInteractionEnabled = YES;
    [imageViewOne addGestureRecognizer:singleTap1];
    
    
    [scrollView addSubview:view];
    
}

-(void)createViewTwo{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imageViewTwo = [[UIImageView alloc] initWithFrame:SCREEN_FRAME];
    imageViewTwo.contentMode = UIViewContentModeScaleAspectFit;
    imageViewTwo.image = [UIImage imageNamed:@"launch_2"];
    [view addSubview:imageViewTwo];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress:)];
    imageViewTwo.userInteractionEnabled = YES;
    [imageViewTwo addGestureRecognizer:singleTap1];
    
    [scrollView addSubview:view];
    
}

-(void)createViewThree{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    imageViewThree = [[UIImageView alloc] initWithFrame:SCREEN_FRAME];
    imageViewThree.contentMode = UIViewContentModeScaleAspectFit;
    imageViewThree.image = [UIImage imageNamed:@"launch_3"];
    [view addSubview:imageViewThree];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress:)];
    imageViewThree.userInteractionEnabled = YES;
    [imageViewThree addGestureRecognizer:singleTap1];
    
    [scrollView addSubview:view];
}
#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
#pragma mark -- tap image
-(void)buttonpress:(id)sender
{
    NSLog(@"引导页完成");
//    [self dismissViewControllerAnimated:NOTIFICATION_GUIDE completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GUIDE object:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
