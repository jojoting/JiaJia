//
//  JJActionSheetPicker.m
//  JiaJia
//
//  Created by jojoting on 16/5/31.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJActionSheetPicker.h"
#import "JJGlobal.h"

#define CXActionSheetPickertoolbarHeight   40
#define CXActionSheetPickerHeight          220
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface JJActionSheetPicker ()

@property (strong, nonatomic) UIPickerView *picker;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) UIView *backgroundView;
@property (copy, nonatomic) JJActionSheetPickerCancelBlock cancelBlock;
@property (copy, nonatomic) JJActionSheetPickerConfirmBlock confirmBlock;

@end

@implementation JJActionSheetPicker

+ (instancetype)showWithTitle:(NSString *)title picker:(UIPickerView *)picker confirmBlock:(JJActionSheetPickerConfirmBlock)confirmBlock cancelBlock:(JJActionSheetPickerCancelBlock)cancelBlock view:(UIView *)view{
    
    JJActionSheetPicker *actionSheetPicker = [[JJActionSheetPicker alloc]initWithTitle:title picker:picker confirmBlock:confirmBlock cancelBlock:cancelBlock];
    [actionSheetPicker showOnView:view];
    return actionSheetPicker;
}

- (instancetype)initWithTitle:(NSString *)title picker:(UIPickerView *)picker confirmBlock:(JJActionSheetPickerConfirmBlock)confirmBlock cancelBlock:(JJActionSheetPickerCancelBlock)cancelBlock{
    self = [self initWithFrame:CGRectMake(0, screenHeight, screenWidth, 0)];
    if (self) {
        _title = title;
        _picker = picker;
        _confirmBlock = confirmBlock;
        _cancelBlock = cancelBlock;
        [self initViews];
    }
    return self;
}
- (void)dismiss:(BOOL)animation{
    
    if (animation){
        [UIView animateWithDuration:0.5f animations:^{
            self.backgroundView.alpha = 0.f;
            self.frame = CGRectMake(0, screenHeight, screenWidth, CXActionSheetPickerHeight);
            
        } completion:^(BOOL finished) {
            [self.backgroundView removeFromSuperview];
            [self removeFromSuperview];
        }];
    }
    
    else{
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }
    
}

- (void)initViews{
    
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)];
    leftBarButton.tintColor = MAIN_COLOR;
    
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(confirmAction:)];
    rightBarButton.tintColor = MAIN_COLOR;
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *fixedSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixedSpaceItem.width = 10;
    
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectZero];
    [toolbar setItems:@[fixedSpaceItem,leftBarButton,spaceItem,rightBarButton,fixedSpaceItem] animated:YES];
    _toolbar = toolbar;
    
    if (_picker == nil) {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectZero];
    }
    
    [self addSubview:_toolbar];
    [self addSubview:_picker];
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.toolbar.frame = CGRectMake(0, 0, self.frame.size.width, CXActionSheetPickertoolbarHeight);
    self.picker.frame = CGRectMake(0, CXActionSheetPickertoolbarHeight,screenWidth , CXActionSheetPickerHeight - CXActionSheetPickertoolbarHeight);
}

- (void)showOnView:(UIView *)view{
    if (self.superview == nil) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, window.frame.size.width, window.frame.size.height)];
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0;
        
        [window insertSubview:backgroundView belowSubview:self];
        self.backgroundView = backgroundView;
    }
    [UIView animateWithDuration:0.5f animations:^{
        self.backgroundView.alpha = 0.4;
        self.frame = CGRectMake(0, screenHeight - CXActionSheetPickerHeight, screenWidth, CXActionSheetPickerHeight);
    }];
}

- (void)cancelAction:(UIButton *)button{
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
}

- (void)confirmAction:(UIButton *)button{
    if (self.confirmBlock) {
        self.confirmBlock(self);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
