//
//  JJBmobEngine.m
//  JiaJia
//
//  Created by jojoting on 16/5/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJBmobEngine.h"
#import "JJGlobal.h"

@implementation JJBmobEngine

- (void)addObjectWithClassName:(NSString *)className params:(NSDictionary *)params returnBlock:(ResultBlock )resultBlock{
    
}
- (void)getObjectWithClassName:(NSString *)className params:(NSDictionary *)params returnBlock:(ReturnBlock )returnBlock{
    
}
- (void)updateObjectWithClassName:(NSString *)className params:(NSDictionary *)params returnBlock:(ResultBlock )resultBlock{
    
}
- (void)deleteObjectWithClassName:(NSString *)className params:(NSDictionary *)params returnBlock:(ResultBlock )resultBlock{
    
}

- (void)getOrderWithUser:(BmobUser *)user returnBlock:(ArrayReturnBlock )returnBlock{
    BmobQuery *query = [BmobQuery queryWithClassName:TABLE_ORDER];
    [query orderByDescending:@"creatAt"];
    [query includeKey:KEY_ORDER_USER];
    [query whereKey:KEY_ORDER_USER equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (returnBlock) {
            returnBlock(array,error);
        }
    }];
}

- (void)addOrderWithUser:(BmobUser *)user params:(NSDictionary *)params resultBlock:(ResultBlock )resultBlock{
    BmobObject *orderObject = [BmobObject objectWithClassName:TABLE_ORDER];
    for (NSString *key in [params allKeys]) {
        [orderObject setObject:params[key] forKey:key];
    }
    [orderObject setObject:user forKey:KEY_ORDER_USER];
    [orderObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (resultBlock) {
            resultBlock(isSuccessful, error);
        }
    }];
}

- (void)getStationsWithReturnBlock:(ArrayReturnBlock )returnBlock{
    BmobQuery *query = [BmobQuery queryWithClassName:TABLE_STATION];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (returnBlock) {
            returnBlock(array,error);
        }
    }];

}
@end
