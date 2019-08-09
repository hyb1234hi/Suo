//
//  GAShootControllerView.m
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAShootControllerView.h"
#import "GARecordButton.h"

#import "GAOpenLiveControlView.h"
#import "GARecordControlView.h"

#import <UIButton+LXMImagePosition.h>


@interface GAShootControllerView ()<GAOpenLiveControllerDelegate>

//底部视频分类按钮
@property(nonatomic,strong)UIButton *uploadBtn;     //!<上传按钮
@property(nonatomic,strong)UIButton *shootBtn;      //!<拍摄按钮
@property(nonatomic,strong)UIButton *liveBtn;       //!<直播按钮
@property(nonatomic,strong)UIButton *kSong;         //!<k歌


@property(nonatomic,strong)GAOpenLiveControlView *openLiveView;
@property(nonatomic,strong)GARecordControlView *recordView;

@end

@implementation GAShootControllerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    UIButton*(^createButton)(NSString*,NSString*,LXMImagePosition) = ^(NSString*title,NSString*image,LXMImagePosition pos){
        UIButton *button = UIButton.new;
        [button setTitle:title forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [button.titleLabel setFont:[MainFont fontWithSize:14]];
        
        [button setImagePosition:pos spacing:2];
        return button;
    };

/*
    //bottom button
    ({
        LXMImagePosition bottom = LXMImagePositionBottom;
        _uploadBtn = createButton(@"上传",@"",bottom);
        _shootBtn = createButton(@"拍摄",@"",bottom);
        _liveBtn = createButton(@"直播",@"",bottom);
        _kSong = createButton(@"K歌",@"",bottom);
        
        NSArray<UIView*> *views = @[_uploadBtn,_shootBtn,_liveBtn,_kSong];
        for (UIView *view in views) {
            [self addSubview:view];
        }
        [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:SafeAreaTopHeight tailSpacing:50];
        [views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 60));
            make.bottom.mas_equalTo(-SafeAreaBottomHeight-20);
        }];
        
        [_liveBtn addTarget:self action:@selector(toggleLive:) forControlEvents:UIControlEventTouchUpInside];
        [_shootBtn addTarget:self action:@selector(toggleShooting:) forControlEvents:UIControlEventTouchUpInside];
    });
*/
    
    _openLiveView = GAOpenLiveControlView.new;
    [_openLiveView setFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 200)];
    _openLiveView.delegate = self;
    
//    _recordView = GARecordControlView.new;
//    [self addSubview:_recordView];
//    [_recordView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.mas_equalTo(self);
//        make.bottom.mas_equalTo(self.liveBtn.mas_top).inset(34);
//    }];
    
    [self toggleLive:nil];
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
//    NSArray<UIView*> *views = @[_uploadBtn,_shootBtn,_liveBtn,_kSong];
//    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:50 tailSpacing:50];
//    [views mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(30, 60));
//        make.bottom.mas_equalTo(-SafeAreaBottomHeight-20);
//    }];
    
}

- (void)toggleShooting:(UIButton*)send{
    [self.openLiveView setHidden:YES];
    [self.recordView setHidden:NO];
    
}

- (void)toggleLive:(UIButton*)send{
    [self addSubview:_openLiveView];
    
    [self.openLiveView setHidden:NO];
    [self.recordView setHidden:YES];
    [self.openLiveView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).inset(SafeAreaBottomHeight+40);
        //make.bottom.mas_equalTo(self.liveBtn.mas_top).inset(34);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}


#pragma mark - GAOpenLiveControllerDelegate
-(void)startLive{
    if ([self.delegate respondsToSelector:@selector(startLiveDidClick)]) {
        [self.delegate startLiveDidClick];
    }
}
- (void)switchCamera{
    if ([self.delegate respondsToSelector:@selector(switchLensDidClick)]) {
        [self.delegate switchLensDidClick];
    }
}

@end
