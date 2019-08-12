//
//  GABaseDataSource.h
//  Suo
//
//  Created by ysw on 2019/8/8.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GALiveItem.h"
#import "GAAPI.h"



typedef void(^LiveDataBlock)(NSArray*lives);

@interface GABaseDataSource : NSObject

@property(nonatomic,copy)NSString *title;   //!< 节title
@property(nonatomic,assign)int pageSize;    //!< 页码大小 默认=10 加载下一页前修改有效
@property(nonatomic,assign)int currentPage; //!< 当前页(子类内部自增自减)

@property(nonatomic,strong)NSMutableArray<GALiveItem*> *liveItems;  //!<数据列表


/**
 重载数据

 @param completion 新数据返回
 */
- (void)reloadDataWithCompletion:(LiveDataBlock)completion;


/**
 加载下一页数据

 @param completion 新数据列表（返回的数据，内部已经添加到 liveItems 数组末尾，）
 */
- (void)loadNextPathWithCompletion:(LiveDataBlock)completion;



/**
 内部解析数据到模型使用

 @param json data数据
 @return 模型列表
 */
-(NSMutableArray<GALiveItem*>*)serializationToModel:(NSDictionary*)json;
@end

