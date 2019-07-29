//
//  GACommentTextView.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SendCommentProtocol <NSObject>

- (void)sendComment:(NSString*)text;
@end

@interface GACommentTextView : UIView
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) void(^sendComment)(NSString*text);

@property(nonatomic,weak) id<SendCommentProtocol> delegate;

- (void)show;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
