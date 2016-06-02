//
//  JJPaySuccessViewController.m
//  JiaJia
//
//  Created by jojoting on 16/5/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJPaySuccessViewController.h"
#import "JJPaySuccessView.h"

@interface JJPaySuccessViewController ()

@end

@implementation JJPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付成功";
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(completeAction:)];
    JJPaySuccessView *paySuccessView = [[JJPaySuccessView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:paySuccessView];
    // Do any additional setup after loading the view.
}

- (void)completeAction:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
