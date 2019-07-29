//
//  GAVideo.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/27.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseModel.h"
#import "GAUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface GAVideo : GABaseModel
@property(nonatomic,copy)NSString *identifier;  //!<视频唯一id
@property(nonatomic,copy)NSString *videoURL;    //!<视频URL
@property(nonatomic,copy)NSString *coverURL;    //!<封面URL
@property(nonatomic,copy)NSString *title;       //!<标题
@property(nonatomic,copy)NSString *like;        //!<点赞数量

@property(nonatomic,strong) GAUser *user;       //!<内容发布用户信息

@end

NS_ASSUME_NONNULL_END
