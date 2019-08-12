//
//  GALiveRecommendData.h
//  Suo
//
//  Created by ysw on 2019/8/7.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseDataSource.h"


typedef void(^LiveDataBlock)(NSArray*);


/**
 直播推荐数据
 */
@interface GALiveRecommendData : GABaseDataSource
//@property(nonatomic,copy)NSString *title;   //!<节title
//@property(nonatomic,strong)NSMutableArray<GALiveItem*> *liveItems;  //!<数据列表
//
//@property(nonatomic,assign)int pageSize;                            //!< 页码大小 默认=10 加载下一页前修改有效
//
//- (void)reloadDataWithCompletion:(LiveDataBlock)completion;
//- (void)loadNextPathWithCompletion:(LiveDataBlock)completion;

@end


