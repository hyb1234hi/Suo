//
//  GALiveTypeSelectedView.h
//  Suo
//
//  Created by ysw on 2019/8/14.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GALiveTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GALiveTypeSelectedView : UIView
@property(nonatomic,strong)void(^selectedBlock)(GALiveTypeModel*type);

@end

NS_ASSUME_NONNULL_END
