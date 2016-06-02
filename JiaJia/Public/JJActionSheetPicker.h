//
//  JJActionSheetPicker.h
//  JiaJia
//
//  Created by jojoting on 16/5/31.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJActionSheetPicker;

typedef void (^JJActionSheetPickerConfirmBlock)(JJActionSheetPicker *actionSheetPicker);
typedef void (^JJActionSheetPickerCancelBlock)(JJActionSheetPicker *actionSheetPicker);

@interface JJActionSheetPicker : UIView

+ (instancetype)showWithTitle:(NSString *)title picker:(UIPickerView *)picker confirmBlock:(JJActionSheetPickerConfirmBlock)confirmBlock cancelBlock:(JJActionSheetPickerCancelBlock)cancelBlock view:(UIView *)view;

- (instancetype)initWithTitle:(NSString *)title picker:(UIPickerView *)picker confirmBlock:(JJActionSheetPickerConfirmBlock)confirmBlock cancelBlock:(JJActionSheetPickerCancelBlock)cancelBlock;

- (void)dismiss:(BOOL)animation;


@end
