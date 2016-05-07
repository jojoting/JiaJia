//
//  JJUser.h
//  JiaJia
//
//  Created by jojoting on 16/5/3.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface JJUser : BmobUser

@property (nonatomic, copy) NSString        *name;
@property (nonatomic, copy) NSString        *avatar;
@property (nonatomic, copy) NSString        *phone;
@property (nonatomic, copy) NSString        *gender;
@property (nonatomic, copy) NSString        *level;
@property (nonatomic, copy) NSString        *password;

@end
