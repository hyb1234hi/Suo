//
//  GABeautyFilterParams.h
//  Suo
//
//  Created by ysw on 2019/8/10.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,GABeautyParamsLevel) {
    GABeautyParamsLevel0 = 0,
    GABeautyParamsLevel1,
    GABeautyParamsLevel2,
    GABeautyParamsLevel3,
    GABeautyParamsLevel4,
    GABeautyParamsLevel5
};


/**
 美颜参数
 */
@interface GABeautyFilterParams : NSObject
/**
 美白
 
 default : 70
 value range : [0,100]
 */
@property (nonatomic, assign) int beautyWhite;

/**
 磨皮
 
 default : 40
 value range : [0,100]
 */
@property (nonatomic, assign) int beautyBuffing;

/**
 红润
 
 default : 70
 value range : [0,100]
 */
@property (nonatomic, assign) int beautyRuddy;

/**
 腮红
 
 default : 15
 value range : [0,100]
 */
@property (nonatomic, assign) int beautyCheekPink;

/**
 瘦脸
 
 default : 40
 value range : [0,100]
 */
@property (nonatomic, assign) int beautySlimFace;

/**
 缩下巴
 
 default : 50
 value range : [0,100]
 */
@property (nonatomic, assign) int beautyShortenFace;

/**
 大眼
 
 default : 30
 value range : [0,100]
 */

@property (nonatomic, assign) int beautyBigEye;

/**
 init
 
 @return AlivcBeautyParams
 */
- (instancetype)init;

/**
 default beauty params
 
 @param level AlivcBeautyParamsLevel
 @return AlivcBeautyParams
 */
+ (GABeautyFilterParams *)defaultBeautyParamsWithLevel:(GABeautyParamsLevel)level;

/**
 default beauty AlivcBeautyParamsLevel
 
 @return AlivcBeautyParamsLevel
 */
+ (GABeautyParamsLevel)defaultBeautyLevel;
@end

NS_ASSUME_NONNULL_END
