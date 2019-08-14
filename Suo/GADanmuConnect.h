//
//  GADanmuConnect.h
//  Suo
//
//  Created by ysw on 2019/8/14.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GADanmuConnect : GABaseModel
@property(nonatomic,copy)NSString *ltoken;      //!<连接token
@property(nonatomic,copy)NSString *room_id;     //!<房间id
@property(nonatomic,copy)NSString *type;        //!<弹幕类型？
@property(nonatomic,copy)NSString *uid;         //!<用户id
@property(nonatomic,copy)NSString *uname;       //!<用户名
@property(nonatomic,copy)NSString *utype;       //!<用户类型

@property(nonatomic,strong)NSNumber *ntime; //
@property(nonatomic,strong)NSArray *other_data;


@property(nonatomic,strong)NSDictionary *json;  //!<原始字典
@end

NS_ASSUME_NONNULL_END
