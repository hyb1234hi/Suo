//
//  GASharePopView.m

#import "GASharePopView.h"

/*
#import "VideoItem.h"
#import "ImageItem.h"
#import "StatusItem.h"
#import "LCDownloadManager.h"
#import <WXApi.h>
*/

@interface GASharePopView ()
@property(nonatomic,strong)  UIVisualEffectView *visualEffectView;
//@property(nonatomic,strong) BaseItem *item;
@end

@implementation GASharePopView
//
//+ (instancetype)shareItem:(BaseItem *)item{
//    SharePopView *pop = [[self alloc] initWithItem:item];
//    [pop show];
//    return pop;
//}
//- (instancetype)initWithItem:(BaseItem *)item{
//
//    _item = item; //初始化ui 要用到
//
//    if (self = [self init]) {
//
//    }
//    return self;
//}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *topIconsName = @[
                                 @"icon_profile_share_wxTimeline",
                                 @"icon_profile_share_wechat",
                                 @"icon_profile_share_qqZone",
                                 @"icon_profile_share_qq",
                                 @"icon_profile_share_weibo",
                                 @"iconHomeAllshareXitong"
                                 ];
        NSArray *topTexts = @[
                             @"朋友圈",
                             @"微信好友",
                             @"QQ空间",
                             @"QQ好友",
                             @"微博",
                             @"更多分享"
                             ];
        
        NSArray *bottomIconsName = @[
                                 @"icon_home_allshare_download",
                                 @"icon_home_like_before",
                                 @"icon_home_all_share_dislike",
                                ];
            
    
        NSArray *bottomTexts = @[
                                @"下载",
                                @"喜欢",
                                @"不喜欢",
                                ];
        
        self.frame = ScreenBounds;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 280 + SafeAreaBottomHeight)];
        _container.backgroundColor = ColorBlackAlpha60;
        [self addSubview:_container];
        
        
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:_container.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        _container.layer.mask = shape;
        
        UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        visualEffectView.frame = self.bounds;
        visualEffectView.alpha = 1.0f;
        self.visualEffectView = visualEffectView;
        [_container addSubview:visualEffectView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.text = @"分享到";
        label.textColor = ColorGray;
        label.font = MediumFont;
        [_container addSubview:label];
        
        
        CGFloat itemWidth = 68;
        
        UIScrollView *topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, ScreenWidth, 90)];
        topScrollView.contentSize = CGSizeMake(itemWidth * topIconsName.count, 80);
        topScrollView.showsHorizontalScrollIndicator = NO;
        topScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 30);
        [_container addSubview:topScrollView];
        
        for (NSInteger i = 0; i < topIconsName.count; i++) {
            ShareItem *item = [[ShareItem alloc] initWithFrame:CGRectMake(20 + itemWidth*i, 0, 48, 90)];
            item.icon.image = [UIImage imageNamed:topIconsName[i]];
            item.label.text = topTexts[i];
            item.tag = i;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onShareItemTap:)]];
            [item startAnimation:i*0.03f];
            [topScrollView addSubview:item];
        }
        
        UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 130, ScreenWidth, 0.5f)];
        splitLine.backgroundColor = ColorWhiteAlpha10;
        [_container addSubview:splitLine];
        
        UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 135, ScreenWidth, 90)];
        bottomScrollView.contentSize = CGSizeMake(itemWidth * bottomIconsName.count, 80);
        bottomScrollView.showsHorizontalScrollIndicator = NO;
        bottomScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 30);
        [_container addSubview:bottomScrollView];
        
        for (NSInteger i = 0; i < bottomIconsName.count; i++) {
            ShareItem *item = [[ShareItem alloc] initWithFrame:CGRectMake(20 + itemWidth*i, 0, 48, 90)];
            item.icon.image = [UIImage imageNamed:bottomIconsName[i]];
            item.label.text = bottomTexts[i];
            item.tag = i;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onActionItemTap:)]];
            [item startAnimation:i*0.03f];
            [bottomScrollView addSubview:item];
        }
        
        
        _cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 230, ScreenWidth, 50 + SafeAreaBottomHeight)];
        [_cancel setTitleEdgeInsets:UIEdgeInsetsMake(-SafeAreaBottomHeight, 0, 0, 0)];
        
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel setTitleColor:ColorWhite forState:UIControlStateNormal];
        _cancel.titleLabel.font = BigFont;

        _cancel.backgroundColor = ColorGrayLight;
        [_container addSubview:_cancel];
        
        UIBezierPath* rounded2 = [UIBezierPath bezierPathWithRoundedRect:_cancel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
        CAShapeLayer* shape2 = [[CAShapeLayer alloc] init];
        [shape2 setPath:rounded2.CGPath];
        _cancel.layer.mask = shape2;
        [_cancel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
    }
    return self;
}

- (void)onShareItemTap:(UITapGestureRecognizer *)sender {
//    __weak typeof(self) wself = self;
//        //腾讯分享
//    void(^TXShare)(enum WXScene scene) = ^(enum WXScene scene){
//
//        WXMediaMessage * message = [WXMediaMessage message];
//        message.title = wself.item.title;
//
//        switch (wself.item.itemType) {
//            case ModelItemTypeNews:{
//
//                WXWebpageObject *web = [WXWebpageObject object];
//                web.webpageUrl = ShareItemPath(wself.item.identifier);
//                message.mediaObject = web;
//            }break;
//
//            case ModelItemTypeVideo:{
//                WXWebpageObject *web = [WXWebpageObject object];
//                web.webpageUrl = ShareItemPath(wself.item.identifier);
//                message.mediaObject = web;
//            }break;
//
//            case ModelItemTypeImage:{
//                WXWebpageObject *web = [WXWebpageObject object];
//                web.webpageUrl = ShareItemPath(wself.item.identifier);
//                message.mediaObject = web;
//                    //WXImageObject *image = [WXImageObject object];
//
//            }break;
//        }
//
//        SendMessageToWXReq * req = [[SendMessageToWXReq alloc] init];
//        req.bText = NO;
//        req.message = message;
//        req.scene = scene;
//        [WXApi sendReq:req];
//    };
//
//
//    ShareActionType type ;
//    switch (sender.view.tag) {
//        case 0:{
//            type = ShareActionTypeWeChatFriendsCircle;
//            TXShare(WXSceneTimeline);
//        }
//            break;
//        case 1:
//            type = ShareActionTypeWeChatFriend;
//            TXShare(WXSceneSession);
//            break;
//
//        case 2:
//            type = ShareActionTypeQQZone;
//            break;
//        case 3:
//            type = ShareActionTypeQQFriend;
//            break;
//        case 4:
//            type = ShareActionTypeSinaWeibo;
//            break;
//
//        default:
//            type = ShareActionTypeWeChatFriendsCircle;
//            break;
//    }
//    if (self.ShareAction) {
//        self.ShareAction(type);
//    }
    
    [self dismiss];
}

- (void)onActionItemTap:(UITapGestureRecognizer *)sender {
//    switch (sender.view.tag) {
//        case 0:{
//            //download
////            UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
////
////            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
////            [hud setMode:MBProgressHUDModeDeterminate];
//
//            VideoItem *video = (VideoItem*)self.item;
//            [[LCDownloadManager shareManager] downloadItem:video withProgress:^(NSProgress * _Nonnull progress) {
//
////                dispatch_async(dispatch_get_main_queue(), ^{
////
////                    NSString *text = [progress.localizedDescription stringByReplacingOccurrencesOfString:@"completed" withString:@""];
////                    [hud.label setText:text];
////                    CGFloat pro = text.floatValue / 100;
////                    [hud setProgress:pro];
////
////                    if (progress.totalUnitCount == progress.completedUnitCount) {
////                        [hud removeFromSuperview];
////                        [self showHUDToView:nil withMessage:@"下载完成"];
////                    }
////                });
//            }];
//        }break;
//
//        default:
//            break;
//    }
    [self dismiss];
}


- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point]) {
        [self dismiss];
        return;
    }
    point = [sender locationInView:_cancel];
    if([_cancel.layer containsPoint:point]) {
        [self dismiss];
    }
}

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y - frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y + frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}


@end



#pragma Item view

@implementation ShareItem
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"iconHomeAllshareCopylink"];
        _icon.contentMode = UIViewContentModeScaleToFill;
        _icon.userInteractionEnabled = YES;
        [self addSubview:_icon];
        
        _label = [[UILabel alloc] init];
        _label.text = @"TEXT";
        _label.textColor = ColorWhiteAlpha60;
        _label.font = MediumFont;
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    return self;
}
-(void)startAnimation:(NSTimeInterval)delayTime {
    CGRect originalFrame = self.frame;
    self.frame = CGRectMake(CGRectGetMinX(originalFrame), 35, originalFrame.size.width, originalFrame.size.height);
    [UIView animateWithDuration:0.9f
                          delay:delayTime
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = originalFrame;
                     }
                     completion:^(BOOL finished) {
                     }];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(48);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.icon.mas_bottom).offset(10);
    }];
}

@end


@interface ActionPopView ()<CAAnimationDelegate>

//@property(nonatomic,strong) VideoItem *item;
@property(nonatomic,strong) UIScrollView *container;
@end

@implementation ActionPopView
//+ (instancetype)ActionViewWithItem:(VideoItem *)item{
//    ActionPopView *pop = [[self alloc] initWithItem:item];
//    [pop show];
//    return pop;
//}
//
//- (instancetype)initWithItem:(VideoItem *)item{
//    _item = item;
//    if (self = [self init]) {
//    }
//    return self;
//}

- (instancetype)init{
    if (self = [super init]) {
        [self setBackgroundColor:ColorBlackAlpha20];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)]];
        
        [self setFrame:ScreenBounds];
        CGFloat itemWidth = 68;
        NSArray<NSDictionary*> *iconName = @[@{@"下载":@"icon_home_allshare_download"},
                                             @{@"收藏":@"icon_home_like_before"},
                                             ];
        
        _container =  [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-100, 90)];
        [_container setBackgroundColor:ColorBlackAlpha80];
        _container.contentSize = CGSizeMake(itemWidth * iconName.count, 80);
        _container.showsHorizontalScrollIndicator = NO;
        _container.contentInset = UIEdgeInsetsMake(0, 0, 0, 30);
        
        
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:_container.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10.0f, 10.0f)];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        _container.layer.mask = shape;
        
        UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        visualEffectView.frame = _container.bounds;
        visualEffectView.alpha = 1.0f;

            //self.visualEffectView = visualEffectView;
        [_container addSubview:visualEffectView];
        [visualEffectView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self->_container);
        }];
        
        
        [iconName enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
                ShareItem *item = [[ShareItem alloc] initWithFrame:CGRectMake(20 + itemWidth*idx, 0, 48, 90)];
                [item.icon setImage:[UIImage imageNamed:value]];
                [item.label setText:key];
                item.tag = idx;
                [item addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onActionItemTap:)]];
                [item startAnimation:idx*0.03];
                [self->_container addSubview:item];
            }];
        }];
    
        
        [self addSubview:_container];
        [_container mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-100, 90));
        }];
        
    }
    return self;
}

- (void)onActionItemTap:(UITapGestureRecognizer *)sender{
   // CheckUserLogin;
    
    
    UIImpactFeedbackGenerator *feed = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    [feed impactOccurred];
    ShareItem *item = (ShareItem*)sender.view;
    switch (item.tag) {
        case 0:
            //下载
            [self animationWithView:item.icon];
            break;
            
        case 1:
            //收藏
            [self animationWithView:item.icon];
//            [LCDataStore.new addCollectionContent:self.item.identifier authkey:self.currentUser.authkey competion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
//                NSLog(@"json -- %@",json);
//            }];
            break;
            
        default:
            break;
    }
}

- (void)animationWithView:(UIImageView*)imageView{
    CGRect viewFram = [imageView convertRect:imageView.frame toView:[UIApplication sharedApplication].delegate.window];
    //CGRect originalFram = imageView.frame;
    
    UIImageView *animationView = [[UIImageView alloc] initWithFrame:viewFram];
    [animationView setImage:imageView.image];
    [self addSubview:animationView];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //设置属性
    animation.toValue = @(M_PI *11);
    animation.duration = 1;
    animation.cumulative = true;
    animation.repeatCount = 0;
        //初始化抛物线动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPoint = animationView.center;
    CGPoint endPoint = CGPointMake(ScreenWidth-90, ScreenHeight+10);
        //抛物线的顶点,可以根据需求调整
    CGPoint controlPoint = CGPointMake(viewFram.origin.x+200, viewFram.origin.y - 300);
        //生成路径
    CGMutablePathRef path = CGPathCreateMutable();
        //描述路径
    CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y);
    CGPathAddQuadCurveToPoint(path, nil, controlPoint.x, controlPoint.y, endPoint.x, endPoint.y);
        //设置属性
    pathAnimation.duration = 1;
    pathAnimation.path = path;
        //初始化动画组
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.animations = @[animation,pathAnimation];
    animationGroup.duration = 1;
    animationGroup.delegate = self;
        //延时的目的是让view先做UIView动画然后再做layer动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [animationView.layer addAnimation:animationGroup forKey:nil];
        
    });
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //NSLog(@"animation finish");
// 
//    [[LCDownloadManager shareManager] downloadItem:self.item withProgress:^(NSProgress * _Nonnull progress) {
//    }];
    
    [self dismiss];
}

- (void)show{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
}

- (void)dismiss{
    [self removeFromSuperview];
    
    
    
    
//    [UIView animateWithDuration:0.35 animations:^{
//        [self setAlpha:0];
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
}

@end
