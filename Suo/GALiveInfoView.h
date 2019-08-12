//
//  GALiveInfoView.h
//  Suo
//
//  Created by ysw on 2019/8/9.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

@interface GALiveInfoView : UIView
@property(nonatomic,strong)UIImageView *coverView;              //!<封面
@property(nonatomic,strong)UITextField *titleTextField;         //!<标题栏
@property(nonatomic,strong)CLLocationManager *manager;
@end

NS_ASSUME_NONNULL_END
