//
//  JJQRCodeReaderViewController.m
//  JiaJia
//
//  Created by jojoting on 16/6/1.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJQRCodeReaderViewController.h"
#import "JJGlobal.h"

@interface JJQRCodeReaderViewController ()

@end

@implementation JJQRCodeReaderViewController


- (void)showError:(NSString*)str{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)reStartDevice{
    
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    for (LBXScanResult *result in array) {
        NSLog(@"code:%@",result.strScanned);
        if (self.returnBlock) {
            self.returnBlock(self,result.strScanned);
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型设置为在框的上面
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    //扫码框周围4个角绘制线宽度
    style.photoframeLineW = 5;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //显示矩形框
    style.isNeedShowRetangle = YES;
    
    //动画类型：网格形式，模仿支付宝
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //码框周围4个角的颜色
    style.colorAngle = MAIN_COLOR;
    //矩形框颜色
    style.colorRetangleLine = [UIColor whiteColor];
    
    //非矩形框区域颜色
    style.alpa_notRecoginitonArea = 0;

    self.style = style;
    
    //开启只识别矩形框内图像功能
    self.isOpenInterestRect = YES;

    self.navigationItem.title = @"小E租赁";
    // Do any additional setup after loading the view.
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
