//
//  JJQiniuEngine.m
//  JiaJia
//
//  Created by jojoting on 16/5/11.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJQiniuEngine.h"
#import <AFNetworking.h>
#import <BmobSDK/Bmob.h>
#import "JJGlobal.h"

static JJQiniuEngine *sharedManager = nil;
static NSString *url = @"http://47.88.192.70:8080/token";
@implementation JJQiniuEngine

+ (JJQiniuEngine *)sharedInstance{
    @synchronized(self){
        if (sharedManager == nil) {
            static dispatch_once_t once;
            dispatch_once(&once, ^{
                sharedManager = [[self alloc]init];
            });
            
        }
    }
    return sharedManager;
}

- (void)uploadImageToQiniu:(NSData *)data key:(NSString *)key token:(NSString *)token block:(ReturnBlock )block{
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    [upManager putData:data key:key token:token complete:^(QNResponseInfo *info,NSString *key,NSDictionary *dict){
        if (block) {
            block(info,key,dict);
        }
    }option:nil];
    
}

- (NSString *)getKey {
    return [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
}

- (void)getQiniuTokenAndUpload:(NSData *)data block:(ReturnBlock )block{
    //获取最新touken
    NSString *key = [self getKey];
    NSDictionary *params = @{
                             @"key":key
                             };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *token = responseObject[@"token"];
        [self uploadImageToQiniu:data key:key token:token block:block];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(NSString*)getQiniuDomain:(NSString*)bucket
{
    NSString *domain = @"o70pxhznh.bkt.clouddn.com";
    return domain;
}

-(NSString*)getQiniuFullUrl:(NSString*)key
{
    NSString* fullUrl = [NSString stringWithFormat:@"%@/%@",[self getQiniuDomain:nil],key];
    
    NSLog(@"fullUrl = %@",fullUrl);
    return fullUrl;
}



@end
