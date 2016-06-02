//
//  JJQiniuEngine.h
//  JiaJia
//
//  Created by jojoting on 16/5/11.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Qiniu/QiniuSDK.h>

typedef void (^ReturnBlock)(QNResponseInfo *info,NSString *key,NSDictionary *dict);

@interface JJQiniuEngine : NSObject

+ (JJQiniuEngine *)sharedInstance;

/**
 *  获取token并上传文件
 *
 *  @param data  数据
 *  @param block 回调
 */
- (void)getQiniuTokenAndUpload:(NSData *)data block:(ReturnBlock )block;

- (NSString *)getQiniuFullUrl:(NSString*)key;

- (NSString*)getKey;

@end


