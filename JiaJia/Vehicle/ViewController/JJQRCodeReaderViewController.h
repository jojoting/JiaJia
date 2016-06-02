//
//  JJQRCodeReaderViewController.h
//  JiaJia
//
//  Created by jojoting on 16/6/1.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LBXScan/LBXScanViewController.h>

@interface JJQRCodeReaderViewController : LBXScanViewController

@property (nonatomic, copy) void(^returnBlock)(JJQRCodeReaderViewController *QRCodeReaderviewController,NSString *resultStr);

@end
