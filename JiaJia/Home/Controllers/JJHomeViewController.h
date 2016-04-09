//
//  JJHomeViewController.h
//  JiaJia
//
//  Created by jojoting on 16/4/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyDelegate <NSObject>

- (void)sdsad;

@end
@interface JJHomeViewController : UIViewController

@property (nonatomic, assign) id<MyDelegate> delegate;
@end
