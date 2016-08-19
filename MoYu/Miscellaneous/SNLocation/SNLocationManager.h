//
//  SNLocationManager.h
//  wrongTopic
//
//  Created by wangsen on 16/1/16.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

/*
 * NSLocationAlwaysUsageDescription String 应用程序始终使用定位服务
 * NSLocationWhenInUseUsageDescription String 使用应用程序期间，可以使用定位服务
 */

typedef void(^UpdateLocationSuccessBlock) ( CLLocation * _Nullable  location,  CLPlacemark * _Nullable  placemark);
typedef void(^UpdateLocationErrorBlock) (CLRegion * _Nullable region, NSError * _Nullable error);

@interface SNLocationManager : NSObject

+ (_Nonnull instancetype)shareLocationManager;

/*
 * isAlwaysUse  是否后台定位 持续定位（NSLocationAlwaysUsageDescription）
 */
@property (nonatomic, assign) BOOL isAlwaysUse;
/*
 * isRealTime 是否实时定位
 */
@property (nonatomic, assign) BOOL isRealTime;
/*
 * 精度 默认 kCLLocationAccuracyKilometer
 */
@property (nonatomic, assign) CGFloat desiredAccuracy;
/*
 * 更新距离 默认1000米
 */
@property (nonatomic, assign) CGFloat distanceFilter;

//开始定位
- (void)startUpdatingLocationWithSuccess:(_Nullable UpdateLocationSuccessBlock)success andFailure:(_Nullable UpdateLocationErrorBlock)error;

@end
