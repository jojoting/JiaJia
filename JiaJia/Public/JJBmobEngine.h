//
//  JJBmobEngine.h
//  JiaJia
//
//  Created by jojoting on 16/5/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

typedef void (^ResultBlock)(BOOL isSuccessful, NSError *error);
typedef void (^ReturnBlock)(BmobObject *bmobObject, NSError *error);
typedef void (^ArrayReturnBlock)(NSArray *array, NSError *error);


@interface JJBmobEngine : NSObject

/**
 *  添加一行数据到数据库中
 *
 *  @param className   数据库表名
 *  @param params      添加的数据
 *  @param resultBlock 回调block
 */
- (void)addObjectWithClassName:(NSString *)className params:(NSDictionary *)params returnBlock:(ResultBlock )resultBlock;

/**
 *  获取一行数据
 *
 *  @param className   数据库表名
 *  @param params      获取的数据的条件
 *  @param returnBlock 回调block
 */
- (void)getObjectWithClassName:(NSString *)className params:(NSDictionary *)params returnBlock:(ReturnBlock )returnBlock;

/**
 *  更新一行数据
 *
 *  @param className   数据库表名
 *  @param params      更新的数据
 *  @param resultBlock 回调block
 */
- (void)updateObjectWithClassName:(NSString *)className params:(NSDictionary *)params returnBlock:(ResultBlock )resultBlock;

/**
 *  删除一行数据
 *
 *  @param className   数据库表名
 *  @param params      删除的数据的条件
 *  @param resultBlock 回调block
 */
- (void)deleteObjectWithClassName:(NSString *)className params:(NSDictionary *)params returnBlock:(ResultBlock )resultBlock;


- (void)getOrderWithUser:(BmobUser *)user returnBlock:(ArrayReturnBlock )returnBlock;

- (void)addOrderWithUser:(BmobUser *)user params:(NSDictionary *)params resultBlock:(ResultBlock )resultBlock;

- (void)getStationsWithReturnBlock:(ArrayReturnBlock )returnBlock;
@end
