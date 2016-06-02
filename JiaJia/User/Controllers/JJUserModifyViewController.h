//
//  JJUserModifyViewController.h
//  JiaJia
//
//  Created by jojoting on 16/5/29.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, JJUserValidateType) {
    JJUserValidateTypeNone = 0,
    JJUserValidateTypePassword,
    JJUserValidateTypePhone
};

typedef NS_ENUM(NSInteger, JJUserModifyType) {
    JJUserModifyTypeNone = -1,
    JJuserModifyTypeName = 0,
    JJUserModifyTypePassword,
    JJUserModifyTypePhone
    
};


@interface JJUserModifyViewController : UIViewController

- (instancetype)initValidateWithType:(JJUserValidateType )validateType titles:(NSArray *)titles placeholders:(NSArray *)placeholders;
- (instancetype)initModifyWithType:(JJUserModifyType )modifyType titles:(NSArray *)titles placeholders:(NSArray *)placeholders;

@end
