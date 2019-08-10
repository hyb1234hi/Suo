//
//  GABeautyFilterParams.m
//  Suo
//
//  Created by ysw on 2019/8/10.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABeautyFilterParams.h"

static const int GABeautyWhiteDefault = 70;
static const int GABeautyBuffingDefault = 40;
static const int GABeautyRuddyDefault = 40;
static const int GABeautyCheekPinkDefault = 15;
static const int GABeautyThinFaceDefault = 40;
static const int GABeautyShortenFaceDefault = 50;
static const int GABeautyBigEyeDefault = 30;

@implementation GABeautyFilterParams

- (instancetype)init {
    self = [super init];
    if(self) {
        self.beautyWhite        = GABeautyWhiteDefault;
        self.beautyBuffing      = GABeautyBuffingDefault;
        self.beautyRuddy        = GABeautyRuddyDefault;
        self.beautyCheekPink    = GABeautyCheekPinkDefault;
        self.beautySlimFace     = GABeautyShortenFaceDefault;
        self.beautyShortenFace  = GABeautyShortenFaceDefault;
        self.beautyBigEye       = GABeautyBigEyeDefault;
    }
    return self;
}

+ (GABeautyFilterParams *)defaultBeautyParamsWithLevel:(GABeautyParamsLevel)level{
    GABeautyFilterParams *params = [[GABeautyFilterParams alloc] init];
    CGFloat scale = 1;
    if (level == GABeautyParamsLevel0) {
        scale = 0;
    }else if(level == GABeautyParamsLevel1){
        scale = 0.3;
    }else if(level == GABeautyParamsLevel2){
        scale = 0.6;
    }else if(level == GABeautyParamsLevel3){
        scale = 1;
    }else if(level == GABeautyParamsLevel4){
        scale = 1.2;
    }else if(level == GABeautyParamsLevel5){
        scale = 1.5;
    }
    params.beautyWhite      = GABeautyWhiteDefault * scale > 100 ? 100 : GABeautyWhiteDefault * scale;
    params.beautyBuffing    = GABeautyBuffingDefault * scale > 100 ? 100 : GABeautyBuffingDefault * scale;
    params.beautyRuddy      = GABeautyRuddyDefault * scale > 100 ? 100 : GABeautyRuddyDefault * scale;
    params.beautyCheekPink  = GABeautyCheekPinkDefault * scale > 100 ? 100 : GABeautyCheekPinkDefault * scale;
    params.beautySlimFace   = GABeautyThinFaceDefault * scale > 100 ? 100 : GABeautyThinFaceDefault * scale;
    params.beautyShortenFace = GABeautyShortenFaceDefault * scale > 100 ?  100 : GABeautyShortenFaceDefault * scale;
    params.beautyBigEye     = GABeautyBigEyeDefault * scale > 100 ? 100 : GABeautyBigEyeDefault * scale;
    return params;
}

+ (GABeautyParamsLevel)defaultBeautyLevel{
    return GABeautyParamsLevel4;
}

@end
