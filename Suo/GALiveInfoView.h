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

typedef struct LocationInfo{
    double lat; 
    double lng;
    
    NSString *address;  //!<精确到街道
}GALocationInfo;


@interface GALiveInfoView : UIView
@property(nonatomic,strong)UIImageView *coverView;              //!<封面
@property(nonatomic,strong)UITextField *titleTextField;         //!<标题栏
@property(nonatomic,assign)GALocationInfo info;                 //!<位置信息
@end

NS_ASSUME_NONNULL_END
