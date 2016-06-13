//
//  JJGlobal.h
//  JiaJia
//
//  Created by jojoting on 16/5/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//


#ifndef JJGlobal_h
#define JJGlobal_h


//color
#define MAIN_COLOR     [UIColor colorWithRed:233.f/255.f green:135.f/255.f blue:39.f/255.f alpha:1.0]
#define COLOR_HEX(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]

#define WEAKSELF    __weak __typeof(self) weakSelf = self;

#define QINIU_BASE_URL      @"o70pxhznh.bkt.clouddn.com"

//calculate
#define FEE_KM(distance) (distance*2.0)
#define FEE_TIME(time) (0*time/60)
#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


/**
 *  notification
 */

#define NOTIFICATION_VEHICLE    @"notification_vehicle"
#define NOTIFICATION_GUIDE      @"notification_guide"
/**
 *  NSUserDefaults KEY
 */
#define KEY_USER_DEFAULT_REGULAR_ADDRESS            @"user_default_regular_address"
#define KEY_USER_DEFAULT_REGULAR_ADDRESS_NAME       @"user_default_regular_address_name"
#define KEY_USER_DEFAULT_REGULAR_ADDRESS_LATITUDE   @"user_default_regular_address_latitude"
#define KEY_USER_DEFAULT_REGULAR_ADDRESS_LONGITUDE  @"user_default_regular_address_longitude"
/**
 *  user table
 */
#define KEY_USER_NAME           @"name"
#define KEY_USER_PHONE          @"username"
#define KEY_USER_AVATAR         @"avatar"
#define KEY_USER_GENDER         @"gender"
#define KEY_USER_LEVEL          @"level"

/**
 *  order table
 */
#define TABLE_ORDER                 @"Order"
#define KEY_ORDER_USER              @"user"
#define KEY_ORDER_DISTANCE          @"distance"
#define KEY_ORDER_TIME              @"time"
#define KEY_ORDER_AMOUNT            @"amount"
#define KEY_ORDER_START_LOCATION    @"startLocation"
#define KEY_ORDER_END_LOCATION      @"endLocation"

/**
 *  station table
 */
#define TABLE_STATION           @"Station"
#define KEY_STATION_LATITUDE    @"latitude"
#define KEY_STATION_LONGITUDE   @"longitude"



#endif /* JJGlobal_h */
