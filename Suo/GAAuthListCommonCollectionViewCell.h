//
//  GAAuthListCommonCollectionViewCell.h
//  Suo
//
//  Created by gajz on 2019/8/4.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GAAuthListCommonCollectionViewCell : UICollectionViewCell

/**是否是image**/
@property (nonatomic, assign)BOOL isImage;

@property (nonatomic, strong)NSString *dayNums;
@property (nonatomic, strong)NSString *url; // imageUrl

@end

NS_ASSUME_NONNULL_END
