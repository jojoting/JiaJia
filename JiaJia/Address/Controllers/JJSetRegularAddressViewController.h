//
//  JJSetRegularAddressViewController.h
//  JiaJia
//
//  Created by jojoting on 16/5/26.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMapPOI;

typedef void(^ResultBlock)(AMapPOI *poi);

@interface JJSetRegularAddressViewController : UIViewController

@property (nonatomic, copy) ResultBlock resultBlock;

@end
