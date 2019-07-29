//
//  GASharePopView.h

#import <UIKit/UIKit.h>
//#import "VideoItem.h"


typedef enum : NSUInteger {
    ShareActionTypeWeChatFriend,        //!<微信朋友
    ShareActionTypeWeChatFriendsCircle, //!<微信朋友圈
    ShareActionTypeSinaWeibo,           //!<新浪微博
    ShareActionTypeQQZone,              //!<qq空间
    ShareActionTypeQQFriend,            //!<qq好友
} ShareActionType;

@interface GASharePopView:UIView

@property (nonatomic, strong) UIView           *container;
@property (nonatomic, strong) UIButton         *cancel;
@property(nonatomic,strong) void(^ShareAction)(ShareActionType shareType);

//+ (instancetype)shareItem:(BaseItem*)item;
//- (instancetype)initWithItem:(BaseItem*)item;
- (void)show;
- (void)dismiss;

@end

@interface ShareItem:UIView

@property (nonatomic, strong) UIImageView      *icon;
@property (nonatomic, strong) UILabel          *label;

-(void)startAnimation:(NSTimeInterval)delayTime;

@end


@interface ActionPopView : UIView
//+ (instancetype)ActionViewWithItem:(VideoItem*)item;
//- (instancetype)initWithItem:(VideoItem*)item;

- (void)show;
- (void)dismiss;
@end
