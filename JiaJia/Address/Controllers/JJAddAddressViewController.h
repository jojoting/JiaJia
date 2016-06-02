//
//  JJAddAddressViewController.h
//  JiaJia
//
//  Created by jojoting on 16/5/4.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AddressReturnBlock)(NSString *locationTitle, CGFloat latitude, CGFloat longitude);

@interface JJAddAddressViewController : UIViewController

@property (nonatomic, assign) CGFloat currentLatitude;
@property (nonatomic, assign) CGFloat currentLongitude;
@property (nonatomic, copy) AddressReturnBlock returnBlock;
@end
